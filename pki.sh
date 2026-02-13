#!/bin/bash

fqdn="localhost"
mail="."
PWD=$(pwd)
TMP="/tmp/pki"
rm -rf $TMP
cd "$TMP"

helpcmd () {
    echo "Usage: ./pki.sh -s api.localhost.rvid.eu"
}

while getopts ":n:v" opt; do
  case $opt in
    s) fqdn="$OPTARG" ;;
    m) mail="$OPTARG" ;;
    h) helpcmd ;;
  esac
done

echo -e "\033[92mGenerating CA certificates.\033[0m"

mkdir -p /dev/shm/mtls
chmod 700 /dev/shm/mtls

openssl genrsa -out /dev/shm/mtls/CA.key 4096
openssl req -new -x509 -key /dev/shm/mtls/CA.key -out CA.pem \
    -subj "/CN=${fqdn}/emailAddress=${mail}" \
    -sha256

echo -e "\033[92mGenerating client certificates (mTLS)\033[0m"

openssl req -newkey rsa:4096 -nodes -keyout client.key -out client.csr -subj "/CN=actions" # Client key and csr
openssl x509 -req -in client.csr -CA CA.pem -CAkey /dev/shm/mtls/CA.key -out client.pem -sha256 # Client certificate

printf "\n\n"
echo -e "\033[92mCERT docker environment variable \033[0m:"
base64 client.pem -w 0
printf "\n\n\n"

#cd "$PWD"
rm -rf /dev/shm/mtls 
echo -e "\033[32mcertificates can be directly mounted. The certificates are located at \033[0m$TMP"
echo -e "\033[32mPRIVKEY (actions secret) should be\033[0m client.key\n\033[32mCERT (actions secret) should be \033[0m client.pem"
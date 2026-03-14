#!/bin/bash

echo -e "\e[1;36mGenerating SSH keys for the backend.\e[0m"
mkdir -p /tmp/pki
ssh-keygen -t ed25519 -f /tmp/pki/ssh -q -N ""
echo -e "\e[1;32mSSH keys generated\e[0m."

echo -e "\e[1;36mGitHub Actions secret PRIVKEY:\e[0m"
cat /tmp/pki/ssh

echo -e "\e[1;36mDocker environment variable SSH:\e[0m"
cat /tmp/pki/ssh.pub
# Quick start

Instructions on initial installation is here. It will provide initial setup. It's recommended to do it in this order.

## Action

You can drop this into your already existing workflow.  
```yaml { .copy }
  - uses: publish-site/action@INDEV
    with:
        dir: dir/ # CHANGEME
        url: https://example.com/ # CHANGEME
        privkey: ${{ secrets.PRIVKEY }}
        cert: ${{ secrets.CERT }}
```
**Make sure to replace URL and dir with the right entries**  

??? "Example workflow"
    Place this file in `.github/workflows/workflow.yml`. It will trigger whenever you push.  

    ```yaml  { .copy title="workflow.yml" }
    name: Deployment
    on:
    push:
    jobs:
    deploy:
        name: Deployment
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@v4
        - uses: publish-site/action@INDEV
            with:
            dir: dir/
            url: https://example.com/
            privkey: ${{ secrets.PRIVKEY }}
            cert: ${{ secrets.CERT }}
    ```


## PKI

Start by generating the public key infrastructure files. Make sure to keep these somewhere safe:

```bash { .copy }
curl https://publish-site.rvid.eu/pki.sh | bash -
cd /tmp/pki
```  

Make sure to note down the Base64 string from the script, it will be used later.  

??? "GitHub secrets"
    You'll put your keys here.
    Create two secrets, CERT and PRIVKEY
    ![GitHub actions secret](img/docs.avif)
    Paste the contents of client.key to PRIVKEY secret
    ![GitHub actions privkey](img/privkey.avif)
    And paste the contents of client.pem to CERT secret
For more advanced configuration and it's properties go to [Action configuration](config/action.md)


## Backend

For now, only docker (compose) is officially supported.
??? "Docker Compose"

    ```yaml { .copy title=docker-compose.yaml }
    services:
    deploy-server:
        image: ghcr.io/publish-site/backend:latest
        ports: 
        - "443:443"
        environment:
        API_URL: "changeme"
        ## Instead of mounting the TLS certificates you can base64 them and do inline certificates.
        #FULLCHAIN:
        ## NOTE: This is not the privkey certificate generated from the PKI script. TLS Certificates
        ## PRIVKEY:

        CLIENT_CA: # The base64 string from PKI script
        volumes:
        - /your/certificate/path/fullchain.pem:/etc/nginx/ssl/fullchain.pem:ro
        - /your/certificate/path/privkey.pem:/etc/nginx/ssl/privkey.pem:ro
        ## You can also mount the CA directly 
        #- /your/certificate/path/ca.pem:/etc/nginx/ssl/ca.pem:ro
    ```


??? "Docker run (CLI)"
    ```bash { .copy }
    docker run -p 443:443 -e API_URL=changeme -e CLIENT_CA= ghcr.io/publish-site/backend:latest
    ```
For more detailed configuration and it's properties, go to [backend config](config/backend).
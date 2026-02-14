# Backend configuration

You **can't** run the API behind a reverse proxy.

## Docker compose example

??? Compose
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
    - changeme/web/dir/:/var/www/html # for persistence between container reboots
```
## Configuration variables


| **ENV Var** | **Description**                                                                    |   | Example                  | note                                                                                                                                                                  |
| ------------- | ------------------------------------------------------------------------------------ | :-: | -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| API_URL     | The DNS domain for the API                                                         | * | https://api.example.com/ |                                                                                                                                                                       |
| CLIENT_CA   | Base64 encoded CA certificate to verify the client (CA.pem)                        |   | {BASE64}                 | If CLIENT_CA isn't set a certificate must be mounted to /etc/nginx/ssl/ca.pem                                                                                         |
| FULLCHAIN   | Base64 encoded fullchain certificate for SSL/TLS (fullchain.pem) [NOT RECOMMENDED] |   | {BASE64}                 | If FULLCHAIN isn't set a certificate must be mounted to /etc/nginx/ssl/fullchain.pem. This is the recommended way of doing it.                                        |
| PRIVKEY     | Base64 encoded private key for SSL/TLS (privkey.pem) [NOT RECOMMENDED]             |   | {BASE64}                 | If PRIVKEY isn't set a certificate must be mounted to /etc/nginx/ssl/privkey.pem. This is the recommended way of doing it.                                            |
| BODY_SIZE   | The maximum body size (payload)                                                    |   | 2000M                    | It is untested what happens if it's above the amount of allocated RAM to the container. If your body size is below the payload size you'll get 413 PAYLOAD TOO LARGE. |

**required*

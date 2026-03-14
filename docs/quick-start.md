# Quick start

Instructions on initial installation is here. It will provide initial setup. It's recommended to do it in this order.

## Action

You can drop this into your already existing workflow.  
```yaml { .copy }
  - uses: publish-site/action@INDEV
    with:
        dir: dir/ # CHANGEME
        ip: example.com # Public IP Address or FQDN
        privkey: ${{ secrets.PRIVKEY }}
```
**Make sure to replace URL and dir with the right entries**  

??? Dependencies
    Debian:
    ```
    sudo apt install docker.io docker-cli docker-compose
    ```
    For other distributions there are similar package names!

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
        - uses: publish-site/action@v2
        with:
            dir: dir/
            ip: example.com
            privkey: ${{ secrets.PRIVKEY }}
    ```


## PKI

Start by generating the public key infrastructure files. Make sure to keep these somewhere safe:

```bash { .copy }
curl https://publish-site.rvid.eu/pki.sh | bash -
cd /tmp/pki
```  

??? "GitHub secrets"
    You'll put your keys here.
    Create two secrets, PRIVKEY
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
            - "127.0.0.1:8080:8080/tcp"
            - "2222:2222/tcp"
            environment:
                SSH: "ssh-ed25519 ..." # The string from PKI script
            volumes:
            - ./html:/var/www/html # for persistence between restarts.
            - ./ssh:/etc/ssh/ # SSH Host Keys, do not touch.
    ```


??? "Docker run (CLI)"
    ```bash { .copy }
    docker run -p 8080:8080 -e SSH="ssh-ed25519 ... ghcr.io/publish-site/backend:latest
    ```
For more detailed configuration and it's properties, go to [backend config](config/backend.md).
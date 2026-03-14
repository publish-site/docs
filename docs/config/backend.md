# Backend configuration

You **can't** run the API behind a reverse proxy.

## Docker compose example

??? Compose

```yaml { .copy title=docker-compose.yaml }
services:
  deploy-server:
    image: ghcr.io/publish-site/backend:latest
    ports: 
      - 8080:8080/tcp 
      - 2222:2222/tcp
    volumes:
      - ./html:/var/www/html
      - ./ssh:/etc/ssh/ # SSH Host Keys
    environment:
        SSH: "ssh-..." # The string from PKI script
```
You can use the PHP image at `ghcr.io/publish-site/backend:php` for a PHP backend.

## Configuration variables


| **ENV Var** | **Description**                |   | Example                 | note           |
| ------------- | -------------------------------- | :-- | ------------------------- | ---------------- |
| SSH         | SSH Public key from PKI script | * | ssh-ed25519 AAAAC3..... | SSH Public key |

**required*

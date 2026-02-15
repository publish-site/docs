# Action configuration

## Workflow implementation

```yaml { .copy }
  - uses: publish-site/action@v1
    with:
        dir: site/ # CHANGEME
        url: https://api.example.com/ # CHANGEME
        privkey: ${{ secrets.PRIVKEY }}
        cert: ${{ secrets.CERT }}
```

## Input table


| input   | description                                                       |   | example                                        |
| :-------- | ------------------------------------------------------------------- | --- | ------------------------------------------------ |
| dir     | The directory to deploy                                           | * | site/                                          |
| url     | The API URL for the deployment                                    | * | https://api.example.com                        |
| privkey | The client private key (client.key). Should be a secret           | * | ${{ secrets.PRIVKEY }}                         |
| cert    | The client certificate (client.pem). Should be a secret           | * | ${{ secrets.CERT }}                            |
| dry_run | [Boolean] If the server should take action or not. Default false. |   | ${{ inputs.dry_run }} (from workflow_dispatch) |

**required*

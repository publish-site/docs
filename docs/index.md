# Home

This project provides a simple and secure way to deploy a website directly from a Git Repository.  
For a initial setup, go to [quick start guide](quick-start.md).  

## Tree  

There are 3 main parts of this documentation:  

* [Quick Start Guide](quick-start.md)
* [Backend configuration](config/backend.md)
* [Action configuration](config/action.md)

## Limitations

At the moment, the NGINX configuration only allows sites to about 2000M (before compression). This can however be changed in the configuration of the container.  
Non-repudiation (for the server party) and integrity has not been implemented yet.  

## License disclaimer

This project is licensed under the [unlicense](https://unlicense.org).  
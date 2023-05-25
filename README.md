# Relative Path

This repository contains scripts for setting up a Raspberry Pi Server to host two Node.js Express applications, one named relativepath and the other expressapi. The server is set up with Nginx as a reverse proxy that routes incoming traffic to the respective applications based on the requested paths.

## Structure
1. `pi_local.sh`: This is the main script which is run from the local system. It communicates with the Raspberry Pi server, copies necessary files, and runs the various installation and setup scripts on the server.

2. `nginx_install.sh`: Installs and sets up Nginx on the Raspberry Pi server. It establishes a reverse proxy that listens on port 80, and routes the incoming traffic to the respective applications.

3. `api_deploy.sh`: Clones the expressapi repository and installs its dependencies.

4. `service.sh`: Sets up the services for the expressapi and the main application to ensure they run correctly on the server.

5. `relativepath.conf`: This Nginx configuration file is used to route incoming requests to the respective applications. It sets up a reverse proxy to forward requests at the root path to the relativepath application running at localhost:3000, and requests to '/api' to the expressapi application running at localhost:3001.



The following diagram illustrates the Nginx setup:

                                   +------------+
                                   |   macOS    |
                                   |   Client   |
                                   +-----+------+
                                         |
                                         | HTTP Request (port 80)
                                         v
                                  +------+-------+
                                  |   Raspberry  |
                                  |   Pi Server  |
                                  |   (Nginx)    |
                                  +-----+--------+
                                        |
                                        | Proxy Pass
                                        v
                         +--------------+-------------+
                         |                            |
                         v                            v
            +------------+----------+      +----------+-------------+
            |   relativepath app    |      |    expressapi app      |
            |   (localhost:3000)    |      |   (localhost:3001)     |
            +-----------------------+      +------------------------+

##Prerequisites
* A Raspberry Pi running Ubuntu Server.
* SSH access to the Raspberry Pi.
* The hostname of your Raspberry Pi set to pi.

## Usage
From your local system (macOS), use the following command to run the `pi_local.sh` script:

```bash
PI_HOST=$(dig +short pi | tail -n1) bash pi_local.sh
```

The `pi_local.sh` script, run from your local system, connects to the Raspberry Pi server, copies required files, and invokes installation and setup scripts on the server. Once the script completes, it opens an SSH session to the Pi server, where your applications are now ready to serve requests.
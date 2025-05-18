# Lea-Server
<!-- [![Deploy](https://github.com/Lea-Voc/Lea-Server/actions/workflows/deploy.yml/badge.svg)](https://github.com/Lea-Voc/Lea-Server/actions/workflows/deploy.yml) -->

Contains all configuration files for the servers. Used by Lea-Back, Lea-Website and Lea-Web-App

All Lea services running on the server are runned in a Docker container. All Docker containers are runned through a [docker-compose cofiguration](https://github.com/Pandatec/Lea-Assistant_Server/blob/main/docker-compose.yml).

## How to restarts all the container

In case of an fatal error only, all the docker container can be restarted by loggin into the CI account on the VPS and then do into the `Lea-Server` directory, and run `docker-compose down && docker-compose up -d`

## List of docker containers

Here is a list of all docker container running on the server with their description and docker images.

### API and WS production server
This Node.js process is the production server used for the HTTP API and the websocket server. It runs with the real GCP database and must NEVER be used for development purpose.

* Container name: lea_api_prod
* Directory: /home/CI/Lea-Back-Prod/
* Restart file: /home/CI/Lea-Server/deployApiProd.sh
* Base repository: [Lea-Back](https://github.com/Pandatec/Lea-Assistant_BackEnd) 'main' branch
<!-- * URL: [https://api.leassistant.fr](api.leassistant.fr) -->

### API and WS development server
This Node.js process is the development server used for the HTTP API and the websocket server. It runs on the development database and should be the one used for ALL development purpose.

* Container name: lea_api_dev
* Directory: /home/CI/Lea-Back-Dev/
* Restart file: /home/CI/Lea-Server/deployApiDev.sh
* Base repository: [Lea-Back](https://github.com/Lea-Voc/Pandatec/Lea-Assistant_BackEnd) 'stagging' branch
* Depends on: [Development database](#development-database)
<!-- * URL: [https://dev.api.leassistant.fr](dev.api.leassistant.fr) -->

### Web app production version
This Node.js process is the production version used for the web application. It makes request to the [API and WS production server](#api-and-ws-production-server)

* Container name: lea_app_prod
* Directory: /home/CI/Lea-Web-App-Prod/
* Restart file: /home/CI/Lea-Server/deployAppProd.sh
* Base repository: [Lea-Web-App](https://github.com/Pandatec/Lea-Assistant_Web-Connect) 'main' branch
<!-- * URL: [https://app.leassistant.fr](app.leassistant.fr) -->

### Web app develoment version
This Node.js process is the development version used for the web application. It makes request to the [API and WS development server](#api-and-ws-development-server)

* Container name: lea_app_dev
* Directory: /home/CI/Lea-Web-App-Dev/
* Restart file: /home/CI/Lea-Server/deployAppDev.sh
* Base repository: [Lea-Web-App](https://github.com/Pandatec/Lea-Assistant_Web-Connect) 'staging' branch
<!-- * URL: [https://dev.app.leassistant.fr](dev.app.leassistant.fr) -->

### API Documentation
This Swagger UI container hosts the online API documentation.

* Container name: swagger-ui
* Directory: /home/CI/Lea-Doc/
* Restart file: /home/CI/Lea-Server/deployDoc.sh
<!-- * Base repository: [Lea-Doc](https://github.com/Lea-Voc/Lea-Doc) 'main' branch -->
<!-- * URL: [doc.leassistant.fr](https://doc.leassistant.fr) -->

### HTPP Forwarder
This Nginx process forwards all the HTTP request to their respective container. It also handles all the HTTPS setup for all the subdomains. It waits until all the other containers are started to start.

* Container name: nginx
* Depends on: [API and WS development server](#api-and-ws-development-server), [API and WS production server](#api-and-ws-production-server), [Web app development version](web-app-development-version), [Web app production version](web-app-production-version) and [API Documentation](api-documentation)

### Development database
This Google Datastore emulator is used by the [API and WS development server](#api-and-ws-development-server), all the local version used for development of the backend server and the local build of the Lea mobile app.

* Container name: datastore

### Test database
This Google Datastore emulator is used to run test for the backend server CI. This database is flushed and should never be used to store any relevant informations.

* Container name: datastore_test

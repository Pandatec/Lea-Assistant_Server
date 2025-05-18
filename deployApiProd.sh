#!/bin/bash
docker-compose up -d --no-deps --build lea_api_prod
docker-compose restart lea_api_prod
docker-compose restart nginx
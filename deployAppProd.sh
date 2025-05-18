#!/bin/bash
docker-compose up -d --no-deps --build lea_app_prod
docker-compose restart lea_app_prod
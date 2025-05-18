#!/bin/bash
docker-compose up -d --no-deps --build swagger-ui
docker-compose restart swagger-ui
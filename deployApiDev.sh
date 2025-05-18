#!/bin/bash
docker-compose up -d --no-deps --build lea_api_dev
docker-compose restart lea_api_dev
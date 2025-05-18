#!/bin/bash
docker-compose up -d --no-deps --build lea_website
docker-compose restart lea_website
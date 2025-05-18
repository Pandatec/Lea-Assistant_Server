#!/bin/bash
docker-compose up -d --no-deps --build lea_throttle
docker-compose restart lea_throttle
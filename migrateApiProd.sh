#!/bin/bash
docker exec -it lea_api_prod npm run migrate --name="$1"

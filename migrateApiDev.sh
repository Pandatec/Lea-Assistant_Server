#!/bin/bash
docker exec -it lea_api_dev npm run migrate --name="$1"

#!/bin/sh

NREF=$(echo "$1" | sed -e "s:refs/tags/v::g")
VER=$(echo "$NREF" | sed -e "s:r::g")
CONT=""
ADM_PORT=""
if [ "$VER" != "$NREF" ]
then
	CONT=prod
	ADM_PORT=8686
else
	CONT=dev
	ADM_PORT=8687
fi

DIR=/app/build/device_android

echo "Container: $CONT, version: $VER, adm port: $ADM_PORT"
docker exec lea_api_$CONT ls -la "$DIR"

docker exec lea_api_$CONT find "$DIR" -type f -delete
echo "Emptied $DIR"
docker exec lea_api_$CONT ls -la "$DIR"

docker exec lea_api_$CONT touch "$DIR/lea_mobile_$VER.aab"
echo "Created $DIR/lea_mobile_$VER.aab"
docker exec lea_api_$CONT ls -la "$DIR"

curl -X POST "http://127.0.0.1:$ADM_PORT/build/scanBuildDeviceAndroid"
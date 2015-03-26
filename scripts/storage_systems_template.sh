#!/bin/bash

function config_value() {
  echo $(docker-machine inspect $DEMO_MACHINE_NAME | grep -i "\"$1\"" | awk '{print $2}' | sed  -e 's/,$//g' -e 's/"//g')
}

DEMO_MACHINE_NAME=$1
DOCKER_HOST_IP=$(docker-machine ip)
DOCKER_HOST_PORT=22
DOCKER_HOST_USERNAME=$(docker-machine ssh $DEMO_MACHINE_NAME whoami)
DOCKER_HOST_PRIVATEKEY=$(cat ~/.docker/machine/machines/$DEMO_MACHINE_NAME/id_rsa | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\\\\n/g' -e 's/\//\\\//g')
DOCKER_HOST_PUBLICKEY=$(cat ~/.docker/machine/machines/$DEMO_MACHINE_NAME/id_rsa.pub | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')

DOCKER_HOST_PROVIDER=$(config_value DriverName)
DOCKER_HOST_INSTANCE_ID=$(config_value Id)
DOCKER_HOST_WORKD="\/home\/$DOCKER_HOST_USERNAME"
AGAVE_USERNAME=$(auth-check | grep username | awk '{print $2}')

# Create a date stamp to ensure the system name is fairly unique
DATESTAMP=$(date +%m%d%Y-%k%M)

for i in $(dirname $0)/../templates/systems/storage*
do
  #systems-addupdate -F - <<< \
  cat "$i" | sed -e "s/%DEMO_MACHINE_NAME/$DEMO_MACHINE_NAME/g" \
  -e "s/%DOCKER_HOST_IP/$DOCKER_HOST_IP/g" \
  -e "s/%DOCKER_HOST_PORT/${DOCKER_HOST_PORT}/g" \
  -e "s/%DOCKER_HOST_USERNAME/$DOCKER_HOST_USERNAME/g" \
  -e "s/%DOCKER_HOST_PRIVATEKEY/${DOCKER_HOST_PRIVATEKEY}/g" \
  -e "s/%DOCKER_HOST_PUBLICKEY/${DOCKER_HOST_PUBLICKEY}/g" \
  -e "s/%DOCKER_HOST_PROVIDER/${DOCKER_HOST_PROVIDER}/g" \
  -e "s/%DOCKER_HOST_INSTANCE_ID/${DOCKER_HOST_INSTANCE_ID}/g" \
  -e "s/%DOCKER_HOST_WORKD/${DOCKER_HOST_WORKD}/g" \
  -e "s/%AGAVE_USERNAME/${AGAVE_USERNAME}/g"

  # echo "Verifying storage credentials work on $AGAVE_USERNAME-$DEMO_MACHINE_NAME-storage..."
  # files-list -S "$AGAVE_USERNAME-$DEMO_MACHINE_NAME-storage" .
done

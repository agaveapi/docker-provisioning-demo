#!/bin/bash

function config_value() {
  echo $(docker-machine inspect $DEMO_MACHINE_NAME | grep -i "\"$1\"" | awk '{print $2}' | sed  -e 's/,$//g' -e 's/"//g')
}

AWS_BUCKET_NAME=$1
AWS_ACCESS_KEY=$(echo $2 | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g' -e 's/\$/\\\$/g')
AWS_SECRET_KEY=$(echo $3 | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g' -e 's/\$/\\\$/g')
AGAVE_USERNAME=$(auth-check | grep username | awk '{print $2}')

for i in $(dirname $0)/../templates/systems/s3*
do
  #systems-addupdate -F - <<< \
  cat "$i" | sed -e "s/%AWS_BUCKET_NAME/$AWS_BUCKET_NAME/g" \
  -e "s/%AWS_ACCESS_KEY/${AWS_ACCESS_KEY}/g" \
  -e "s/%AWS_SECRET_KEY/${AWS_SECRET_KEY}/g" \
  -e "s/%AGAVE_USERNAME/${AGAVE_USERNAME}/g"

  # echo "Verifying storage credentials work on %AGAVE_USERNAME-s3-storage..."
  # files-list -S "%AGAVE_USERNAME-s3-storage" .
done

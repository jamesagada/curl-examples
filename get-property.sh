#!/bin/bash -e

if [ ! -e .jwt ]; then
  echo "Please create the .jwt file using login.sh"
  exit 1
fi
read JWT < .jwt

THING="$1"
PROPERTY="$2"

if [ -z "${PROPERTY}" ]; then
  echo "Usage: get-property.sh THING PROPERTY"
  exit 1
fi

if [ ! -e .url ]; then
  echo "Please create the .url file using login.sh"
  exit 1
fi
read URL < .url

curl -H "Authorization:Bearer ${JWT}" \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 --insecure --silent \
 ${URL}/things/${THING}/properties/${PROPERTY} | python -mjson.tool

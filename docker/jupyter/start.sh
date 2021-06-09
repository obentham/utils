#!/usr/bin/env bash

IMAGE_NAME=jupyter_notebook
CONTAINER_NAME=jupyter_notebook
DEVICES="all"

if [[ $DEVICES == 'cpu' ]]
then
    DEVICE_ARG=""
else
    DEVICE_ARG="--gpus $DEVICES"
fi

function usage() {
  echo "Usage: $0 [-d workdir] [-p port] [--password password]"
  echo "  -d, --workdir     Root dir for the jupyter server (default is /home)"
  echo "  -p, --port        Port that the server will run on (default is 8888)"
  echo "  --password        Optional password"
  exit 1
}


# parse params
WORKDIR=/home
PORT=8888
JUPYTER_PASSWORD=""
while [[ "$#" > 0 ]]; do case $1 in
    -d|--workdir) WORKDIR="$2"; shift; shift;;
    -p|--port) PORT="$2"; shift; shift;;
    --password) JUPYTER_PASSWORD="$2"; shift; shift;;
    -h|--help) usage; shift; shift;;
    *) usage; shift; shift;;
esac; done

echo ""
echo "WORKDIR          = ${WORKDIR}"
echo "PORT             = ${PORT}"
echo "JUPYTER_PASSWORD = ${JUPYTER_PASSWORD}"
echo "DEVICES          = ${DEVICES}"
echo ""


docker build -t $IMAGE_NAME -f Dockerfile .
docker run -it --rm \
    $DEVICE_ARG \
    --name $CONTAINER_NAME \
    -e JUPYTER_PASSWORD=$JUPYTER_PASSWORD \
    -v $WORKDIR:/workdir/ \
    -p $PORT:8888 \
    $IMAGE_NAME

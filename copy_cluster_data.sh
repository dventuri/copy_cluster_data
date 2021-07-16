#!/bin/bash

if [[ $2 =~ ^[0-9]+$ ]]; then
  NUM=$((10#$2))  # drops leading zeros
  echo "Choosing time-step '$NUM'"
else
  echo "'$2' is an invalid argument, choose a valid time-step number."
  exit 1
fi

REMOTE=euler
MAIN_REMOTE_DIR=/home/dventuri/st_euler/$1

rsync -avzh --stats --progress \
  $REMOTE:$MAIN_REMOTE_DIR/output/ns_output_ct.$(printf %09d $NUM).hdf5 \
  $HOME/$1/output

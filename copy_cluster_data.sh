#!/bin/bash

if [[ $2 =~ ^[0-9]+$ ]]; then       # checks if 2nd argument is an integer
  NUM=$((10#$2))                    # drops leading zeros (if any)
  echo "Choosing time-step '$NUM'"
else
  echo "'$2' is an invalid argument, choose a valid time-step number."
  exit 1
fi

REMOTE=euler
MAIN_REMOTE_DIR=/home/dventuri/st_euler/$1

# copy hdf5 files
echo ""
echo "Copying HDF5 file"
if ! [ -d "$HOME/$1/output" ] ; then mkdir -p $HOME/$1/output ; fi
rsync -avh --progress \
  $REMOTE:$MAIN_REMOTE_DIR/output/ns_output_ct.$(printf %09d $NUM).hdf5 \
  $HOME/$1/output

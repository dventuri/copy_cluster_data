#!/bin/bash

REMOTE=euler
MAIN_REMOTE_DIR=/home/dventuri/st_euler/$1

# checking for valid 2nd argument (integer or "last")
if [[ $2 =~ ^[0-9]+$ ]]; then
  NUM=$((10#$2))                    # drops leading zeros (if any)
  echo "Choosing time-step '$NUM'"
elif [[ $2 == "last" ]]; then
  echo "Checking for last time-step"
  NUM=$(ssh $REMOTE ls $MAIN_REMOTE_DIR/output | grep ns_output_ct | sort -V | tail -n 1 | awk -F'[.]' '{print $2}')
  NUM=$((10#$NUM))
  echo "Last time-step is '$NUM'"
else
  echo "'$2' is an invalid argument, choose either 'last' or the time-step number."
  exit 1
fi

# copy out.txt file
echo ""
echo "Copying 'out.txt' file"
if ! [ -d "$HOME/run/$1/bin" ] ; then mkdir -p $HOME/run/$1/bin ; fi
rsync -avh --progress \
  $REMOTE:$MAIN_REMOTE_DIR/bin/out.txt \
  $HOME/run/$1/bin

# copy log files
echo ""
echo "Copying log files"
if ! [ -d "$HOME/run/$1/bin" ] ; then mkdir -p $HOME/run/$1/bin ; fi
rsync -avh --progress \
  $REMOTE:$MAIN_REMOTE_DIR/bin/log.* \
  $HOME/run/$1/bin

# copy hdf5 files
echo ""
echo "Copying HDF5 file"
if ! [ -d "$HOME/run/$1/output" ] ; then mkdir -p $HOME/run/$1/output ; fi
rsync -avh --progress \
  $REMOTE:$MAIN_REMOTE_DIR/output/ns_output_ct.$(printf %09d $NUM).hdf5 \
  $HOME/run/$1/output

#copy dpm files
echo ""
echo "Copying PVTP file"
if ! [ -d "$HOME/run/$1/output/dpm/pvtp" ] ; then mkdir -p $HOME/run/$1/output/dpm/pvtp ; fi
rsync -avh --progress \
  $REMOTE:$MAIN_REMOTE_DIR/output/dpm/pvtp/dpm_$(printf %07d $NUM).pvtp \
  $HOME/run/$1/output/dpm/pvtp
echo ""
echo "Copying VTP files"
if ! [ -d "$HOME/run/$1/output/dpm/pvtp/vtp" ] ; then mkdir -p $HOME/run/$1/output/dpm/pvtp/vtp ; fi
rsync -avh --progress \
  $REMOTE:$MAIN_REMOTE_DIR/output/dpm/pvtp/vtp/dpm_$(printf %07d $NUM)_*.vtp \
  $HOME/run/$1/output/dpm/pvtp/vtp

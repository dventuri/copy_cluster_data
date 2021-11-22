#!/bin/bash

REMOTE=euler
MAIN_REMOTE_DIR=/home/dventuri/st_euler/

declare -a arr=("sp_5x5_CoU"
                "sp_5x5_CoU_forced"
                "sp_5x5_CoU_forced_evap"
                "sp_5x5_CoF"
                "sp_5x5_CoF_forced"
                "sp_5x5_CoF_forced_evap"
                "sp_3x3_CoU_forced"
                "sp_3x3_CoU_forced_evap"
                "sp_3x3_CoF_forced"
                "sp_3x3_CoF_forced_evap"
                "sp30m_5x5_CoU_forced"
                "sp30m_5x5_CoF_forced")

for i in "${arr[@]}"
do
    echo ""
    echo "$i"

    # copy probes
    echo "Copying probes"
    if ! [ -d "$HOME/run/$i" ] ; then mkdir -p $HOME/run/$i ; fi
    rsync -avh --progress \
    $REMOTE:$MAIN_REMOTE_DIR/$i/output/probe_points \
    $HOME/run/$i/
done

#!/bin/bash
cd swarmnet
git pull


CONFIG=../config_edge.json 
LOG_DIR=../logs/boid/vision_10/x_0/edge_skip
DATA_DIR=../data/boid/vision_10

mkdir -p $LOG_DIR
cp $CONFIG $LOG_DIR/

BATCH_SIZE=${1:-1024}

PRED_STEPS=( 1 3 5 10 )
EPOCHS=( 10 10 5 3 3 )
BATCH_SIZES=( $BATCH_SIZE $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 4)) $(($BATCH_SIZE / 8)) $(($BATCH_SIZE / 16)) )
DATA_SETS=( "3_0" "5_0" "10_0") 

for ((i=0;i<${#PRED_STEPS[@]};i++)); do
    for data_set in ${DATA_SETS[@]}; do
        python3 run_swarmnet.py --train --data-dir=$DATA_DIR/$data_set --config=$CONFIG --log-dir=$LOG_DIR --epochs=${EPOCHS[$i]} --pred-steps=${PRED_STEPS[$i]} --batch-size=${BATCH_SIZES[$i]}
    done
done

cd ..

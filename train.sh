#!/bin/bash
cd swarmnet
git pull

BATCH_SIZE=${1:-1024}
ID=${2:-""}

CONFIG=../config_edge.json 
LOG_DIR=../logs/boid/5_10_0/edge_skip$ID
DATA_DIR=../data/boid/

mkdir -p $LOG_DIR
cp $CONFIG $LOG_DIR/

PRED_STEPS=( 1 3 5 10 )
EPOCHS=( 10 10 5 3 )
BATCH_SIZES=( $BATCH_SIZE $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 4)) $(($BATCH_SIZE / 8)) )
DATA_SET=5_10_0
PADDING=11

for ((i=0;i<${#PRED_STEPS[@]};i++)); do
    python3 run_swarmnet.py --train --data-dir=$DATA_DIR/$DATA_SET --config=$CONFIG --log-dir=$LOG_DIR --epochs=${EPOCHS[$i]} --pred-steps=${PRED_STEPS[$i]} --batch-size=${BATCH_SIZES[$i]} --max-padding=$PADDING
done

cd ..

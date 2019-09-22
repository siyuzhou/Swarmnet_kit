#!/bin/bash
cd swarmnet
git pull

BATCH_SIZE=512
ID=${1:-""}

CONFIG=../config_edge.json 
LOG_DIR=../logs/boid/20_0/edge_skip$ID
DATA_DIR=../data/boid/

mkdir -p $LOG_DIR
cp $CONFIG $LOG_DIR/

PRED_STEPS=( 1 3 5 10 )
EPOCHS=( 10 5 3 3 )
BATCH_SIZES=( $BATCH_SIZE $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 4)) $(($BATCH_SIZE / 8)) )
DATA_SET=20_0
# PADDING=11

for ((i=0;i<${#PRED_STEPS[@]};i++)); do
    python3 run_swarmnet.py --train --data-dir=$DATA_DIR/$DATA_SET --config=$CONFIG --log-dir=$LOG_DIR --epochs=${EPOCHS[$i]} --pred-steps=${PRED_STEPS[$i]} --batch-size=${BATCH_SIZES[$i]} #--max-padding=$PADDING
    echo "Training with $DATA_SET and ${PRED_STEPS[$i]} pred_steps over ${EPOCHS[$i]} epochs done" >> $LOG_DIR/train_log.txt
done


echo "Complete!" >> $LOG_DIR/train_log.txt
cd ..

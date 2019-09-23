#!/bin/bash
cd swarmnet
git pull

ID=${1:-""}

BATCH_SIZE=512

DATA_DIR=../data/boid/
CONFIG=../config_edge.json 
LOG_DIR=../logs/boid/10_0/edge_skip$ID
TUNE_LOG_DIR=../logs/boid/10_20_forget/edge_skip$ID
cp -r $LOG_DIR $TUNE_LOG_DIR


PRED_STEPS=( 1 3 5 10 )
EPOCHS=( 5 3 2 2 )
BATCH_SIZES=( $BATCH_SIZE $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 4)) )
DATA_SET=20_0


for ((i=0;i<${#PRED_STEPS[@]};i++)); do
    python3 run_swarmnet.py --train --data-dir=$DATA_DIR/$DATA_SET --config=$CONFIG --log-dir=$TUNE_LOG_DIR --epochs=${EPOCHS[$i]} --pred-steps=${PRED_STEPS[$i]} --batch-size=${BATCH_SIZES[$i]} --train-mode=2
    echo "Tuning with $DATA_SET and ${PRED_STEPS[$i]} pred_steps over ${EPOCHS[$i]} epochs done" >> $TUNE_LOG_DIR/train_log.txt
done

echo "Complete!" >> $TUNE_LOG_DIR/train_log.txt
cd ..

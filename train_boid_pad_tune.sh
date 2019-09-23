#!/bin/bash
cd swarmnet
git pull

ID=${1:-""}

BATCH_SIZE=2048

CONFIG=../config_edge.json 
LOG_DIR=../logs/boid/5_0/edge_skip$ID
DATA_DIR=../data/boid/

# mkdir -p $LOG_DIR
# cp $CONFIG $LOG_DIR/

# PRED_STEPS=( 1 3 5 10 )
# EPOCHS=( 10 5 3 3 )
# BATCH_SIZES=( $BATCH_SIZE $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 2)) )
# DATA_SET=5_0


# for ((i=0;i<${#PRED_STEPS[@]};i++)); do
#     python3 run_swarmnet.py --train --data-dir=$DATA_DIR/$DATA_SET --config=$CONFIG --log-dir=$LOG_DIR --epochs=${EPOCHS[$i]} --pred-steps=${PRED_STEPS[$i]} --batch-size=${BATCH_SIZES[$i]}
#     echo "Training with $DATA_SET and ${PRED_STEPS[$i]} pred_steps over ${EPOCHS[$i]} epochs done" >> $LOG_DIR/train_log.txt
# done


BATCH_SIZE=1024

TUNE_LOG_DIR=../logs/boid/5_10_tune/edge_skip$ID
mkdir -p $TUNE_LOG_DIR
cp -r $LOG_DIR/* $TUNE_LOG_DIR
rm $TUNE_LOG_DIR/*.txt

# PRED_STEPS=( 1 3 5 10 )
# EPOCHS=( 5 3 2 2 )
# BATCH_SIZES=( $BATCH_SIZE $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 2)) $(($BATCH_SIZE / 4)) )
# DATA_SET=5_10_0
# PADDING=11

# for ((i=0;i<${#PRED_STEPS[@]};i++)); do
#     python3 run_swarmnet.py --train --data-dir=$DATA_DIR/$DATA_SET --config=$CONFIG --log-dir=$TUNE_LOG_DIR --epochs=${EPOCHS[$i]} --pred-steps=${PRED_STEPS[$i]} --batch-size=${BATCH_SIZES[$i]} --max-padding=$PADDING --train-mode=2
#     echo "Tuning with $DATA_SET and ${PRED_STEPS[$i]} pred_steps over ${EPOCHS[$i]} epochs done" >> $TUNE_LOG_DIR/train_log.txt
# done

# echo "Complete!" >> $TUNE_LOG_DIR/train_log.txt
cd ..

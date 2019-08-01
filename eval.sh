cd swarmnet

CONFIG=../config_edge.json 
LOG_DIR=../logs/boid/vision_10/x_0/edge_skip
DATA_DIR=../data/boid/vision_10/

BATCH_SIZE=${1:-512}
BATCH_SIZES=( $BATCH_SIZE $(($BATCH_SIZE / 2)) $((BATCH_SIZE / 4)) )

DATA_SETS=( "3_0" "5_0" "7_0" ) 

for ((i=0;i<${#DATA_SETS[@]};i++)); do
    data_set=${DATA_SETS[$i]}
    echo "Eval loss for $data_set" >> $LOG_DIR/eval.txt
    python3 run_swarmnet.py --eval --data-dir=$DATA_DIR/$data_set --config=$CONFIG --log-dir=$LOG_DIR  --pred-steps=40 --batch-size=${BATCH_SIZES[$i]} >> $LOG_DIR/eval.txt
done

echo "Eval loss for 20_0" >> $LOG_DIR/eval.txt
python3 run_swarmnet.py --eval --data-dir=$DATA_DIR/20_0 --config=$CONFIG --log-dir=$LOG_DIR  --pred-steps=40 --batch-size=$(($BATCH_SIZE / 8)) >> $LOG_DIR/eval.txt

cat $LOG_DIR/eval.txt

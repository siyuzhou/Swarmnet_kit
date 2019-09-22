cd swarmnet

BATCH_SIZE=${1:-512}
ID=${2:-""}

CONFIG=../config_edge.json 
LOG_DIR=../logs/boid/20_0/edge_skip$ID
DATA_DIR=../data/boid/


DATA_SETS=( "3_0" "5_0" "7_0" "10_0" "20_0" "40_0") 

for ((i=0;i<${#DATA_SETS[@]};i++)); do
    data_set=${DATA_SETS[$i]}
    echo "Eval loss for $data_set" >> $LOG_DIR/eval.txt
    python3 run_swarmnet.py --eval --data-dir=$DATA_DIR/$data_set --config=$CONFIG --log-dir=$LOG_DIR  --pred-steps=40 --batch-size=$BATCH_SIZE >> $LOG_DIR/eval.txt
done

cat $LOG_DIR/eval.txt

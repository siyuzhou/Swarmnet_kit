#!/bin/bash

git clone https://github.com/siyuzhou/swarms
git clone https://github.com/siyuzhou/swarmnet

mkdir -p data

cd swarms
git pull

boids=( 3 5 10 )
processes=20
batch_size=1000

for boid in "${boids[@]}"; do
    echo "Generating training data for boids=$boid"
    python3 obstacle_avoidance_sim.py --processes=$processes --batch-size=$batch_size --obstacles=0 --steps=60 --dt=0.3 --vision=10 --save-dir=../data/boid/vision_10/${boid}_0 --boid=$boid --instances=50000 --prefix=train
    echo "Generating evaluation data for boids=$boid"
    python3 obstacle_avoidance_sim.py --processes=$processes --batch-size=$batch_size --obstacles=0 --steps=60 --dt=0.3 --vision=10 --save-dir=../data/boid/vision_10/${boid}_0 --boid=$boid --instances=1000 --prefix=valid
done

echo "Generating evaluation data for boids=20"
python3 obstacle_avoidance_sim.py --processes=$processes --batch-size=$batch_size --obstacles=0 --steps=60 --dt=0.3 --vision=10 --save-dir=../data/boid/vision_10/20_0 --boid=20 --instances=1000 --prefix=valid

echo "Generating evaluation data for boids=50"
python3 obstacle_avoidance_sim.py --processes=$processes --batch-size=$batch_size --obstacles=0 --steps=60 --dt=0.3 --vision=10 --save-dir=../data/boid/vision_10/50_0 --boid=50 --instances=1000 --prefix=valid

cd ..

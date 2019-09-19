#!/bin/bash

# Clone repositories.
git clone https://github.com/siyuzhou/swarms
git clone https://github.com/siyuzhou/swarmnet

mkdir -p data

cd swarms
git pull

train_boids=( 5 10 )
processes=20
batch_size=1000

for boid in "${train_boids[@]}"; do
    echo "Generating training data for boids=$boid"
    python3 obstacle_avoidance_sim.py --processes=$processes --batch-size=$batch_size --obstacles=0 --steps=60 --dt=0.3 --save-dir=../data/boid/${boid}_0 --boid=$boid --instances=50000 --prefix=train
done

# Copy 5_0 and 10_0 files to make a mixed set.
mkdir -p ../data/boid/5_10_0

for file in ../data/boid/5_0/*.npy; do
    cp $file ../data/boid/5_10_0/$(basename $file .npy)_5.npy
done

for file in ../data/boid/10_0/*.npy; do
    cp $file ../data/boid/5_10_0/$(basename $file .npy)_10.npy
done

# Validation sets.
valid_boids=( 3 5 7 10 20 )
for boid in "${valid_boids[@]}"; do
    echo "Generating validation data for boids=$boid"
    python3 obstacle_avoidance_sim.py --processes=$processes --batch-size=$batch_size --obstacles=0 --steps=60 --dt=0.3 --save-dir=../data/boid/${boid}_0 --boid=$boid --instances=1000 --prefix=valid
done

cd ..

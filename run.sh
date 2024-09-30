#!/bin/bash

gcc -o hamming_distance HammingDistance.c

if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

L_values=(64 89 256)
N_values=(100 1000)

for L in "${L_values[@]}"; do
    for N in "${N_values[@]}"; do

        SEED=$(date +%s)
        echo "Running program with N=$N, L=$L, SEED=$SEED"

        ./hamming_distance "$N" "$L" "$SEED"

        echo "--------------------------------------"
    done
done

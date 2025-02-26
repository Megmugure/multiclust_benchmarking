#!/bin/bash

# Source folder
source_folder="/home/mwanjiku/Multiclust_Benchmarking/Multiclust_Simulations/SS10"

# Iterate through files in source folder
for file in "$source_folder"/*.str; do
    for k in {1..9}; do
        multiclust -f "$file" -k "$k" -a -s 3 -n 1
    done

done

#!/bin/bash

# Source folder
source_folder="/home/mwanjiku/Multiclust_Benchmarking/Multiclust_Simulations/SS5"

# Iterate through files in source folder
for file in "$source_folder"/*.str; do
    multiclust -f "$file" -k 1 -a -s 3 -n 1
done

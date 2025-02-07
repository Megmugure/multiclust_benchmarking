#!/bin/bash

# run_structure.sh
# This script will be called by mpiexec to run individual structure commands

if [ -z "$1" ]; then
    echo "Usage: $0 <k_value>"
    exit 1
fi

k=$1
time ./structure -k "$k" -o k"${k}_multi" >> multi_"${k}"_structure.time


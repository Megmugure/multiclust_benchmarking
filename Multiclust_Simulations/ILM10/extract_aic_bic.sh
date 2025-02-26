#!/bin/bash

# Directory containing the output files
output_dir="/home/mwanjiku/Multiclust_Benchmarking/Multiclust_Simulations/ILM10"

# Iterate over each value of K from 1 to 10
for k in {1..10}; do
    # CSV files to store AIC and BIC values separately
    aic_output_csv="K${k}_aic_values.csv"
    bic_output_csv="K${k}_bic_values.csv"

    # Header for the CSV files
    echo "File,AIC" > "$aic_output_csv"
    echo "File,BIC" > "$bic_output_csv"

    # Iterate over each file in the directory for the current value of K
    for file_path in "$output_dir"/*.admix.K="$k".out.txt; do
        # Extract filename without extension
        filename=$(basename -- "$file_path")
        filename="${filename%.*}"

        # Extract AIC and BIC values using grep and awk
        aic=$(grep "AIC" "$file_path" | awk '{print $3}')
        bic=$(grep "BIC" "$file_path" | awk '{print $3}')

        # Output AIC and BIC values to CSV files
        echo "${filename},$aic" >> "$aic_output_csv"
        echo "${filename},$bic" >> "$bic_output_csv"
    done

    echo "AIC and BIC values extracted from all files for K=${k} and saved to $aic_output_csv and $bic_output_csv."
done


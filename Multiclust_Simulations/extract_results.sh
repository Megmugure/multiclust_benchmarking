#!/bin/bash

# Directory containing output files
output_dir="./ILM5_output"
# File to store extracted data
output_csv="ILM5_extracted_data.csv"

# Write header to CSV file
echo "File,K,Mean_ln_likelihood,Variance_ln_likelihood,Fst,Cluster_Proportions" > $output_csv

# Loop through each STRUCTURE output file
for output_file in $output_dir/*_output.txt_f; do
    # Extract the filename and K value
    file=$(basename "$output_file")
    K=$(echo $file | grep -oP '(?<=_k)\d+')

    # Extract relevant data from the file
    mean_ln_likelihood=$(grep "Mean value of ln likelihood" "$output_file" | awk '{print $6}')
    variance_ln_likelihood=$(grep "Variance of ln likelihood" "$output_file" | awk '{print $5}')
    Fst=$(grep "Mean value of Fst" "$output_file" | awk '{print $5}')
    
    # Extract cluster proportions
    cluster_proportions=$(grep -A 50 "Inferred clusters" "$output_file" | grep -oP '\d+\.\d+')

    # Combine the cluster proportions into a comma-separated list
    cluster_proportions_csv=$(echo $cluster_proportions | tr '\n' ',' | sed 's/,$//')

    # Append the extracted data to the CSV file
    echo "$file,$K,$mean_ln_likelihood,$variance_ln_likelihood,$Fst,$cluster_proportions_csv" >> $output_csv
done


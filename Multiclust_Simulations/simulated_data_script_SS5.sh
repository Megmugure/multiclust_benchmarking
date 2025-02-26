#!/bin/bash

#PBS -V
#PBS -l nodes=node17:ppn=20
#PBS -N benchmark5
#PBS -joe
#PBS -q batch
#PBS -l walltime=500:00:00

cd $PBS_O_WORKDIR
NCORES=`wc -w < $PBS_NODEFILE`
DATE=`date`
STARTHOST=`hostname`
echo "running on host: $STARTHOST"
echo "job submitted: $DATE"

# Directory containing the structure files
input_dir="./SS5"
output_dir="./SS5_output"

# Create output directory if it doesn't exist
mkdir -p $output_dir

# Create a list of commands to run
commands_file="commands.txt"
> $commands_file

# Loop through each .str file in the input directory
for input_file in $input_dir/*.str; do
    # Extract the base name of the file (without directory and extension)
    base_name=$(basename "$input_file" .str)
    
    # Loop through each value of K
    for k in {1..14}; do
        # Define the output file name
        output_file="$output_dir/${base_name}_k${k}_output.txt"
        
        # Add the command to the commands file
        echo "./structure -m mainparamsSS5 -e extraparamsSS5 -K $k -i $input_file -o $output_file" >> $commands_file
    done
done

# Use mpiexec to distribute commands
cat $commands_file | xargs -n 1 -P $NCORES -I {} mpiexec -n 1 bash -c {}


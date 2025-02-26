#!/bin/bash

#PBS -V
#PBS -l nodes=ram512:ppn=20
#PBS -l mem=512gb
#PBS -N benchmark_bi
#PBS -joe
#PBS -q batch
#PBS -l walltime=500:00:00

cd $PBS_O_WORKDIR
NCORES=`wc -w < $PBS_NODEFILE`
DATE=`date`
STARTHOST=`hostname`
echo "running on host: $STARTHOST"
echo "job submitted: $DATE"

# Create a list of commands to run
commands_file="commands.txt"
> $commands_file
for k in {3..14}; do
    echo "./run_structure.sh $k" >> $commands_file
done

# Use mpiexec to distribute commands
cat $commands_file | xargs -n 1 -P $NCORES -I {} mpiexec -n 1 bash -c {}


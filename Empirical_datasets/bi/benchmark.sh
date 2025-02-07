#!/bin/bash

#PBS -V
#PBS -l nodes=2:ppn=20:mpi
#PBS -N benchmark1
#PBS -joe
#PBS -q batch
#PBS -l walltime=500:00:00

cd $PBS_O_WORKDIR
NCORES=`wc -w < $PBS_NODEFILE`
DATE=`date`
STARTHOST=`hostname`
echo "running on host: $STARTHOST"
echo "job submitted: $DATE"


for k in {1..14}
do
    time ./structure -k "$k" -o k"$k"_bi >> bi_"$k"_structure.time
done


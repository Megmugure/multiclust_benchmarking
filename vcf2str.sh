#!/bin/bash

BASEDIR=/home/mwanjiku/Multiclust_Benchmarking/Multiclust_Simulations/

for dir in $BASEDIR*
do
  cd "$dir"
  f="$(basename "$dir")"
  echo "$f"   
  FILE="$(basename $dir/$f/*.vcf)"
  

  for file in "$FILE"
  do
      plink --vcf "$file" --recode structure --out "$file".str   
  done
done

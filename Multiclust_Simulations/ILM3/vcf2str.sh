#!/bin/bash

for i in *.vcf
do
 
 PGDSpider2-cli -inputfile "$i" -inputformat VCF -outputformat STRUCTURE -spid /home/mwanjiku/Multiclust_Benchmarking/Multiclust_Simulations/spid_file.spid -outputfile "$i".str	
       
done

for f in *vcf.str
do
 mv "$f" "${f%.vcf.str}.str"

done

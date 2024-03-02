#!/bin/bash

WORKDIR=~/bioinf/practice_bioinf/practice6/hisat2_output/
READS=~/bioinf/practice_bioinf/practice6/data/reads
REFERENCE=~/bioinf/practice_bioinf/practice6/data/reference/genome.fa

cd "$WORKDIR"

#source activate prac6

hisat2-build "$REFERENCE" genome_idx

for file_path in "$READS"/* ; do
    NAME=$(basename "$file_path" | cut -d. -f1)

    hisat2 -p 6 -x genome_idx -U "$file_path" | samtools sort > ${NAME}_out.bam
    
    cd "$WORKDIR"
done

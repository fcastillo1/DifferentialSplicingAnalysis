#!/bin/bash -ue
/usr/local/bin/trimmomatic PE \
    -threads 1 \
    -phred33 \
    SRR12463396_1.fastq SRR12463396_2.fastq \
    SRR12463396_1_R1_trimmed_paired.fq.gz SRR12463396_1_R1_trimmed_unpaired.fq.gz \
    SRR12463396_2_R2_trimmed_paired.fq.gz SRR12463396_2_R2_trimmed_unpaired.fq.gz \
    ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:20 \
    MINLEN:36

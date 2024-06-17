#!/bin/bash -ue
mkdir -p fastqc_results
fastqc SRR12463396_2.fastq -o fastqc_results

#!/bin/bash -ue
mkdir -p fastqc_results
fastqc SRR12463396_1.fastq -o fastqc_results

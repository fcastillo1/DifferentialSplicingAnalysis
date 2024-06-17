#!/bin/bash -ue
mkdir -p fastqc_results
fastqc SRR10503054.fastq -o fastqc_results

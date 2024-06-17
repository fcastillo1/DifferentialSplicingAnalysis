#!/bin/bash -ue
mkdir -p fastqc_results
fastqc .DS_Store -o fastqc_results

#!/usr/bin/env nextflow

log.info "Differential Splicing Analysis - NF  ~  version 0.1"

params.input = params.input ?: 'data/data_fastq.csv'
params.output_dir = params.output_dir ?: 'Results'

// Leer archivo CSV y crear un canal
fastq_files = Channel.fromPath(params.input)
    .splitCsv(header: true)
    .map { row -> tuple(row.sample_id, file(row.fastq_path_1), file(row.fastq_path_2)) }

// Incluir el módulo FastQC
include { fastqc } from './modules/fastqc/fastqc.nf'

workflow {
    // Llamar al proceso FastQC
    fastqc(fastq_files)
}
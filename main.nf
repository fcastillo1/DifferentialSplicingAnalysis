#!/usr/bin/env nextflow

log.info "Differential Splicing Analysis - NF  ~  version 0.1"

params.input = params.input ?: 'data/data_fastq.csv'
params.output_dir = params.output_dir ?: 'Results'

// Leer archivo CSV y crear un canal
fastq_files = Channel.fromPath(params.input)
    .splitCsv(header: true)
    .map { row -> tuple(row.sample_id, file(row.fastq_path_1.trim()), file(row.fastq_path_2.trim())) }

// Incluir el módulo FastQC
include { fastqc } from './modules/fastqc/fastqc.nf'

workflow {
    fastqc_results = fastqc(fastq_files)
    fastqc_results.view()
    fastqc_results.collectFile(name: { it.name }, storeDir: "${params.output_dir}/fastqc_results")
}

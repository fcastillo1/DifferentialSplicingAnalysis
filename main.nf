#!/usr/bin/env nextflow
/*
 * Copyright (c) 2024, Munita Lab y autores.
 *
 * Autores:
 * Francisca Reyes <fcastillor.19@gmail.com> 
 * Roberto Munita
 */


log.info "Differential Splicing Analysis - NF  ~  version 1.0"

params.input = params.input ?: 'data/data_fastq.csv'
params.output_dir = params.output_dir ?: 'Results'

// Leer archivo CSV y crear un canal
Channel.fromPath(params.input)
    .splitCsv(header: true)
    .map { row -> tuple(row.sample_id, file(row.fastq_path_1.trim()), file(row.fastq_path_2.trim())) }

// Incluir el módulo FastQC
include { fastqc } from './modules/fastqc/fastqc.nf'

workflow {
    fastqc(fastq_files).view()
}

#!/usr/bin/env nextflow
/*
 * Copyright (c) 2024, MunitaLab and the authors.
 *
 * @authors
 * Francisca Reyes <fcastillor.19@gmail.com>
 * Roberto Munita
 */

 log.info "Differential Splicing Analysis - NF  ~  version 0.1"

 /*--------------------------------------------------
                Parametros necesarios
---------------------------------------------------*/
params.input = params.input ?: 'data/data_fastq.csv'
//params.genome = params.genome ?: 'path/to/genome.fasta'
//params.gtf = params.gtf ?: 'path/to/annotations.gtf'
params.output_dir= params._dir ?: 'path/to/Results'
params.savescript = params.savescript ?: ''

 /*--------------------------------------------------
                Módulos and Workflow
---------------------------------------------------*/
// Leer archivo CSV 
Channel.fromPath(params.input)
    .splitCsv(header: true)
    .map { row -> tuple(row.sample_id, file(row.fastq_path_1), file(row.fastq_path_2)) }
    .set { fastq_files }

// Incluye el modulo FASTQC
include { fastqc } from './modules/fastqc/main.nf'

workflow {
    // Se llama al proceso
    fastqc(fastq_files)
}
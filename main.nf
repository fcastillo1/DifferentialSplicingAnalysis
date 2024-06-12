#!/usr/bin/env nextflow
/*
 * Copyright (c) 2024, MunitaLab y los autores.
 *
 * Autores:
 * Francisca Reyes <fcastillor.19@gmail.com>
 * Roberto Munita
 */

log.info "Differential Splicing Analysis - NF  ~  version 0.1"

params.input = params.input ?: 'data/data_fastq.csv'
params.output_dir = params.output_dir ?: 'Results'

// Leer archivo CSV y crear un canal
Channel.fromPath(params.input)
    .splitCsv(header: true)
    .map { row -> tuple(row.sample_id, file(row.fastq_path_1), file(row.fastq_path_2)) }
    .set { fastq_files }

// Incluir el módulo FastQC
include { fastqc } from './modules/fastqc.nf'

workflow {
    // Llamar al proceso FastQC
    fastqc(fastq_files)

    // Definir el directorio de salida
    fastqc_results_raw.into { fastqc_results }.view { file -> 
        "Resultados de FastQC disponibles en: ${file}"
    }
}

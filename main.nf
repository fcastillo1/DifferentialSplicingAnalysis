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
params {
    input = "${params.input}"
    output_dir = "${params.output_dir}"
    savescript = "${params.savescript}"
}

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

    // Definir el directorio de salida
    fastqc_results_raw.into { fastqc_results }.view { file -> 
        "Resultados de FastQC disponibles en: ${file}"
    }
}
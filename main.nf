#!/usr/bin/env nextflow
/*
* Copyright (c) 2024, Munita Lab y autores.
*
* Autores:
* Francisca Reyes <fcastillor.19@gmail.com>
* Roberto Munita
*/

log.info "Differential Splicing Analysis - NF  ~  version 1.0"

// Parámetros
params.input_dir = params.input_dir ?: error('Debe proporcionar un directorio de entrada con --input_dir')
params.output_dir = params.output_dir ?: error('Debe proporcionar un directorio de salida con --output_dir')
params.cpus = params.cpus ?: 8
params.paired_end = params.paired_end ?: true

// Incluir el módulo FastQC
include { fastqc2 } from './modules/fastqc/fastqc2.nf'
include { trimmomatic } from './modules/trimmomatic/trimmomatic.nf'
workflow {
    // Validar que el directorio de entrada no esté vacío
    if (!file(params.input_dir).exists()) {
        error "El directorio de entrada ${params.input_dir} no existe"
    }

    // Crear el directorio de salida si no existe
    def output_dir = file(params.output_dir)
    if (!output_dir.exists()) {
        output_dir.mkdirs()
    }

    // Leer archivos de entrada
    def archivos = file(params.input_dir).listFiles()
    if (archivos == null || archivos.size() == 0) {
        error "No se encontraron archivos en el directorio de entrada"
    }
    // Genera el canal de toda la lista de los archivos (TODO LO QUE ESTA ADENTRO!)
    Channel.of(archivos)
      .set { result }
      // eliminar output_dir
    fastqc2(result, params.output_dir)
    trimmomatic(result.collectFile().collate(2), params.adapter_sequence_file)

}

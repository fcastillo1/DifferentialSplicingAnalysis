// modules/fastqc/fastqc.nf

process fastqc {
    tag "$sample_id"

    input:
    tuple val(sample_id), path(fastq1), path(fastq2) from fastq_files

    output:
    path("${params.output_dir}/fastqc_results/${sample_id}_fastqc.{zip,html}") into fastqc_results_raw
    file("command-logs-*") optional true

    script:
    """
    mkdir -p ${params.output_dir}/fastqc_results
    fastqc --casava --threads \$task.cpus $fastq1 $fastq2 -o ${params.output_dir}/fastqc_results
    mv ${params.output_dir}/fastqc_results/*_fastqc.zip ${params.output_dir}/fastqc_results/${sample_id}_fastqc.zip
    mv ${params.output_dir}/fastqc_results/*_fastqc.html ${params.output_dir}/fastqc_results/${sample_id}_fastqc.html
    """
}


process fastqc {
    tag "$sample_id"

    input:
    tuple val(sample_id), path(fastq1), path(fastq2) from fastq_files

    output:
    file "*_fastqc.{zip,html}" into fastqc_results_raw
    file("command-logs-*") optional true

    script:
    """
    mkdir -p fastqc_results
    fastqc $fastq -o fastqc_results
    mv fastqc_results/*.zip fastqc_results/${sample_id}_fastqc.zip
    mv fastqc_results/*.html fastqc_results/${sample_id}_fastqc.html
    """
}
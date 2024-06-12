// modules/fastqc/fastqc.nf

process fastqc {
    tag "$sample_id"

    input:
    tuple val(sample_id), path(fastq1), path(fastq2)

    output:
    path("${sample_id}_fastqc.zip")
    path("${sample_id}_fastqc.html")

    script:
    """
    mkdir -p fastqc_results
    fastqc --casava --threads \$task.cpus $fastq1 $fastq2 -o fastqc_results
    mv fastqc_results/*_fastqc.zip ${sample_id}_fastqc.zip
    mv fastqc_results/*_fastqc.html ${sample_id}_fastqc.html
    """
}

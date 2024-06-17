process fastqc2 {
    publishDir 'FastQC_Result/', mode: 'copy'
    tag "FastQC on ${fastq1}"

    input:
    path fastq1
    val output_dir

    output:
    path "fastqc_results/"

    script:
    """
    mkdir -p fastqc_results
    fastqc ${fastq1} -o fastqc_results
    """
}

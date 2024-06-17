process trimmomatic {
    publishDir 'Trimmomatic_Result/', mode: 'copy'

    input:
    tuple path(forward_reads), path(reverse_reads)
    path(adapter_file)

    output:
    path("${forward_reads.baseName}_R1_trimmed_paired.fq.gz")
    path("${forward_reads.baseName}_R1_trimmed_unpaired.fq.gz")
    path("${reverse_reads.baseName}_R2_trimmed_paired.fq.gz")
    path("${reverse_reads.baseName}_R2_trimmed_unpaired.fq.gz")

    script:
        """
        /usr/local/bin/trimmomatic PE \\
            -threads $task.cpus \\
            -phred33 \\
            $forward_reads $reverse_reads \\
            ${forward_reads.baseName}_R1_trimmed_paired.fq.gz ${forward_reads.baseName}_R1_trimmed_unpaired.fq.gz \\
            ${reverse_reads.baseName}_R2_trimmed_paired.fq.gz ${reverse_reads.baseName}_R2_trimmed_unpaired.fq.gz \\
            ILLUMINACLIP:$adapter_file:2:30:10 \\
            LEADING:3 \\
            TRAILING:3 \\
            SLIDINGWINDOW:${params.slidingwindow}:20 \\
            MINLEN:36
        """
    }

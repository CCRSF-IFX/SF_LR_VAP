# Mapping reads to genome

def get_fastq_path(wildcards):
    return samples[wildcards.sample]['path']

rule minimap2:
    input: get_fastq_path
    output: temp("Sample_{sample}/{sample}.sam")
    resources: mem_mb=400000, time="96:00:00", partition="norm"
    threads: 16
    log: "Sample_{sample}/{sample}_map.log"
    params:
      ref=config[config['reference']]['ref']
    conda: "envs/minimap2.yaml"
    shell:
        "minimap2 -t {threads} -ax map-ont -p 0 -N10 {params.ref} {input} 2> {log}"

rule sort:
    input: "Sample_{sample}/{sample}.sam"
    output: file1 = temp("Sample_{sample}/{sample}.bam"), file2 = "Sample_{sample}/{sample}.sorted.bam"
    resources: mem_mb=400000, time="96:00:00", partition="norm"
    threads: 36
    log: "Sample_{sample}/{sample}_sort.log"
    conda: "envs/samtools.yaml
    shell: "samtools view -S -b {input} > {output.file1}; samtools sort -o {output.file2} -@ 36 {output.file1}; samtools index {output.file2}"
    
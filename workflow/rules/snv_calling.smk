# Calling SNVs

rule deepvariant:
    input: "Sample_{sample}/{sample}.sorted.bam"
	output: "Sample_{sample}/{sample}.dp.vcf.gz"
    resources: mem_mb=config['mem_lg'], time=config['time'], partition=config['partition']
    threads: 36
    log: "Sample_{sample}/{sample}_deepvariant.log"
    conda: "envs/deepvariant.yaml"
	params: ref=config[config['reference']]['ref'] 
	shell: "run_deepvariant --model_type=ONT_R104 --ref={params.ref} --reads={input} --output_vcf={output} --num_shards=36 2>{log}"
	
rule dp_filter:
	input: rules.deepvariant.output
	output: "Sample_{sample}/{sample}_dp_filtered.vcf.gz"
    resources: mem_mb=config['mem_md'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_dp_bcftools.log"
    conda: "envs/bcftools.yaml"
	shell: "bcftools view -f 'PASS' {input} | bcftools sort -O z -o {output}; bcftools index -t {output}"
	
rule clair3:
    input: "Sample_{sample}/{sample}.sorted.bam"
	output: "Sample_{sample}/clair3/merge_output.vcf.gz"
    resources: mem_mb=config['mem_lg'], time=config['time'], partition=config['partition']
    threads: 36
    log: "Sample_{sample}/{sample}_clair3.log"
    conda: "envs/clair3.yaml"
	params: folder = "Sample_{sample}", ref=config[config['reference']]['ref'], model="/mnt/clair3/rerio/clair3_models"
	shell: "run_clair3.sh --thread {threads} --bam_fn {input} --ref_fn {params.ref} --output {params.folder}/clair3 --platform ont --model_path {params.model} 2>{log}"
	
rule clair3_filter:
	input: rules.clair3.output
	output: "Sample_{sample}/clair3/{sample}_clair3_filtered.vcf.gz"
    resources: mem_mb=config['mem_md'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_clair3_bcftools.log"
    conda: "envs/bcftools.yaml"
	shell: "bcftools view -f 'PASS' {input} | bcftools sort -O z -o {output}; bcftools index -t {output}"

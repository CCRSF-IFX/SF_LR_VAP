# SV calling workflow

rule sniffles:
    input: "Sample_{sample}/{sample}.sorted.bam"
    output: "Sample_{sample}/{sample}_sniffles.vcf"
    resources: mem_mb=config['mem_lg'], time=config['time'], partition=config['partition']
    threads: 36
    log: "Sample_{sample}/{sample}_sniffles.log"
    conda: "envs/sniffles.yaml"
    params: ref=config[config['reference']]['ref']
    shell: "{sniffles} -i {input} --reference {params.ref} -v {output}"

rule sniffles_filter:
	input: sniffles_in="Sample_{sample}/{sample}_sniffles.vcf"
	output: sniffles_out="Sample_{sample}/{sample}_sniffles_filtered.vcf.gz"
    resources: mem_mb=config['mem_md'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_sniffles_filter.log"
    conda: "envs/bcftools.yaml"
	shell: "bcftools view -f 'PASS' {input.sniffles_in} | bcftools sort -O z -o {output.sniffles_out}; bcftools index -t {output.sniffles_out} 2>{log}"
	
rule sniffles_plot:
	input: sniffles_out="Sample_{sample}/{sample}_sniffles_filtered.vcf.gz"
	output: sniffles_plot="Sample_{sample}/sniffles_plot/variant_count.jpg"
    resources: mem_mb=config['mem_sm'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_sniffles_plot.log"
    conda: "envs/myenv.yaml"
	params: sniffles_folder = "Sample_{sample}/sniffles_plot"
	shell: "mkdir -p {params.sniffles_folder}; python workflow/script/sniffles2_plots.py -i {input.sniffles_out} -o {params.sniffles_folder}"

rule cutesv:
    input: "Sample_{sample}/{sample}.sorted.bam"
    output: "Sample_{sample}/{sample}_cutesv.vcf"
    resources: mem_mb=config['mem_lg'], time=config['time'], partition=config['partition']
    threads: 36
    log: "Sample_{sample}/{sample}_cutesv.log"
    conda: "envs/cutesv.yaml"
    params: ref=config[config['reference']]['ref']
    shell: "{cutesv} -t 36 --genotype --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 {input} {params.ref} {output} /tmp"

rule cutesv_filter:
	input: cutesv_in="Sample_{sample}/{sample}_cutesv.vcf"
	output: cutesv_out="Sample_{sample}/{sample}_cutesv_filtered.vcf.gz"
    resources: mem_mb=config['mem_md'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_cutesv_filter.log"
    conda: "envs/bcftools.yaml"
	shell: "bcftools view -f 'PASS' {input.cutesv_in} | bcftools sort -O z -o {output.cutesv_out}; bcftools index -t {output.cutesv_out}"
	
rule cutesv_plot:
	input: cutesv_out="Sample_{sample}/{sample}_sniffles_filtered.vcf.gz"
	output: cutsv_plot="Sample_{sample}/cutesv_plot/variant_count.jpg"
    resources: mem_mb=config['mem_sm'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_cutesv_filter.log"
    conda: "envs/bcftools.yaml"
	params: cutesv_folder = "Sample_{sample}/cutesv_plot"
	shell: "mkdir -p {params.cutesv_folder}; python workflow/script/sniffles2_plots.py -i {input.cutesv_out} -o {params.cutesv_folder}"
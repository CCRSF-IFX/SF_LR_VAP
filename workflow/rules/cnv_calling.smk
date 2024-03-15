# CNV calling

rule mosdepth:
    input: "Sample_{sample}/{sample}.sorted.bam"
    output: "Sample_{sample}/mosdepth/{sample}.mosdepth.summary.txt"
    resources: mem_mb=config['mem_lg'], time=config['time'], partition=config['partition']
    threads: 36
    log: "Sample_{sample}/{sample}_mosdepth.log"
    conda: "envs/mosdepth.yaml"
    params: sname = "{sample}", path = "Sample_{sample}/mosdepth"
    shell: "mkdir -p {params.path}; cd {params.path}; mosdepth -n --fast-mode --by 1000 {params.sname} ../{params.sname}.sorted.bam"
    
rule spectre:
    input: rules.mosdepth.output
    output: "Sample_{sample}/spectre/{sample}.vcf"
    resources: mem_mb=config['mem_md'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_spectre.log"
    conda: "envs/myenv.yaml"
    params: mos_path = "Sample_{sample}/mosdepth/", sname = "{sample}", out_path = "Sample_{sample}/spectre/", ref_filter=config[config['reference']]['ref_filter']    
    shell: "python script/spectre.py CNVCaller --bin-size 1000 --coverage {params.mos_path} --sample-id {params.sname} --output-dir {params.out_path} --reference {ref_filter}"
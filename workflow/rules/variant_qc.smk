# VariantQC 

def get_vtext(wildcards):
    analysis_folder = os.getcwd()
    v_text = ""
    v_text1 = ""
    for sample in list(set(samples)):
        v_text += f" -V:{sample} {analysis_folder}/Sample_{sample}/{sample}_dp_filtered.vcf.gz"
        v_text1 += f" -V:{sample} {analysis_folder}/Sample_{sample}/clair3/{sample}_clair3_filtered.vcf.gz"
    return [v_text, v_text1]

rule variantqc:
	input: dp = expand("Sample_{sample}/{sample}_dp_filtered.vcf.gz", sample=samples), clair3 = expand("Sample_{sample}/clair3/{sample}_clair3_filtered.vcf.gz", sample=samples), ref=config[config['reference']]['ref']
	output: out1 = "VariantQC_dp.html", out2 = "VariantQC_clair3.html"
    resources: mem_mb=config['mem_md'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_variantqc.log"
    singularity: docker://ghcr.io/bimberlab/discvrseq
	params: vtexts=get_vtext 
	shell: "VariantQC -R {input.ref} {params.vtexts[0]} -O {output.out1}; VariantQC -R {input.ref} {params.vtexts[1]} -O {output.out2}"
    
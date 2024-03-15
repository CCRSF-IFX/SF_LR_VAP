# MultiQC

rule multiqc:
    input: expand("Sample_{sample}/qualimap/qualimapReport.html", sample=samples), expand("Sample_{sample}/nanoplot_bam/{sample}Non_weightedHistogramReadlength.png", sample=samples), expand("Sample_{sample}/{sample}_clair3_filtered.vep.vcf", sample=samples), "VariantQC_dp.html", expand("Sample_{sample}/cutesv_plot/variant_count.jpg", sample=samples), expand("Sample_{sample}/sniffles_plot/variant_count.jpg", sample=samples), expand("Sample_{sample}/spectre/{sample}.vcf", sample=samples)
    output: "multiqc.html"
    resources: mem_mb=config['mem_md'], time=config['time'], partition=config['partition']
    threads: 8
    log: "Sample_{sample}/{sample}_multiqc.log"
    conda: "envs/multiqc.yaml"
    shell: "multiqc -f ./ -n {output} 2>{log}"
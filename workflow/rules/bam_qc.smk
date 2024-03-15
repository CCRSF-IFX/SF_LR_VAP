# BAM QC rules

rule qualimap:
    input: "Sample_{sample}/{sample}.sorted.bam"
    output: "Sample_{sample}/qualimap/qualimapReport.html"
    resources: mem_mb=400000, time="96:00:00", partition="norm"
    threads: 36
    log: "Sample_{sample}/{sample}_qualimap.log"
    params: fname = "Sample_{sample}/qualimap"
    conda: "envs/qualimap.yaml"
    shell: "unset DISPLAY; qualimap bamqc --java-mem-size=128G -bam {input} -c -gd HUMAN -nw 5000 -nt 36 -outdir {params.fname} 2>{log}"

rule nanoplot2:
    input: "Sample_{sample}/{sample}.sorted.bam"
    output: "Sample_{sample}/nanoplot_bam/{sample}Non_weightedHistogramReadlength.png"
    resources: mem_mb=400000, time="96:00:00", partition="norm"
    threads: 12
    log: "Sample_{sample}/{sample}_nanoplot.log"
    params: out = "Sample_{sample}/nanoplot_bam", sample = "{sample}"
    conda: "envs/nanoplot.yaml"
    shell: "mkdir -p {params.out}; nanoplot -t 12 -o {params.out} --prefix {params.sample} --N50 --bam {input} --plots kde 2>{log}"
    
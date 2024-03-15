#VEP
if config['reference'] = "hg38": 
    vep_params = "--offline --force_overwrite --everything --hgvs --hgvsg --check_existing --fork 4 --cache --cache_version 98 --dir_cache /mnt/RefGenomes/Variant_annotation/VEP --species homo_sapiens --assembly GRCh38"
    vep_species = "homo_sapiens" 
    vep_assembly = "GRCh38"
    vep_fasta = "/mnt/Variant_annotation/VEP/homo_sapiens/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"

rule vep:
    input: clair3 = "Sample_{sample}/clair3/{sample}_clair3_filtered.vcf.gz", sniffles = "Sample_{sample}/{sample}_sniffles_filtered.vcf.gz"
    output: c3 = "Sample_{sample}/{sample}_clair3_filtered.vep.vcf", snf = "Sample_{sample}/{sample}_sniffles_filtered.vep.vcf"
    resources: mem_mb=128000, time="96:00:00", partition="norm"
    threads: 8
    log: "Sample_{sample}/{sample}_vep.log"
    conda: "envs/vep.yaml"
    shell: "vep {vep_params} --species {vep_species} --assembly {vep_assembly} --fasta {vep_fasta} --vcf -i {input.clair3} -o {output.c3}; vep {vep_params} --species {vep_species} --assembly {vep_assembly} --fasta {vep_fasta} --vcf -i {input.sniffles} -o {output.snf}"
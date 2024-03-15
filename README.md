# SF Long Read Variant Analysis Pipeline (SF_LR_VAP)

## Overview
The SF Long Read Variant Analysis Pipeline (SF_LR_VAP) is a bioinformatics workflow tailored for the comprehensive analysis of long-read sequencing data. Designed to facilitate high-throughput variant discovery and characterization, SF_LR_VAP integrates a suite of advanced tools and methodologies to process sequencing data from raw reads through to annotated variants.

Starting with the preprocessing of sequencing reads, the pipeline employs quality control measures to ensure the integrity and reliability of the data. This involves assessing the quality of sequencing reads and preparing them for downstream analyses through processes such as mapping reads to a reference genome using tools like minimap2, ensuring high fidelity in variant identification.
![SF_LR_VAP](/resources/sf_lr_var.PNG)

Variant calling is a core component of SF_LR_VAP, with dedicated steps for both single nucleotide variants (SNVs) and structural variants (SVs) detection. The pipeline utilizes state-of-the-art tools such as DeepVariant for SNV calling and Sniffles for SV detection, providing comprehensive coverage of variant types. This is complemented by additional processes for calling copy number variations (CNVs) and integrating variant filtering strategies to refine the calls based on quality metrics.

Annotation and functional impact analysis of called variants are conducted using the Variant Effect Predictor (VEP), allowing users to understand the biological implications of identified variants. This is crucial for applications in research and clinical diagnostics, where understanding the function of variants is essential.

Visualization and reporting are key features of SF_LR_VAP, with tools like MultiQC integrated to compile results from various analysis stages into a unified report. This provides a high-level overview of the analysis, facilitating easy interpretation and identification of key findings.

In summary, SF_LR_VAP offers a comprehensive and integrative approach to the analysis of long-read sequencing data, from quality control and read mapping to variant calling, annotation, and reporting. Its modular design and use of cutting-edge bioinformatics tools make it a versatile resource for researchers and clinicians working with long-read sequencing technologies.


## Features
- **Comprehensive Analysis**: Processes long-read sequencing data from raw reads to annotated variants.
- **Support for Long-Read Technologies**: Optimized for data from platforms like PacBio and Oxford Nanopore.
- **Quality Control**: Includes steps for quality assessment of sequencing reads and variant calls.
- **Variant Calling**: Identifies single nucleotide variants (SNVs) and structural variants (SVs) using state-of-the-art tools.
- **Annotation**: Annotates variants for functional impact using VEP.
- **Visualization**: Generates various plots and reports for easy interpretation of results.

## Installation
Before installing, ensure you have Conda and Snakemake installed.

Clone the repository:
```bash
git clone https://github.com/CCRSF-IFX/SF_LR_VAP.git
cd SF_LR_VAP

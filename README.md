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

### Comprehensive Workflow for Long-Read Sequencing Data
SF_LR_VAP is meticulously designed to support and analyze long-read sequencing data from leading technologies like PacBio and Oxford Nanopore. The pipeline manages everything from raw data processing and quality control to the final variant calling and annotation, making it a one-stop solution for genomic researchers and clinicians.

### Advanced Quality Control (QC) Measures
- **Read Quality Assessment**: Utilizes tools like NanoPlot to evaluate the quality of sequencing reads, ensuring that only high-quality data is used for further analysis.
- **Alignment Quality Control**: Employs Qualimap to assess the quality of alignments, providing insights into the coverage, mapping quality, and potential biases in the data.

### High-Performance Mapping and Variant Calling
- **Efficient Read Mapping**: Uses minimap2 for fast and accurate alignment of long reads to reference genomes, optimizing the detection of genomic variants.
- **Single Nucleotide Variants (SNVs) and Structural Variants (SVs) Detection**: Integrates DeepVariant for precise SNV calling and Sniffles for reliable detection of structural variants, ensuring comprehensive variant discovery.

### Variant Filtering and Annotation
- **Robust Variant Filtering**: Implements filtering strategies to refine variant calls based on quality metrics, enhancing the reliability of variant identification.
- **Functional Impact Analysis**: Utilizes the Variant Effect Predictor (VEP) for annotating variants with their potential functional impacts, aiding in the interpretation of their biological significance.

### Visualization and Comprehensive Reporting
- **Variant Visualization**: Generates plots for variant counts and read length distributions, offering intuitive visual insights into the sequencing data and variant landscape.
- **MultiQC Integration**: Compiles reports from various stages of the analysis into a unified MultiQC report, providing a high-level overview and facilitating the identification of key findings.

### Configurable and User-Friendly
- **Flexible Configuration**: Allows users to easily customize analysis parameters through a central configuration file, adapting the pipeline to different datasets and research needs.
- **Detailed Documentation**: Accompanied by comprehensive documentation, guiding users through installation, configuration, and execution, ensuring a smooth user experience.

SF_LR_VAP combines these features to offer a robust and user-friendly pipeline for the analysis of long-read sequencing data, addressing the challenges of variant calling with advanced bioinformatics tools and techniques. It's built to cater to the needs of genomic researchers and clinicians looking for reliable and comprehensive variant analysis solutions.


## Installation
Before installing, ensure you have Conda and Snakemake installed.

Clone the repository:
```bash
git clone https://github.com/CCRSF-IFX/SF_LR_VAP.git
cd SF_LR_VAP
```

## Contact
CCRSF_IFX@nih.gov

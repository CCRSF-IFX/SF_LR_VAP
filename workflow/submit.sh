#!/bin/bash
#SBATCH --partition=norm
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=4g
#SBATCH --time=96:00:00
#SBATCH --no-requeue

source /mnt/ccrsf-ifx/Software/tools/Anaconda/3.11/etc/profile.d/conda.sh
conda activate snakemake
module load singularity
snakemake --profile slurm --use-conda --use singularity

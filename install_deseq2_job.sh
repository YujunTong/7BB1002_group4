#!/bin/bash
#SBATCH --job-name=install_deseq2
#SBATCH --output=install_deseq2_%j.out
#SBATCH --error=install_deseq2_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G

# ---- 1. Load shared micromamba ----
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"

# ---- 2. Activate your R 3.6.1 environment ----
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/R_3.6.1_env

# ---- 3. Use 8 threads for compilation (very important for speed) ----
export MAKEFLAGS="-j8"

echo "Using R at:"
which R
R --version

echo "Starting DESeq2 + fdrtool installation at: $(date)"

# ---- 4. Run the R install script ----
Rscript install_deseq2.R

echo "Finished DESeq2 + fdrtool installation at: $(date)"

#This document explains how all team members can use the shared micromamba tool and the shared RNA-seq environment located in the Group4_ABCC directory.

#ONE-TIME SETUP
echo 'export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba' >> ~/.bashrc
echo 'eval "$($MAMBA_EXE shell hook --shell bash)"' >> ~/.bashrc
source ~/.bashrc

#Activating the Shared RNA-seq Environment
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

#Deactivating the Environment
micromamba deactivate

#Using the Environment Inside SLURM Job Scripts
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

#Environment Location
#Shared micromamba binary:
/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
#Shared RNA-seq environment:
/scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli
# Env for R
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/R_3.6.1_env
R

#Use this R env in SLURM scripts
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/R_3.6.1_env

Rscript your_script.R

# Alternate Option : Add R to existing env safely( We did not do this)
/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba \
  install -p /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli \
  r-base=3.6.1 r-ggplot2=3.3.3 r-dplyr=1.0.2 ...
# install DESeq2 individually in install_deseq2.R

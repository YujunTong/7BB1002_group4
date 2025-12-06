# install micromamba
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

# Path
mkdir -p ~/bin
mv bin/micromamba ~/bin/
chmod +x ~/bin/micromamba

# ADD to .bashrc
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
# Test
micromamba --version
#initialize micromamba
eval "$(micromamba shell hook --shell bash)"
# Test
micromamba activate
#Force-add micromamba initialization to .bashrc
micromamba shell init --shell bash --root-prefix="$HOME/.local/share/mamba"
source ~/.bashrc
micromamba activate yeast_rnaseq_cli
#Make sure shared micromamba exists
ls -l /scratch/grp/msc_appbio/Group4_ABCC/tools
#Clone your personal env to shared env
/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba \
  create \
  -p /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli \
  --clone yeast_rnaseq_cli \
  -y
#team members use the shared environment
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/yeast_rnaseq_cli

#R env building 
# craete a  yml with packages and version
# Create it using the shared micromamba:
/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba \
  create -p /scratch/grp/msc_appbio/Group4_ABCC/envs/R_3.6.1_env \
  -f R_env.yml -y

#team use
export MAMBA_EXE=/scratch/grp/msc_appbio/Group4_ABCC/tools/micromamba
eval "$($MAMBA_EXE shell hook --shell bash)"
micromamba activate /scratch/grp/msc_appbio/Group4_ABCC/envs/R_3.6.1_env
R

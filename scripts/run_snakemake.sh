#!/bin/bash
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 7
#SBATCH --time=24:00:00
#SBATCH --mem=56GB
#SBATCH -o /home/a1018048/slurm/PDX_Gar15-13_Veh_DHT_Sarm_RNASeq/%x_%j.out
#SBATCH -e /home/a1018048/slurm/PDX_Gar15-13_Veh_DHT_Sarm_RNASeq/%x_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=stephen.pederson@adelaide.edu.au

## Cores
CORES=14
module load arch/arch/haswell
module load arch/haswell
module load modulefiles/arch/haswell
HPC="/hpcfs"

## Project Root
PROJ=${HPC}/users/a1018048/PDX_Gar15-13_Veh_DHT_Sarm_RNASeq

## The environment containing snakemake
micromamba activate snakemake
cd ${PROJ}

## Run snakemake
snakemake \
  --cores ${CORES} \
  --use-conda \
  --notemp \
  --latency-wait 60 \
  --wrapper-prefix 'https://raw.githubusercontent.com/snakemake/snakemake-wrappers/'

## Add files to git
bash ${PROJ}/scripts/update_git.sh

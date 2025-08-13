#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20G
#SBATCH --time=04:15:00     # 4 hours and 15 minutes
#SBATCH --mail-user=jjenn010@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="fast qc"
#SBATCH -p epyc # You can use any of the following; epyc, intel, batch, highmem, gpu

# Load fastqc
module load fastqc

# Print timestamp and node
date
hostname

# Run fastqc on all .fq.gz files in the current dir
fastqc --threads 8 --outdir prelim_fastqc *.fq.gz

echo "fastQC completed!"
date
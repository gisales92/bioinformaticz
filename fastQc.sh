#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20G
#SBATCH --time=04:15:00     # 4 hours and 15 minutes
#SBATCH --mail-user=jjenn010@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="Feature counts"
#SBATCH -p epyc # You can use any of the following; epyc, intel, batch, highmem, gpu

# Load featureCounts (usually part of subread)
module load fastqc

# Print timestamp and node
date
hostname

# Run featureCounts on all STAR-aligned BAMs
fastqc --threads 8 --outdir prelim_fastqc *.fq.gz

echo "fastQC completed!"
date
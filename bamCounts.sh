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
module load subread

# Print timestamp and node
date
hostname

# Run featureCounts on all STAR-aligned BAMs
featureCounts \
  -T 8 \
  -a ./mouse_genome_gencode/genes.gtf \
  -o ./counts.txt \
  -t exon \
  -g gene_id \
  -s 0 \
  ./star_output/*_Aligned.sortedByCoord.out.bam

echo "featureCounts completed!"
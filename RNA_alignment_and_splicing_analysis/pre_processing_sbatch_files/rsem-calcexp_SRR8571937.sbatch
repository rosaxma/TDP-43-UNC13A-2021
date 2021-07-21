#!/bin/bash
#SBATCH --job-name=rsem-calcexp_SRR8571937 --output=/home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/logs/rsem-calcexp_SRR8571937.out --error=/home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/logs/rsem-calcexp_SRR8571937.err --open-mode=append
#SBATCH --mem=128000 --cpus-per-task=16
#SBATCH --time=8:00:00
#SBATCH --mail-type=FAIL --mail-user=rosaxma@stanford.edu
#SBATCH --partition=agitler,owners
#SBATCH --dependency=afterok:26465415
mkdir -p "${L_SCRATCH_JOB}"
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36
rsem-calculate-expression --seed-length 10 -p 16 --temporary-folder "${L_SCRATCH_JOB}"/SRR8571937 --paired-end --bam --no-bam-output --calc-ci /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/SRR8571937.Aligned.toTranscriptome.out.bam /home/groups/agitler/Tools/RefGenomes/Homo_sapiens/UCSC/hg38/Sequence/RsemIndex/genome /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/SRR8571937.rsem || if [ -f /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-rsem-calcexp_SRR8571937.err ]; then echo "${SLURM_JOB_NODELIST}" >> /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-rsem-calcexp_SRR8571937.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-rsem-calcexp_SRR8571937.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
mv /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/SRR8571937.rsem.stat /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/SRR8571937.rsem
exit 0

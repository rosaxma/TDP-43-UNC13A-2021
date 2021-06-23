#!/bin/bash
#SBATCH --job-name=fqc_SRR8571937 --output=/home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/logs/fqc_SRR8571937.out --error=/home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/logs/fqc_SRR8571937.err --open-mode=append
#SBATCH --cpus-per-task=1
#SBATCH --time=1:00:00
#SBATCH --mail-type=FAIL --mail-user=rosaxma@stanford.edu
#SBATCH --partition=agitler,owners
#SBATCH --dependency=afterok:26465415
mkdir -p "${L_SCRATCH_JOB}"
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36
fastqc -o /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/ --noextract /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/SRR8571937_R1.trim.fastq /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/SRR8571937_R2.trim.fastq || if [ -f /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-fqc_SRR8571937.err ]; then echo "${SLURM_JOB_NODELIST}" >> /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-fqc_SRR8571937.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-fqc_SRR8571937.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
exit 0

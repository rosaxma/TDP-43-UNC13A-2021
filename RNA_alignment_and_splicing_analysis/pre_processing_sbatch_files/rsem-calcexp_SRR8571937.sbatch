#!/bin/bash
#SBATCH --job-name=rsem-calcexp_SRR8571937 --output=TDP_depletion_final/logs/rsem-calcexp_SRR8571937.out --error=TDP_depletion_final/logs/rsem-calcexp_SRR8571937.err --open-mode=append
#SBATCH --mem=128000 --cpus-per-task=16
#SBATCH --time=8:00:00
#SBATCH --mail-type=FAIL --mail-user=
#SBATCH --partition=
#SBATCH --dependency=afterok:26465415
mkdir -p "${L_SCRATCH_JOB}"
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36
rsem-calculate-expression --seed-length 10 -p 16 --temporary-folder "${L_SCRATCH_JOB}"/SRR8571937 --paired-end --bam --no-bam-output --calc-ci TDP_depletion_final/SRR8571937.Aligned.toTranscriptome.out.bam RefGenomes/Homo_sapiens/UCSC/hg38/Sequence/RsemIndex/genome TDP_depletion_final/SRR8571937.rsem || if [ -f TDP_depletion_final/"${SLURM_JOBID}"-rsem-calcexp_SRR8571937.err ]; then echo "${SLURM_JOB_NODELIST}" >> TDP_depletion_final/"${SLURM_JOBID}"-rsem-calcexp_SRR8571937.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > TDP_depletion_final/"${SLURM_JOBID}"-rsem-calcexp_SRR8571937.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
mv TDP_depletion_final/SRR8571937.rsem.stat TDP_depletion_final/SRR8571937.rsem
exit 0

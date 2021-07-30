#!/bin/bash
#SBATCH --job-name=leaf-junc_SRR8571937 --output=TDP_depletion_final/logs/leaf-junc_SRR8571937.out --error=TDP_depletion_final/logs/leaf-junc_SRR8571937.err --open-mode=append
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --mail-type=FAIL --mail-user=
#SBATCH --partition=
#SBATCH --dependency=afterok:26465415
mkdir -p "${L_SCRATCH_JOB}"
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36
samtools view TDP_depletion_final/SRR8571937.sorted.bam | Tools/leafcutter/scripts/filter_cs.py | Tools/leafcutter/scripts/sam2bed.pl --use-RNA-strand - TDP_depletion_final/SRR8571937.bed || if [ -f TDP_depletion_final/"${SLURM_JOBID}"-leaf-junc_SRR8571937.err ]; then echo "${SLURM_JOB_NODELIST}" >> TDP_depletion_final/"${SLURM_JOBID}"-leaf-junc_SRR8571937.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > TDP_depletion_final/"${SLURM_JOBID}"-leaf-junc_SRR8571937.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
Tools/leafcutter/scripts/bed2junc.pl TDP_depletion_final/SRR8571937.bed TDP_depletion_final/SRR8571937.junc || if [ -f TDP_depletion_final/"${SLURM_JOBID}"-leaf-junc_SRR8571937.err ]; then echo "${SLURM_JOB_NODELIST}" >> TDP_depletion_final/"${SLURM_JOBID}"-leaf-junc_SRR8571937.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > TDP_depletion_final/"${SLURM_JOBID}"-leaf-junc_SRR8571937.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
exit 0

#!/bin/bash
#SBATCH --job-name=majiq_build --output=TDP_depletion_final/logs/majiq_build.out --error=TDP_depletion_final/logs/majiq_build.err --open-mode=append
#SBATCH --cpus-per-task=16
#SBATCH --time=10:00:00
#SBATCH --mail-type=FAIL --mail-user=
#SBATCH --partition=
#SBATCH --dependency=afterok:26465415:26465420:26465425:26465430:26465435:26465441:26465446:26465452:26465461:26465474:26465489:26465501:26465512:26465517:26465523:26465528
mkdir -p "${L_SCRATCH_JOB}"
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36
majiq build /Tools/RefGenomes/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gff3 -c TDP_depletion_final/MAJIQ/config -j 16 -o TDP_depletion_final/MAJIQ/ --min-intronic-cov 1 --simplify || if [ -f TDP_depletion_final/"${SLURM_JOBID}"-majiq_build.err ]; then echo "${SLURM_JOB_NODELIST}" >> TDP_depletion_final/"${SLURM_JOBID}"-majiq_build.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > TDP_depletion_final/"${SLURM_JOBID}"-majiq_build.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
exit 0

#!/bin/bash
#SBATCH --job-name=leaf-clust_introns --output=TDP_depletion_final/logs/leaf-clust_introns.out --error=TDP_depletion_final/logs/leaf-clust_introns.err --open-mode=append
#SBATCH --cpus-per-task=1
#SBATCH --time=3:00:00
#SBATCH --mail-type=FAIL --mail-user=
#SBATCH --partition=
#SBATCH --dependency=afterok:26465418:26465423:26465428:26465433:26465439:26465444:26465450:26465455:26465469:26465482:26465495:26465509:26465515:26465521:26465526:26465531
mkdir -p "${L_SCRATCH_JOB}"
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36
find -L TDP_depletion_final -maxdepth 1 -name '*.junc' > TDP_depletion_final/juncfiles.txt
python /Tools/leafcutter/clustering/leafcutter_cluster.py -j TDP_depletion_final/juncfiles.txt -rTDP_depletion_final/ || if [ -f TDP_depletion_final/"${SLURM_JOBID}"-leaf-clust_introns.err ]; then echo "${SLURM_JOB_NODELIST}" >> TDP_depletion_final/"${SLURM_JOBID}"-leaf-clust_introns.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > TDP_depletion_final/"${SLURM_JOBID}"-leaf-clust_introns.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
exit 0

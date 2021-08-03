#!/bin/bash
#SBATCH --job-name=majiq-Dpsi_control_vs_TDP_negative --output=TDP_depletion_final/logs/majiq-Dpsi_control_vs_TDP_negative.out --error=TDP_depletion_final/logs/majiq-Dpsi_control_vs_TDP_negative.err --open-mode=append
#SBATCH --cpus-per-task=1
#SBATCH --time=3:00:00
#SBATCH --mail-type=FAIL --mail-user=
#SBATCH --partition=
#SBATCH --dependency=afterok:26465537
mkdir -p "${L_SCRATCH_JOB}"
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36
majiq deltapsi -grp1 TDP_depletion_final/MAJIQ/SRR8571937.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571939.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571941.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571944.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571947.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571949.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571951.sorted.majiq -grp2 TDP_depletion_final/MAJIQ/SRR8571938.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571940.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571942.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571945.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571948.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571950.sorted.majiq TDP_depletion_final/MAJIQ/SRR8571952.sorted.majiq -j 1 -o TDP_depletion_final/MAJIQ/control_vs_TDP_negative/ -n control TDP_negative || { rm -rf TDP_depletion_final/MAJIQ/control_vs_TDP_negative/ TDP_depletion_final/majiq-Dpsi_control_vs_TDP_negative.sbatch; exit 0; }
voila tsv -j 1 TDP_depletion_final/MAJIQ/splicegraph.sql TDP_depletion_final/MAJIQ/control_vs_TDP_negative/control_TDP_negative.deltapsi.voila -f TDP_depletion_final/MAJIQ/control_vs_TDP_negative/control_vs_TDP_negative.filtered.tsv || if [ -f TDP_depletion_final/"${SLURM_JOBID}"-majiq-Dpsi_control_vs_TDP_negative.err ]; then echo "${SLURM_JOB_NODELIST}" >> TDP_depletion_final/"${SLURM_JOBID}"-majiq-Dpsi_control_vs_TDP_negative.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > TDP_depletion_final/"${SLURM_JOBID}"-majiq-Dpsi_control_vs_TDP_negative.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
exit 0

#!/bin/bash
#SBATCH --job-name=trim_SRR8571937 --output=/home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/logs/trim_SRR8571937.out --error=/home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/logs/trim_SRR8571937.err --open-mode=append
#SBATCH --mem=8000 --cpus-per-task=2
#SBATCH --time=2:00:00
#SBATCH --mail-type=FAIL --mail-user=rosaxma@stanford.edu
#SBATCH --partition=agitler,owners
mkdir -p "${L_SCRATCH_JOB}"
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36
java -Xmx8g -Djava.io.tmpdir="${L_SCRATCH_JOB}" -jar /home/groups/agitler/Tools/Trimmomatic/trimmomatic.jar PE -threads 2 -phred33 ./SRR8571937_R1.fastq.gz ./SRR8571937_R2.fastq.gz /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/SRR8571937_R1.trim.fastq /dev/null /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/SRR8571937_R2.trim.fastq /dev/null ILLUMINACLIP:/home/groups/agitler/Tools/Trimmomatic/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 || if [ -f /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-trim_SRR8571937.err ]; then echo "${SLURM_JOB_NODELIST}" >> /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-trim_SRR8571937.err && exit 1; else echo "${SLURM_JOB_NODELIST}" > /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/"${SLURM_JOBID}"-trim_SRR8571937.err && scontrol requeue "${SLURM_JOBID}" && sleep 42m; fi
exit 0

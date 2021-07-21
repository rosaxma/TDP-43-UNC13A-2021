#!/bin/bash
module load R/4.0.2 perl python/3.6 py-scipy/1.4.1_py36

leafFDR="0.05"

# Uncomment to plot splice junctions with a different adjusted p value threshold
#/home/groups/agitler/Tools/leafcutter/scripts/ds_plots.R -f ${leafFDR} -o /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/LeafCutter/control_vs_TDP_negative.pdf -e /home/groups/agitler/Tools/RefGenomes/Homo_sapiens/UCSC/hg38/Annotation/Genes/leafcutter_exons.txt.gz /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/leafcutter_perind_numers.counts.gz /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/LeafCutter/control_vs_TDP_negative_group.txt /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/LeafCutter/control_vs_TDP_negative_cluster_significance.txt

# Uncomment to prepare results for visualisation with a different adjusted p value threshold
#/home/groups/agitler/Tools/leafcutter/leafviz/prepare_results.R -f ${leafFDR} -m /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/LeafCutter/control_vs_TDP_negative_group.txt -c control_vs_TDP_negative -o /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/LeafCutter/control_vs_TDP_negative.RData /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/leafcutter_perind_numers.counts.gz /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/LeafCutter/control_vs_TDP_negative_cluster_significance.txt /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/LeafCutter/control_vs_TDP_negative_effect_sizes.txt /home/groups/agitler/Tools/RefGenomes/Homo_sapiens/UCSC/hg38/Annotation/Genes/leafcutter || exit 0

# Actual command to prepare results for visualisation
cd /home/groups/agitler/Tools/leafcutter/leafviz/
echo 'Launching leafviz: you may need to have to deal with port forwarding on your own to access the website'
./run_leafviz.R /home/users/rosaxma/oak/Shared_Sequencing/Rosa/RNAseq/TDP_depletion_final/LeafCutter/control_vs_TDP_negative.RData

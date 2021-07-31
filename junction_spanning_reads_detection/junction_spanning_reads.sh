#!/bin/bash 
# Author: Rosa Ma
# 9/15/2020
#The software required for this script are samtools (1.10) and bedtools (2.27.1). Other versions should work as well

module load biology bedtools/2.27.1

#could change with genome build
#when the reads are mapped to GRCh38, the "chr" prefix needs to be removed. For example,chr19 needs to be changed to 19
#The range of chromosome that contains the cryptic exon and the spanning exons; STMN2: exon1-exon2; UNC13A:exon19-exon21
STMN2_exon_range="chr8:79611117-79636897"
UNC13A_exon_range="chr19:17641393-17645843"
bam_file_location=""
#use ../ because all the following files are located in the previous directory
STMN2_cryptic_exon_coordinates="STMN2_hg38_cryptic_exon.bed"
STMN2_exon_1_coordinates="STMN2_hg38_exon_1.bed"
STMN2_exon_2_coordinates="STMN2_hg38_exon_2.bed"
#128 bp cryptic exon
UNC13A_cryptic_exon_coordinates="UNC13A_hg38_cryptic_exon.bed"
#178 bp crypitc exon
UNC13A_alt_cryptic_exon_coordinates="UNC13A_hg38_alt_cryptic_exon.bed"

UNC13A_exon_19_coordinates="UNC13A_hg38_exon_19.bed"
UNC13A_exon_20_coordinates="UNC13A_hg38_exon_20.bed"
UNC13A_exon_21_coordinates="UNC13A_hg38_exon_21.bed"
output_file_name="FTD_NY_genome_STMN2_UNC13A_overlapping_ex19_included_alt_cx.txt"
#generating a list of bam files we want to probe.The bam files should have been already sorted and indexed (i.e they all have their corresponding *.bam.bai files"
file_list=`ls ${bam_file_location}/*.sorted.bam`
#cx = cryptic exon
echo "filename,STMN2_ex1_cx,STMN2_ex1_ex2,STMN2_%, UNC13A_ex19_ex20, UNC13A_ex20_cx,UNC13A_ex20_alt_cx,UNC13A_cx_ex21,UNC13A_ex20_ex21,UNC13A_ex20_cx_%,UNC13A_ex20_alt_cx_%,UNC13A_cx_ex21_%" > ${output_file_name}
for bamfile in $file_list
do 
   #echo "Extracting the filename"
   bamfile_name=$(echo "$bamfile" | awk -F/ '{print $NF}')
   # first we take out all the reads that are mapped to the *_exon range; next, we take out all the reads that can be partially mapped to the cryptic exon;
   # finally among the reads that are partially mapped to the cryptic exon, we take out the reads that also overlap one of the spanning canonical exon;
   # Since the cryptic exon of UNC13A is 128 (178) bp long and the longest read length is most likely to be 125 bp, I dont expect to see any reads that would over lap both juctions
   # Last step is just to count the number of reads that satisfies the requiremenets above.
   # STMN2  
   reads_spanning_STMN2_exon1_cryptic_exon=`samtools view -b $bamfile $STMN2_exon_range | bedtools intersect -split -abam stdin -b ${STMN2_cryptic_exon_coordinates} |bedtools intersect -split -abam stdin -b ${STMN2_exon_1_coordinates} -bed |wc -l`
   reads_spanning_STMN2_exon1_exon2=`samtools view -b $bamfile $STMN2_exon_range | bedtools intersect -split -abam stdin -b ${STMN2_exon_1_coordinates} |bedtools intersect -split -abam stdin -b ${STMN2_exon_2_coordinates} -bed |wc -l`
   if [[ $reads_spanning_STMN2_exon1_exon2 -gt 0 ]]
   then
   	STMN2_percentage=`echo "scale=5; ${reads_spanning_STMN2_exon1_cryptic_exon}*100/(${reads_spanning_STMN2_exon1_cryptic_exon}+${reads_spanning_STMN2_exon1_exon2})" | bc`
   else
	STMN2_percentage="NA"
   fi
   #UNC13A
   reads_spanning_UNC13A_exon19_exon20=`samtools view -b $bamfile $UNC13A_exon_range | bedtools intersect -split -abam stdin -b ${UNC13A_exon_20_coordinates} |bedtools intersect -split -abam stdin -b ${UNC13A_exon_19_coordinates} -bed |wc -l`
   reads_spanning_UNC13A_exon20_cryptic_exon=`samtools view -b $bamfile $UNC13A_exon_range | bedtools intersect -split -abam stdin -b ${UNC13A_cryptic_exon_coordinates} |bedtools intersect -split -abam stdin -b ${UNC13A_exon_20_coordinates} -bed |wc -l`
   reads_spanning_UNC13A_exon20_alt_cryptic_exon=`samtools view -b $bamfile $UNC13A_exon_range | bedtools intersect -split -abam stdin -b ${UNC13A_alt_cryptic_exon_coordinates} |bedtools intersect -split -abam stdin -b ${UNC13A_exon_20_coordinates} -bed |wc -l`
   reads_spanning_UNC13A_cryptic_exon_exon21=`samtools view -b $bamfile $UNC13A_exon_range | bedtools intersect -split -abam stdin -b ${UNC13A_cryptic_exon_coordinates} |bedtools intersect -split -abam stdin -b ${UNC13A_exon_21_coordinates} -bed |wc -l`
   reads_spanning_UNC13A_exon20_exon21=`samtools view -b $bamfile $UNC13A_exon_range | bedtools intersect -split -abam stdin -b ${UNC13A_exon_20_coordinates} |bedtools intersect -split -abam stdin -b ${UNC13A_exon_21_coordinates} -bed |wc -l`
   if [[ $reads_spanning_UNC13A_exon20_exon21 -gt 0 ]]
   then 
   	UNC13A_ex20_cx_percentage=`echo "scale=5; ${reads_spanning_UNC13A_exon20_cryptic_exon}*100/(${reads_spanning_UNC13A_exon20_cryptic_exon}+${reads_spanning_UNC13A_exon20_exon21})" | bc`
   	UNC13A_ex20_alt_cx_percentage=`echo "scale=5; ${reads_spanning_UNC13A_exon20_alt_cryptic_exon}*100/(${reads_spanning_UNC13A_exon20_alt_cryptic_exon}+${reads_spanning_UNC13A_exon20_exon21})" | bc`

	UNC13A_cx_ex21_percentage=`echo "scale=5; ${reads_spanning_UNC13A_cryptic_exon_exon21}*100/(${reads_spanning_UNC13A_cryptic_exon_exon21}+${reads_spanning_UNC13A_exon20_exon21})" | bc`
   else 
	UNC13A_ex20_cx_percentage="NA"
	UNC13A_cx_ex21_percentage="NA"
   fi
   echo "$bamfile_name,$reads_spanning_STMN2_exon1_cryptic_exon,$reads_spanning_STMN2_exon1_exon2,$STMN2_percentage,$reads_spanning_UNC13A_exon19_exon20,$reads_spanning_UNC13A_exon20_cryptic_exon,$reads_spanning_UNC13A_exon20_alt_cryptic_exon,$reads_spanning_UNC13A_cryptic_exon_exon21,$reads_spanning_UNC13A_exon20_exon21,$UNC13A_ex20_cx_percentage,$UNC13A_ex20_alt_cx_percentage,$UNC13A_cx_ex21_percentage" >> ${output_file_name}
done



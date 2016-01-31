#!/bin/bash

scale_factor=29.17
# 2 second event gamma HRF

SUBS=( MM_507 )
#( MM_502 MM_503 MM_505 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524  MM_525 MM_526 MM_527 MM_528 MM_529 MM_530 )
#   
#MM_522 MM_523 MM_524
#  MM_507 
#  

for sub in "${SUBS[@]}"; do

DATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
STATSDIR=$DATADIR/analysis/STAT

MODEL=output_m3_noSmooth_sans_preEx_weight
#FIR

for run in {1..8}
# for n in "${FEATLIST[@]}"
do
	
	echo ${STATSDIR}/run${run}_${MODEL}.feat
	
	mean_func=${STATSDIR}/run${run}_${MODEL}.feat/mean_func.nii.gz
	
	cd ${STATSDIR}/run${run}_${MODEL}.feat/stats

	COPELIST=( $(ls cope*.nii.gz) )
	#PELIST=( $(ls pe*.nii.gz) )
	
	#COMBINEDLIST=( ${COPELIST[@]} ${PELIST[@]} )
	
	for m in "${COPELIST[@]}"
	#${COMBINEDLIST[@]}
	do
	
	IFS='.' read -r id string <<< "$m"
	
	echo $id
	
	printf -v output_image "%s_perChanges.nii.gz" $id
	
	echo $output_image
		
	fslmaths ${m} -mul ${scale_factor} -div ${mean_func} ${output_image}
	
	done

done
done
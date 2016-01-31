#!/bin/bash

scale_factor=58.72
# 3 second event double gamma HRF

SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 25 26 )
# 24 26

for sub in "${SUBS[@]}"; do

STATSDIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/$sub/analysis
 
for run in {1..3}
do
	
	echo ${STATSDIR}/run${run}_memory_value_cueAlt_NS.feat
	#noDis_
	
	mean_func=${STATSDIR}/run${run}_memory_value_cueAlt_NS.feat/mean_func.nii.gz
	#noDis_

	cd ${STATSDIR}/run${run}_memory_value_cueAlt_NS.feat/stats
	#noDis_

	COPELIST=( $(ls cope*.nii.gz) )

	for m in "${COPELIST[@]}"
	do
	
	IFS='.' read -r id string <<< "$m"
	
	echo $id
	
	printf -v output_image "%s_perChanges.nii.gz" $id
	
	echo $output_image
		
	fslmaths ${m} -mul ${scale_factor} -div ${mean_func} ${output_image}
	
	done

done
done
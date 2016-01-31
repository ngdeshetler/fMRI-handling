#!/bin/bash

SUBS=( MM_507 )
#( MM_502 MM_503 MM_505 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524 MM_525 MM_526 MM_527 MM_528 MM_529 MM_530 )

#MM_507 
#  
#  

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		MASKDIR=$FSLDATADIR/masks/$RUN
		STATSDIR=$FSLDATADIR/analysis/STAT

		#/Native

		sides=( R L )
		areas=( CA1 CA3DG Sub )
		# Sub 

		printf -v FEATDIR "%s/run%d_output_m3_noSmooth_sans_preEx_FIR.feat" $STATSDIR $run
		#_preEx
		#FIR

		cd /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/scripts
		cd $FEATDIR/stats
		mkdir extractions

		echo $FEATDIR

		PCLIST=( $(ls cope*_perChanges.nii.gz) )

		for r in "${PCLIST[@]}"
		do

			for m in "${sides[@]}"
			do
	
				for p in "${areas[@]}"
				do
					printf -v ROI "%s/%s_%s_fixed_test.nii.gz" $MASKDIR $m $p
	
					IFS='_' read -r id string <<< "$r"
	
					printf -v OUT_FILE "./extractions/%s_%s%s_test_mean.txt" $id $m $p
	
					echo $OUT_FILE
	
					fslstats $r -k $ROI -M > ${OUT_FILE}	
				done
			done
		done
		
# 		sides=( right left )
# 		areas=( CA1 CA3DG Sub )
# 		parts=( Head Tail ERC PHG ) 
# 		for r in "${PCLIST[@]}"; do
# 		
# 			IFS='_' read -r id string <<< "$r"
# 			
# 			for m in "${sides[@]}"; do
# 	
# 				for p in "${areas[@]}"; do
# 					echo ${id}_${m}${p}_ASHS_mean.txt	
# 					fslstats $r -k $MASKDIR/ASHS_${m}_${p}_fixed.nii.gz -M > ./extractions/${id}_${m}${p}_ASHS_mean.txt	
# 				done
# 				
# 				for p in "${parts[@]}"; do
# 					echo ${id}_${m}${p}_ASHS_mean.txt
# 					fslstats $r -k $MASKDIR/ASHS_${m}_${p}.nii.gz -M > ./extractions/${id}_${m}${p}_ASHS_mean.txt	
# 				done
# 				
# 			done
# 		done
	done
done
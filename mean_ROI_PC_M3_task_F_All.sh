#!/bin/bash

SUBS=( MM_502 MM_503 MM_505 MM_508 MM_507 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524  )
# )
#   
#  MM_525 MM_526 MM_527 MM_528 MM_529 MM_530
# MM_507

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		MASKDIR=$FSLDATADIR/masks/$RUN
		STATSDIR=$FSLDATADIR/analysis/STAT

		#pvals=( 05 10 )
		pervals=( 50 25 )

		printf -v FEATDIR "%s/run%d_output_m3_noSmooth_mem_sans.feat" $STATSDIR $run
		#_preEx
		
		cd $FEATDIR/stats
		
		#mkdir extractions

		echo $FEATDIR

		PCLIST=( $(ls *_perChanges.nii.gz) )
		

	
		for j in "${pervals[@]}"
		do
			sides=( R L )
			areas=( CA1 CA3DG Sub )
			#parts=( Head Tail Body )
			
			for m in "${sides[@]}"
			do

				for p in "${areas[@]}"
				do
					
# 					for q in "${parts[@]}"
# 					do
				
						printf -v TASK_MASK "$MASKDIR/%s_%s_zstat_%s_task_succF.nii.gz" $m $p $j
						#$q
				
						printf -v OUT_FILE_V "./extractions/%s%s_%s_task_succF_size.txt" $m $p $j
						#$q 
				
						fslstats $TASK_MASK -V > ${OUT_FILE_V}
											
						for r in "${PCLIST[@]}"
						do
						
							IFS='_' read -r id string <<< "$r"

							printf -v OUT_FILE "./extractions/%s_%s%s_%s_task_succF_mean.txt" $id $m $p $j	
							#$q					

							echo $OUT_FILE

							fslstats $r -k $TASK_MASK -M > ${OUT_FILE}


						done
# 					done
				done
			done
			
			for m in "${sides[@]}"
			do

				for p in "${areas[@]}"
				do
					
# 					for q in "${parts[@]}"
# 					do
				
						printf -v TASK_MASK "$MASKDIR/%s_%s_zstat_%s_task_succAll.nii.gz" $m $p $j
						#$q
				
						printf -v OUT_FILE_V "./extractions/%s%s_%s_task_succAll_size.txt" $m $p $j
						#$q 
				
						fslstats $TASK_MASK -V > ${OUT_FILE_V}
											
						for r in "${PCLIST[@]}"
						do
						
							IFS='_' read -r id string <<< "$r"

							printf -v OUT_FILE "./extractions/%s_%s%s_%s_task_succAll_mean.txt" $id $m $p $j	
							#$q					

							echo $OUT_FILE

							fslstats $r -k $TASK_MASK -M > ${OUT_FILE}


						done
# 					done
				done
			done
		done
		

		
		# for j in "${pervals[@]}"
# 		do
# 		
# 			sides=( right left )
# 			areas=( CA1 CA3DG Sub )
# 			parts=( Head Tail ERC PHG ) 
# 			for r in "${PCLIST[@]}"; do
# 		
# 				IFS='_' read -r id string <<< "$r"
# 			
# 				for m in "${sides[@]}"; do
# 	
# 					for p in "${areas[@]}"; do
# 						printf -v TASK_MASK "$MASKDIR/%s_%s_zstat_%s_fail_test.nii.gz" $m $p $j
# 						echo ./extractions/${id}_${m}${p}_${j}_fail_mean.txt	
# 						fslstats $r -k $MASKDIR/ASHS_${m}_${p}_fixed.nii.gz -k $TASK_MASK -M > ./extractions/${id}_${m}${p}_${j}_fail_mean.txt	
# 					done
# 			
# 					for p in "${parts[@]}"; do
# 						printf -v TASK_MASK "$MASKDIR/%s_%s_zstat_%s_fail_test.nii.gz" $m $p $j
# 						echo ./extractions/${id}_${m}${p}_${j}_fail_mean.txt	
# 						fslstats $r -k $MASKDIR/ASHS_${m}_${p}.nii.gz -k $TASK_MASK -M > ./extractions/${id}_${m}${p}_${j}_fail_mean.txt	
# 					done
# 				
# 				done
# 			done
# 		done
 	done
done


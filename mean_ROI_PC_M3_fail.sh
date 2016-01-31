#!/bin/bash

SUBS=( MM_507 )
#( MM_502 MM_503 MM_505 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_523 MM_524 MM_525 MM_526 MM_527 MM_528 MM_529 MM_530 )

#MM_507 
#  
#MM_522 

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		MASKDIR=$FSLDATADIR/masks/$RUN
		STATSDIR=$FSLDATADIR/analysis/STAT

		#pvals=( 05 10 )
		pervals=( 50 25 20 )
		#

		printf -v FEATDIR "%s/run%d_output_m3_noSmooth_sans_preEx_FIR.feat" $STATSDIR $run
		#m3_noSmooth_sans
		#m3_noSmooth_mem_sans
		#_preEx
		
		cd /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/scripts
		cd $FEATDIR/stats
		
		mkdir extractions

		echo $FEATDIR

		PCLIST=( $(ls *_perChanges.nii.gz) )
		#PCLIST1=( $(ls cope?.nii.gz) )
		#PCLIST2=( $(ls cope??.nii.gz) )
		#COMBINEDLIST=( ${PCLIST1[@]} ${PCLIST2[@]} )
	
	
		
# 		for j in "${pvals[@]}"
# 		do
# 		
# 			printf -v TASK_MASK "$MASKDIR/pzstat1_%s_fail.nii.gz" $j
# 			sides=( R L )
# 			areas=( CA1 CA3DG Sub )
# 			for m in "${sides[@]}"
# 			do
# 
# 				for p in "${areas[@]}"
# 				do
# 				
# 				printf -v ROI "%s/%s_%s_fixed.nii.gz" $MASKDIR $m $p
# 				## MM_25 and on don't have _test
# 				#_test
# 				printf -v OUT_FILE_V "./extractions/%s%s_%s_fail_test_size.txt" $m $p $j
# 				
# 				fslstats $TASK_MASK -k $ROI -V > ${OUT_FILE_V}
# 				#  
# 							
# 					for r in "${PCLIST[@]}"
# 					do
# 						
# 						IFS='_' read -r id string <<< "$r"
# 
# 						printf -v OUT_FILE "./extractions/%s_%s%s_%s_fail_test_mean.txt" $id $m $p $j						
# 
# 						echo $OUT_FILE
# 
# 						fslstats $r -k $ROI -k $TASK_MASK -M > ${OUT_FILE}
# 						#
# 					done
# 				done
# 			done
# 		done
		
# 		for j in "${pervals[@]}"
# 		do
# 			sides=( R L )
# 			areas=( CA1 CA3DG Sub )
# 			#parts=( Head Tail Body )
# 			
# 			for m in "${sides[@]}"
# 			do
# 
# 				for p in "${areas[@]}"
# 				do
# 					
# 					#for q in "${parts[@]}"
# 					#do
# 				
# 						printf -v TASK_MASK "$MASKDIR/%s_%s_zstat_%s_fail.nii.gz" $m $p $j
# 				
# 						printf -v OUT_FILE_V "./extractions/%s%s_%s_fail_test_size.txt" $m $p $j
# 				
# 						fslstats $TASK_MASK -V > ${OUT_FILE_V}
# 											
# 						for r in "${PCLIST[@]}"
# 						do
# 						
# 							IFS='_' read -r id string <<< "$r"
# 
# 							printf -v OUT_FILE "./extractions/%s_%s%s_%s_fail_test_mean.txt" $id $m $p $j						
# 
# 							echo $OUT_FILE
# 
# 							fslstats $r -k $TASK_MASK -M > ${OUT_FILE}
# 
# 
# 						done
# 					#done
# 				done
# 			done
# 		done
# 		
# 		for j in "${pvals[@]}"
# 		do
# 		
# 			printf -v TASK_MASK "$MASKDIR/pzstat1_%s_fail.nii.gz" $j
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
# 						echo ./extractions/${id}_${m}${p}_${j}_fail_mean.txt	
# 						fslstats $r -k $MASKDIR/ASHS_${m}_${p}_fixed.nii.gz -k $TASK_MASK -M > ./extractions/${id}_${m}${p}_${j}_fail_mean.txt	
# 					done
# 			
# 					for p in "${parts[@]}"; do
# 						echo ./extractions/${id}_${m}${p}_${j}_fail_mean.txt	
# 						fslstats $r -k $MASKDIR/ASHS_${m}_${p}.nii.gz -k $TASK_MASK -M > ./extractions/${id}_${m}${p}_${j}_fail_mean.txt	
# 					done
# 				
# 				done
# 			done
# 		done
		
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
				
						printf -v TASK_MASK "$MASKDIR/%s_%s_zstat_%s_fail_sans.nii.gz" $m $p $j
						#CueFail
						#$q
						#_sans
				
						printf -v OUT_FILE_V "./extractions/%s%s_%s_fail_sans_size.txt" $m $p $j
						#
						#$q 
				
						fslstats $TASK_MASK -V > ${OUT_FILE_V}
											
						for r in "${PCLIST[@]}"
						#COMBINEDLIST
						#
						do
						
							IFS='_' read -r id string <<< "$r"

							printf -v OUT_FILE "./extractions/%s_%s%s_%s_fail_sans_mean.txt" $id $m $p $j	
							#_alt
							#fail_sans
							#$q					

							echo $OUT_FILE

							#echo "fslstats" $r "-k" $TASK_MASK "-M >" ${OUT_FILE}

							fslstats ${r} -k ${TASK_MASK} -M > ${OUT_FILE}


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


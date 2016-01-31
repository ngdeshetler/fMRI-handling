#!/bin/bash

SUBS=( MM_502 MM_503 MM_505 MM_508 MM_507 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524 )

#
#  
#  

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		MASKDIR=$FSLDATADIR/masks/$RUN
		STATSDIR=$FSLDATADIR/analysis/STAT

		sides=( R L )
		areas=( CA1 CA3DG Sub )
		pvals=( 50 25 )

		printf -v FEATDIR "%s/run%d_output_m3_noSmooth_preEx.feat" $STATSDIR $run
		#
		
		cd $FEATDIR/stats

		echo $FEATDIR

		PCLIST=( $(ls *_perChanges.nii.gz) )
		
		for j in "${pvals[@]}"
		do

			for m in "${sides[@]}"
			do

				for p in "${areas[@]}"
				do
				
				printf -v TASK_MASK "$MASKDIR/%s_%s_zfstat_%s_alt_test.nii.gz" $m $p $j
				
				printf -v ROI "%s/%s_%s_fixed_test.nii.gz" $MASKDIR $m $p
				printf -v OUT_FILE_V "./extractions/%s%s_%s_alt_test_size.txt" $m $p $j
				
				fslstats $TASK_MASK -k $ROI -V > ${OUT_FILE_V}
							
					for r in "${PCLIST[@]}"
					do
						
						IFS='_' read -r id string <<< "$r"

						printf -v OUT_FILE "./extractions/%s_%s%s_%s_alt_test_mean.txt" $id $m $p $j			

						echo $OUT_FILE

						fslstats $r -k $ROI -k $TASK_MASK -M > ${OUT_FILE}
					done
				done
			done
			
			
		done
		
		for j in "${pvals[@]}"
		do
		
		printf -v TASK_MASK "$MASKDIR/pfstat1_%s.nii.gz" $j
		sides=( right left )
		areas=( CA1 CA3DG Sub )
		parts=( Head Tail ERC PHG ) 
			for r in "${PCLIST[@]}"; do
		
				IFS='_' read -r id string <<< "$r"
			
				for m in "${sides[@]}"; do
	
					for p in "${areas[@]}"; do
						printf -v TASK_MASK "$MASKDIR/%s_%s_zfstat_%s_alt_test.nii.gz" $m $p $j
						echo ./extractions/${id}_${m}${p}_${j}_ASHS_mean.txt	
						fslstats $r -k $MASKDIR/ASHS_${m}_${p}_fixed.nii.gz -k $TASK_MASK -M > ./extractions/${id}_${m}${p}_${j}_ASHS_mean.txt	
					done
			
					for p in "${parts[@]}"; do
						printf -v TASK_MASK "$MASKDIR/%s_%s_zfstat_%s_alt_test.nii.gz" $m $p $j
						echo ./extractions/${id}_${m}${p}_${j}_ASHS_mean.txt
						fslstats $r -k $MASKDIR/ASHS_${m}_${p}.nii.gz -k $TASK_MASK -M > ./extractions/${id}_${m}${p}_${j}_ASHS_mean.txt	
					done
				
				done
			done
		done
	done
	
	for run in {1..8}; do

		printf -v RUN "run%d" $run

		MASKDIR=$FSLDATADIR/masks/$RUN
		STATSDIR=$FSLDATADIR/analysis/STAT

		#/Native

		sides=( R L )
		areas=( CA1 CA3DG Sub )
		pvals=( 05 10 )


		printf -v FEATDIR "%s/run%d_output_m3_noSmooth_preEx.feat" $STATSDIR $run
		#
		cd $FEATDIR/stats

		echo $FEATDIR

		PCLIST=( $(ls *_perChanges.nii.gz) )
		
		for j in "${pvals[@]}"
		do
		
		printf -v TASK_MASK "$MASKDIR/pfstat1_%s.nii.gz" $j

			for m in "${sides[@]}"
			do

				for p in "${areas[@]}"
				do
				
				printf -v ROI "%s/%s_%s_fixed_test.nii.gz" $MASKDIR $m $p
				printf -v OUT_FILE_V "./extractions/%s%s_%s_test_size.txt" $m $p $j
				#
				rm $OUT_FILE_V
				fslstats $TASK_MASK -k $ROI -V > ${OUT_FILE_V}
				#  
							
					for r in "${PCLIST[@]}"
					do
						
						IFS='_' read -r id string <<< "$r"

						printf -v OUT_FILE "./extractions/%s_%s%s_%s_test_mean.txt" $id $m $p $j	

						echo $OUT_FILE

						fslstats $r -k $ROI -k $TASK_MASK -M > ${OUT_FILE}

					done
				done
			done
		done
		
		for j in "${pvals[@]}"
		do
		
		printf -v TASK_MASK "$MASKDIR/pfstat1_%s.nii.gz" $j
		sides=( right left )
		areas=( CA1 CA3DG Sub )
		parts=( Head Tail ERC PHG ) 
			for r in "${PCLIST[@]}"; do
		
				IFS='_' read -r id string <<< "$r"
			
				for m in "${sides[@]}"; do
	
					for p in "${areas[@]}"; do
						echo ./extractions/${id}_${m}${p}_${j}_ASHS_mean.txt
						fslstats $r -k $MASKDIR/ASHS_${m}_${p}_fixed.nii.gz -k $TASK_MASK -M > ./extractions/${id}_${m}${p}_${j}_ASHS_mean.txt	
					done
			
					for p in "${parts[@]}"; do
						echo ./extractions/${id}_${m}${p}_${j}_ASHS_mean.txt
						fslstats $r -k $MASKDIR/ASHS_${m}_${p}.nii.gz -k $TASK_MASK -M > ./extractions/${id}_${m}${p}_${j}_ASHS_mean.txt	
					done
				
				done
			done
		done
	done
	
done


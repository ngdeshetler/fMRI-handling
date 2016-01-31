#!/bin/bash

SUBS=( MM_502 MM_503 MM_505 MM_508 MM_507 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 )

#
#  
#  

		sides=( right left )
		areas=( CA1 CA3DG Sub )
		parts=( Head Tail ERC PHG ) 
		
for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		MASKDIR=$FSLDATADIR/masks/$RUN
		STATSDIR=$FSLDATADIR/analysis/STAT

		#/Native

		printf -v FEATDIR "%s/run%d_output_m3_noSmooth.feat" $STATSDIR $run

		cd $FEATDIR/stats

		echo $FEATDIR

		PCLIST=( $(ls *_perChanges.nii.gz) )

		for r in "${PCLIST[@]}"; do
		
			IFS='_' read -r id string <<< "$r"
			
			for m in "${sides[@]}"; do
	
				for p in "${areas[@]}"; do
					fslstats $r -k $MASKDIR/ASHS_${m}_${p}_fixed.nii.gz -M > ./extractions/${id}_${m}${p}_ASHS_mean.txt	
				done
				
				for p in "${parts[@]}"; do
					fslstats $r -k $MASKDIR/ASHS_${m}_${p}.nii.gz -M > ./extractions/${id}_${m}${p}_ASHS_mean.txt	
				done
				
			done
		done
	done
done

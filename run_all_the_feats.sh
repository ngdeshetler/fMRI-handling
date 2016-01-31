#!/bin/bash

#SUBS=( MM_502 MM_503 MM_505 )

#SUBS=( MM_508 MM_507 MM_509 )
#SUBS=( MM_510 MM_511 MM_512 )
#SUBS=( MM_513 MM_514 MM_515 )
#SUBS=( MM_516 MM_517 MM_518 )
#SUBS=( MM_519 MM_520 MM_521 )
SUBS=( MM_522 MM_523 MM_524 )

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/STAT
	cd $FSLDATADIR

	for run in {1..8}; do
	
	rm -r run${run}_output_m3_noSmooth_preEx.feat
	 
	done
	
	rm -r run1_output_m3_noSmooth_preEx+.feat

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/FEAT_FILES
	cd $FSLDATADIR

	for run in {1..8}; do
	
	feat FEAT_${run}_m3_NS_preEx.fsf 
	done
	
done
#!/bin/sh

SUBS=( MM_522 MM_523 MM_524 )

# MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_520 MM_521
#MM_519 
#  

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/
	cd $FSLDATADIR/reg/ef_temp/
	
	$ANTSPATH/antsIntroduction.sh -d 3 -i BOLD_template.nii.gz \
	-r ../../raw/mprage/mprage_brain.nii.gz -o efTemp_2_mprageRA -t RA
	
done
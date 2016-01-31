#!/bin/sh

SUBS=( MM_522 MM_523 MM_524 )

# MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521
# MM_502 
#  

for sub in "${SUBS[@]}"; do

	cd /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/${sub}/reg
	
	$ANTSPATH/antsIntroduction.sh -d 3 -i mprage.nii.gz \
	-r /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_template/mprageTemptemplate.nii.gz \
	-o mprage2template
	
done


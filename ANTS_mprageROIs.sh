#!/bin/sh

SUBS=( 502 )

# 503 505 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524
# MM_522 MM_523 MM_524
#503 
# 

for sub in "${SUBS[@]}"; do

cd /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${sub}

## clean up ##
#rm mprage_ROIs_mprage_ROIs_*
#rm mprage_ROIs_${sub}.*

## set up files ##
ln -s ../mprage_ROIs_alt.nii.gz template.nii.gz
mv mprage_ROIs_${sub}_brain.nii.gz mprage_ROIs_brain.nii.gz

## run ANTs reg ##
sge qsub '/space/raid/fmri/ANTs/bin/ANTS 3 -m  PR[template.nii.gz,mprage_ROIs_brain.nii.gz,1,4] -t SyN[0.25] -r Gauss[3,0] -o mprage_2_ROIs_ -i 30x90x20 --use-Histogram-Matching  --number-of-affine-iterations 10000x10000x10000x10000x10000 --MI-option 32x16000'  

done


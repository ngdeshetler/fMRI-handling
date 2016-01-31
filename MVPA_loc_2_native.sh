#!/bin/bash

SUBS=( MM_502 MM_503 MM_505 MM_508 MM_507 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 )

#
# 
#
# 

for sub in "${SUBS[@]}"; do

# mkdir /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/loc
# 
#rm /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/loc/*NS*

/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/STAT/localizer_output_smooth.feat/filtered_func_data.nii.gz \
 -applyxfm -init /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/STAT/localizer_output_noSmooth.feat/reg/example_func2highres.mat \
 -out /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/loc/filtered_func_data_S_2native.nii.gz -paddingsize 0.0 \
 -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/raw/mprage/mprage_brain.nii.gz

/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/fslcreatehd 120 128 128 1 2 2 2 1 0 0 0 16  \
/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/loc/filtered_func_data_S_2native_2mm_tmp ; \
/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/loc/filtered_func_data_S_2native.nii.gz \
 -applyxfm -init /space/raid/fmri/fsl-5.0.2.1-centos6_64/etc/flirtsch/ident.mat -out \
 /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/loc/filtered_func_data_S_2native_2mm \
 -paddingsize 0.0 -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/loc/filtered_func_data_S_2native_2mm_tmp

	gunzip /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/loc/filtered_func_data_S_2native_2mm.nii.gz

done


 
#!/bin/bash

# /space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in \
# /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/masks/MM_Visual_Association.nii -applyxfm -init \
# /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/analysis/PRE/run1/reg_standard/standard2highres.mat \
# -out /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks/$1_VA -paddingsize 0.0 \
# -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/raw/MPRAGE_BWM_2/mprage_brain.nii.gz
# 
# 
# /space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/fslcreatehd 120 128 128 1 2 2 2 1 0 0 0 16  \
# /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks/2mm_Visual_Association_tmp.nii.gz ; \
# /space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks/$1_VA.nii.gz\
#  -applyxfm -init /space/raid/fmri/fsl-5.0.2.1-centos6_64/etc/flirtsch/ident.mat \
#  -out /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks/2mm_Visual_Association \
#  -paddingsize 0.0 -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks/2mm_Visual_Association_tmp

fslroi /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/analysis/PRE/run1/filtered_func_data_NS_2native_2mm.nii.gz \
/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/analysis/PRE/run1/filtered_func_data_NS_2native_2mm_EF.nii.gz 72 1

fslmaths /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/analysis/PRE/run1/filtered_func_data_NS_2native_2mm_EF.nii.gz -bin -mul \
/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks/2mm_Visual_Association.nii.gz \
/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks/2mm_Visual_Association_clean

gunzip /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks/2mm_Visual_Association_clean.nii.gz
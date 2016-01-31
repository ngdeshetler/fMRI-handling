#!/bin/sh

SUBS=( MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 )

#
# 
#
# 

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub

for run in {1..8}; do

printf -v RUN "run%d" $run

cd $FSLDATADIR/masks/$RUN

fslmaths L_CA1_fixed.nii.gz -add R_CA1_fixed.nii.gz -bin CA1_fixed
fslmaths L_CA3DG_fixed.nii.gz -add R_CA3DG_fixed.nii.gz -bin CA3DG_fixed

fslmaths L_CA1_fixed.nii.gz -add L_CA3DG_fixed.nii.gz -bin L_CA_fixed
fslmaths R_CA1_fixed.nii.gz -add R_CA3DG_fixed.nii.gz -bin R_CA_fixed

fslmaths ASHS_right_Head.nii.gz -add ASHS_right_Tail.nii.gz -add ASHS_right_Sub.nii.gz \
-add ASHS_right_CA1.nii.gz -add ASHS_right_CA3DG.nii.gz -bin R_hipp_ashs

fslmaths ASHS_left_Head.nii.gz -add ASHS_left_Tail.nii.gz -add ASHS_left_Sub.nii.gz \
-add ASHS_left_CA1.nii.gz -add ASHS_left_CA3DG.nii.gz -bin L_hipp_ashs


fslmaths L_hipp_ashs.nii.gz -add R_hipp_ashs.nii.gz -bin hipp_ashs
fslmaths ASHS_left_ERC.nii.gz -add ASHS_right_ERC.nii.gz -bin ERC_ashs
fslmaths ASHS_left_PHG.nii.gz -add ASHS_right_PHG.nii.gz -bin PHG_ashs

done
done

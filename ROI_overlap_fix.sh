#!/bin/sh

SUBS=( MM_522 MM_523 MM_524 )
# MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524 )

# 
#
# 

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
MASKDIR=$FSLDATADIR/masks

cd $MASKDIR

fslmaths L_CA1_deform.nii.gz -sub L_CA3DG_deform.nii.gz L_1_g_2

fslmaths L_1_g_2.nii.gz -thr 0 -bin L_over_for_1

fslmaths L_1_g_2.nii.gz -uthr 0 -mul -1 -bin L_over_for_3

fslmaths L_CA1.nii.gz -mul L_over_for_1.nii.gz L_CA1_fixed

fslmaths L_CA3DG.nii.gz -mul L_over_for_3.nii.gz L_CA3DG_fixed



fslmaths R_CA1_deform.nii.gz -sub R_CA3DG_deform.nii.gz R_1_g_2

fslmaths R_1_g_2.nii.gz -thr 0 -bin R_over_for_1

fslmaths R_1_g_2.nii.gz -uthr 0 -mul -1 -bin R_over_for_3

fslmaths R_CA1.nii.gz -mul R_over_for_1.nii.gz R_CA1_fixed

fslmaths R_CA3DG.nii.gz -mul R_over_for_3.nii.gz R_CA3DG_fixed


fslmaths R_Sub.nii.gz -sub R_CA1_fixed.nii.gz -sub R_CA3DG_fixed.nii.gz -bin R_Sub_fixed
		
fslmaths L_Sub.nii.gz -sub L_CA1_fixed.nii.gz -sub L_CA3DG_fixed.nii.gz -bin L_Sub_fixed

done
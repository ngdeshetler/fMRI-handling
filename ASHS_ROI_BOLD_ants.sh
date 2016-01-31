#!/bin/bash

#setenv ASHS_ROOT /space/raid/fmri/ashs/ashs_Linux64_rev89_20120524

SUBS=( MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524 ) 

#   )
#   
#  

sides=( right left )
areas=( CA1 CA3DG Sub Head Tail ERC PHG )

for sub in "${SUBS[@]}"; do
	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
	FINAL_MASKS=$FSLDATADIR/masks/ASHS/final
# 
# 	for n in "${sides[@]}"; do
# 
# 		fslmaths $FINAL_MASKS/ASHS_${n}_lfseg_heur.nii.gz -thr 1 -uthr 1 -bin $FINAL_MASKS/ASHS_${n}_CA1.nii.gz
# 
# 		fslmaths $FINAL_MASKS/ASHS_${n}_lfseg_heur.nii.gz -thr 2 -uthr 4 -bin $FINAL_MASKS/ASHS_${n}_CA3DG.nii.gz
# 
# 		fslmaths $FINAL_MASKS/ASHS_${n}_lfseg_heur.nii.gz -thr 5 -uthr 5 -bin $FINAL_MASKS/ASHS_${n}_Head.nii.gz
# 
# 		fslmaths $FINAL_MASKS/ASHS_${n}_lfseg_heur.nii.gz -thr 6 -uthr 6 -bin $FINAL_MASKS/ASHS_${n}_Tail.nii.gz
# 
# 		fslmaths $FINAL_MASKS/ASHS_${n}_lfseg_heur.nii.gz -thr 8 -uthr 8 -bin $FINAL_MASKS/ASHS_${n}_Sub.nii.gz
# 
# 		fslmaths $FINAL_MASKS/ASHS_${n}_lfseg_heur.nii.gz -thr 9 -uthr 9 -bin $FINAL_MASKS/ASHS_${n}_ERC.nii.gz
# 
# 		fslmaths $FINAL_MASKS/ASHS_${n}_lfseg_heur.nii.gz -thr 10 -uthr 10 -bin $FINAL_MASKS/ASHS_${n}_PHG.nii.gz
# 
# 	done

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		MASKDIR=$FSLDATADIR/masks/$RUN 
		REGDIR=$FSLDATADIR/reg
		REGRUNDIR=$REGDIR/$RUN
		REFERENCE=$REGRUNDIR/ef.nii.gz

		for n in "${sides[@]}"; do
			for i in "${areas[@]}"; do	
				/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $FINAL_MASKS/ASHS_${n}_${i}.nii.gz \
				$MASKDIR/ASHS_${n}_${i}_deformed.nii.gz -R $REFERENCE \
				$REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
				-i $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt -i $REGRUNDIR/ef_2_efTempAffine.txt \
				$REGRUNDIR/ef_2_efTempInverseWarp.nii.gz

				/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/ASHS_${n}_${i}_deformed.nii.gz \
				$MASKDIR/ASHS_${n}_${i}_deformed_slice.nii.gz -R $REFERENCE --tightest-bounding-box --reslice-by-header
		
				fslmaths $MASKDIR/ASHS_${n}_${i}_deformed_slice.nii.gz -thr .15 -bin $MASKDIR/ASHS_${n}_${i}.nii.gz
		
			done
		done 

		cd $MASKDIR

		fslmaths ASHS_left_CA1_deformed_slice.nii.gz -sub ASHS_left_CA3DG_deformed_slice.nii.gz ASHS_left_1_g_2

		fslmaths ASHS_left_1_g_2.nii.gz -thr 0 -bin ASHS_left_over_for_1

		fslmaths ASHS_left_1_g_2.nii.gz -uthr 0 -mul -1 -bin ASHS_left_over_for_3

		fslmaths ASHS_left_CA1.nii.gz -mul ASHS_left_over_for_1.nii.gz ASHS_left_CA1_fixed

		fslmaths ASHS_left_CA3DG.nii.gz -mul ASHS_left_over_for_3.nii.gz ASHS_left_CA3DG_fixed



		fslmaths ASHS_right_CA1_deformed_slice.nii.gz -sub ASHS_right_CA3DG_deformed_slice.nii.gz ASHS_right_1_g_2

		fslmaths ASHS_right_1_g_2.nii.gz -thr 0 -bin ASHS_right_over_for_1

		fslmaths ASHS_right_1_g_2.nii.gz -uthr 0 -mul -1 -bin ASHS_right_over_for_3

		fslmaths ASHS_right_CA1.nii.gz -mul ASHS_right_over_for_1.nii.gz ASHS_right_CA1_fixed

		fslmaths ASHS_right_CA3DG.nii.gz -mul ASHS_right_over_for_3.nii.gz ASHS_right_CA3DG_fixed
	
	
		fslmaths ASHS_right_Sub.nii.gz -sub ASHS_right_CA1_fixed.nii.gz -sub ASHS_right_CA3DG_fixed.nii.gz -bin ASHS_right_Sub_fixed
	
		fslmaths ASHS_left_Sub.nii.gz -sub ASHS_left_CA1_fixed.nii.gz -sub ASHS_left_CA3DG_fixed.nii.gz -bin ASHS_left_Sub_fixed

	done
done



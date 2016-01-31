#!/bin/sh

SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26  )

#

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}
MASKDIR=$FSLDATADIR/masks

REGDIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/ANTS_REG/${sub}
REFERENCE=$REGDIR/mprage.nii.gz
OUTDIR=$REGDIR/ROIs

#mkdir $OUTDIR

sides=( Right Left )
sides_alt=( right left )
#right left
areas=( NAcc )
#CA1 CA23DG Sub

# 
# 

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
  		printf -v OUT_NAME "%s_%s_deform.nii.gz" $n $i  
 		echo $OUT_NAME
		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/${i}${n}.nii.gz $OUTDIR/$OUT_NAME -R \
		$REFERENCE $REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
		
 		printf -v OUT_NAME_alt "%s_%s_deform_slice.nii.gz" $n $i  
 		echo $OUT_NAME_alt
		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${OUT_NAME} \
		${OUTDIR}/$OUT_NAME_alt -R $REFERENCE --tightest-bounding-box --reslice-by-header

	done
done 

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
 		printf -v IN_NAME "%s_%s_deform_slice.nii.gz" $n $i 
 		printf -v OUT_NAME "%s_%s.nii.gz" $n $i 
		fslmaths ${OUTDIR}/${IN_NAME} -thr .15 -bin ${OUTDIR}/${OUT_NAME}

	done
done

for n in 0 1
do
	for i in "${areas[@]}"
	do
 		printf -v OUT_NAME "%s_%s.nii.gz" ${sides[n]} $i 
 		printf -v OUT_NAME_ALT "%s_%s.nii.gz" ${sides_alt[n]} $i 
		mv ${OUTDIR}/${OUT_NAME} ${OUTDIR}/${OUT_NAME_ALT}
	done
done


# cd $OUTDIR
# 
# fslmaths left_CA1_deform_slice.nii.gz -sub left_CA23DG_deform_slice.nii.gz L_1_g_2_fixing
# fslmaths L_1_g_2_fixing.nii.gz -thr 0 -bin L_over_for_1_fixing
# fslmaths L_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin L_over_for_3_fixing
# fslmaths left_CA1.nii.gz -mul L_over_for_1_fixing.nii.gz left_CA1_fixed
# fslmaths left_CA23DG.nii.gz -mul L_over_for_3_fixing.nii.gz left_CA23DG_fixed
# 
# 
# fslmaths right_CA1_deform_slice.nii.gz -sub right_CA23DG_deform_slice.nii.gz R_1_g_2_fixing
# fslmaths R_1_g_2_fixing.nii.gz -thr 0 -bin R_over_for_1_fixing
# fslmaths R_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin R_over_for_3_fixing
# fslmaths right_CA1.nii.gz -mul R_over_for_1_fixing.nii.gz right_CA1_fixed
# fslmaths right_CA23DG.nii.gz -mul R_over_for_3_fixing.nii.gz right_CA23DG_fixed
# 
# fslmaths right_Sub.nii.gz -sub right_CA1_fixed.nii.gz -sub right_CA23DG_fixed.nii.gz -bin right_Sub_fixed
# fslmaths left_Sub.nii.gz -sub left_CA1_fixed.nii.gz -sub left_CA23DG_fixed.nii.gz -bin left_Sub_fixed 
# 
# rm *_fixing.nii.gz

done

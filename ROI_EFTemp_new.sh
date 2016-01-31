#!/bin/sh

SUBS=( MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 )

# 
# MM_522 MM_523 MM_524
#
# 

for sub in "${SUBS[@]}"; do


FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
MASKDIR=$FSLDATADIR/masks


cd $MASKDIR
# mkdir sub_space
# 
# OUTDIR=$MASKDIR/sub_space
# REGDIR=$FSLDATADIR/reg
# REFERENCE=$REGDIR/ef_temp/BOLD_template.nii.gz
# 
# sides=( R L )
# areas=( CA1 CA3DG Sub )
# #
# 
# # 
# # 
# 
# for n in "${sides[@]}"
# do
# 	for i in "${areas[@]}"
# 	do
#  		printf -v IN_TC "%s_%s_TC.nii.gz" $i $n
#  		#CB
#  		echo $IN_TC
#   		printf -v OUT_NAME "%s_%s_deform.nii.gz" $n $i  
#  		echo $OUT_NAME
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/$IN_TC $OUTDIR/$OUT_NAME -R \
# 		$REFERENCE $REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
# 		-i $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt 
# 		
#  		printf -v OUT_NAME_alt "%s_%s_deform_slice.nii.gz" $n $i  
#  		echo $OUT_NAME_alt
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${OUT_NAME} \
# 		${OUTDIR}/$OUT_NAME_alt -R $REFERENCE --tightest-bounding-box --reslice-by-header
# 
# 	done
# done 
# 
# for n in "${sides[@]}"
# do
# 	for i in "${areas[@]}"
# 	do
#  		printf -v IN_NAME "%s_%s_deform_slice.nii.gz" $n $i 
#  		printf -v OUT_NAME "%s_%s.nii.gz" $n $i 
# 		fslmaths ${OUTDIR}/${IN_NAME} -thr .15 -bin ${OUTDIR}/${OUT_NAME}
# 
# 	done
# done 

cd sub_space

# fslmaths L_CA1_deform_slice.nii.gz -sub L_CA3DG_deform_slice.nii.gz L_1_g_2_fixing
# fslmaths L_1_g_2_fixing.nii.gz -thr 0 -bin L_over_for_1_fixing
# fslmaths L_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin L_over_for_3_fixing
# fslmaths L_CA1.nii.gz -mul L_over_for_1_fixing.nii.gz L_CA1_fixed
# fslmaths L_CA3DG.nii.gz -mul L_over_for_3_fixing.nii.gz L_CA3DG_fixed
# 
# 
# fslmaths R_CA1_deform_slice.nii.gz -sub R_CA3DG_deform_slice.nii.gz R_1_g_2_fixing
# fslmaths R_1_g_2_fixing.nii.gz -thr 0 -bin R_over_for_1_fixing
# fslmaths R_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin R_over_for_3_fixing
# fslmaths R_CA1.nii.gz -mul R_over_for_1_fixing.nii.gz R_CA1_fixed
# fslmaths R_CA3DG.nii.gz -mul R_over_for_3_fixing.nii.gz R_CA3DG_fixed
# 
# fslmaths R_Sub.nii.gz -sub R_CA1_fixed.nii.gz -sub R_CA3DG_fixed.nii.gz -bin R_Sub_fixed
# fslmaths L_Sub.nii.gz -sub L_CA1_fixed.nii.gz -sub L_CA3DG_fixed.nii.gz -bin L_Sub_fixed 
# 
# rm *_fixing.nii.gz
# rm *deform*.nii.gz

fslmaths R_CA1_fixed.nii.gz -add L_CA1_fixed.nii.gz -bin CA1_fixed
fslmaths R_CA3DG_fixed.nii.gz -add L_CA3DG_fixed.nii.gz -bin CA3DG_fixed
fslmaths R_Sub_fixed.nii.gz -add L_Sub_fixed.nii.gz -bin Sub_fixed

done



##Different because of different creators, eventually all should be CB

SUBS=( MM_523 MM_524 )
#MM_522 

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
MASKDIR=$FSLDATADIR/masks


cd $MASKDIR
# mkdir sub_space
# 
# OUTDIR=$MASKDIR/sub_space
# REGDIR=$FSLDATADIR/reg
# REFERENCE=$REGDIR/ef_temp/BOLD_template.nii.gz
# 
# sides=( R L )
# areas=( CA1 CA3DG Sub )
# #
# 
# # 
# # 
# 
# for n in "${sides[@]}"
# do
# 	for i in "${areas[@]}"
# 	do
#  		printf -v IN_TC "%s_%s_CB.nii.gz" $i $n
#  		#TC
#  		echo $IN_TC
#   		printf -v OUT_NAME "%s_%s_deform.nii.gz" $n $i  
#  		echo $OUT_NAME
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/$IN_TC $OUTDIR/$OUT_NAME -R \
# 		$REFERENCE $REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
# 		-i $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt 
# 		
#  		printf -v OUT_NAME_alt "%s_%s_deform_slice.nii.gz" $n $i  
#  		echo $OUT_NAME_alt
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${OUT_NAME} \
# 		${OUTDIR}/$OUT_NAME_alt -R $REFERENCE --tightest-bounding-box --reslice-by-header
# 
# 	done
# done 
# 
# for n in "${sides[@]}"
# do
# 	for i in "${areas[@]}"
# 	do
#  		printf -v IN_NAME "%s_%s_deform_slice.nii.gz" $n $i 
#  		printf -v OUT_NAME "%s_%s.nii.gz" $n $i 
# 		fslmaths ${OUTDIR}/${IN_NAME} -thr .15 -bin ${OUTDIR}/${OUT_NAME}
# 
# 	done
# done 

cd sub_space

# fslmaths L_CA1_deform_slice.nii.gz -sub L_CA3DG_deform_slice.nii.gz L_1_g_2_fixing
# fslmaths L_1_g_2_fixing.nii.gz -thr 0 -bin L_over_for_1_fixing
# fslmaths L_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin L_over_for_3_fixing
# fslmaths L_CA1.nii.gz -mul L_over_for_1_fixing.nii.gz L_CA1_fixed
# fslmaths L_CA3DG.nii.gz -mul L_over_for_3_fixing.nii.gz L_CA3DG_fixed
# 
# 
# fslmaths R_CA1_deform_slice.nii.gz -sub R_CA3DG_deform_slice.nii.gz R_1_g_2_fixing
# fslmaths R_1_g_2_fixing.nii.gz -thr 0 -bin R_over_for_1_fixing
# fslmaths R_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin R_over_for_3_fixing
# fslmaths R_CA1.nii.gz -mul R_over_for_1_fixing.nii.gz R_CA1_fixed
# fslmaths R_CA3DG.nii.gz -mul R_over_for_3_fixing.nii.gz R_CA3DG_fixed
# 
# fslmaths R_Sub.nii.gz -sub R_CA1_fixed.nii.gz -sub R_CA3DG_fixed.nii.gz -bin R_Sub_fixed
# fslmaths L_Sub.nii.gz -sub L_CA1_fixed.nii.gz -sub L_CA3DG_fixed.nii.gz -bin L_Sub_fixed 
# 
# rm *_fixing.nii.gz
# rm *deform*.nii.gz

fslmaths R_CA1_fixed.nii.gz -add L_CA1_fixed.nii.gz -bin CA1_fixed
fslmaths R_CA3DG_fixed.nii.gz -add L_CA3DG_fixed.nii.gz -bin CA3DG_fixed
fslmaths R_Sub_fixed.nii.gz -add L_Sub_fixed.nii.gz -bin Sub_fixed

done


##Different because of different creators, eventually all should be CB

SUBS=( MM_525 MM_526 MM_527 MM_528 MM_529 MM_530 )
#MM_525 MM_526 MM_527 MM_528

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
MASKDIR=$FSLDATADIR/masks


cd $MASKDIR
# mkdir sub_space
# 
# OUTDIR=$MASKDIR/sub_space
# REGDIR=$FSLDATADIR/reg
# REFERENCE=$REGDIR/ef_temp/BOLD_template.nii.gz
# 
# sides=( R L )
# areas=( CA1 CA3DG Sub )
# #
# 
# # 
# # 
# 
# for n in "${sides[@]}"
# do
# 	for i in "${areas[@]}"
# 	do
#  		printf -v IN_TC "%s_%s_ND.nii.gz" $i $n
#  		#TC
#  		echo $IN_TC
#   		printf -v OUT_NAME "%s_%s_deform.nii.gz" $n $i  
#  		echo $OUT_NAME
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/$IN_TC $OUTDIR/$OUT_NAME -R \
# 		$REFERENCE $REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
# 		-i $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt
# 		
#  		printf -v OUT_NAME_alt "%s_%s_deform_slice.nii.gz" $n $i  
#  		echo $OUT_NAME_alt
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${OUT_NAME} \
# 		${OUTDIR}/$OUT_NAME_alt -R $REFERENCE --tightest-bounding-box --reslice-by-header
# 
# 	done
# done 
# 
# for n in "${sides[@]}"
# do
# 	for i in "${areas[@]}"
# 	do
#  		printf -v IN_NAME "%s_%s_deform_slice.nii.gz" $n $i 
#  		printf -v OUT_NAME "%s_%s.nii.gz" $n $i 
# 		fslmaths ${OUTDIR}/${IN_NAME} -thr .15 -bin ${OUTDIR}/${OUT_NAME}
# 
# 	done
# done 

cd sub_space

# fslmaths L_CA1_deform_slice.nii.gz -sub L_CA3DG_deform_slice.nii.gz L_1_g_2_fixing
# fslmaths L_1_g_2_fixing.nii.gz -thr 0 -bin L_over_for_1_fixing
# fslmaths L_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin L_over_for_3_fixing
# fslmaths L_CA1.nii.gz -mul L_over_for_1_fixing.nii.gz L_CA1_fixed
# fslmaths L_CA3DG.nii.gz -mul L_over_for_3_fixing.nii.gz L_CA3DG_fixed
# 
# 
# fslmaths R_CA1_deform_slice.nii.gz -sub R_CA3DG_deform_slice.nii.gz R_1_g_2_fixing
# fslmaths R_1_g_2_fixing.nii.gz -thr 0 -bin R_over_for_1_fixing
# fslmaths R_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin R_over_for_3_fixing
# fslmaths R_CA1.nii.gz -mul R_over_for_1_fixing.nii.gz R_CA1_fixed
# fslmaths R_CA3DG.nii.gz -mul R_over_for_3_fixing.nii.gz R_CA3DG_fixed
# 
# fslmaths R_Sub.nii.gz -sub R_CA1_fixed.nii.gz -sub R_CA3DG_fixed.nii.gz -bin R_Sub_fixed
# fslmaths L_Sub.nii.gz -sub L_CA1_fixed.nii.gz -sub L_CA3DG_fixed.nii.gz -bin L_Sub_fixed 
# 
# rm *_fixing.nii.gz
# rm *deform*.nii.gz

fslmaths R_CA1_fixed.nii.gz -add L_CA1_fixed.nii.gz -bin CA1_fixed
fslmaths R_CA3DG_fixed.nii.gz -add L_CA3DG_fixed.nii.gz -bin CA3DG_fixed
fslmaths R_Sub_fixed.nii.gz -add L_Sub_fixed.nii.gz -bin Sub_fixed

done

# /space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${IN_TC} ${OUTDIR}/${OUT_NAME} -R ${REFERNCE} \
#		${FSLDATADIR}/reg/hiRes2mprage_wSkullWarp.nii.gz ${FSLDATADIR}/reg/hiRes2mprage_wSkullAffine.txt
#!/bin/sh

sides=( R L )
areas=( CA1 CA3DG Sub )

SUBS=( MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 )

# 
# MM_522 MM_523 MM_524
# 
#   

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
MASKDIR=$FSLDATADIR/masks

REGDIR=$FSLDATADIR/reg
REGDIREF=$REGDIR/ef_temp
REFERENCE=$REGDIREF/BOLD_template.nii.gz
 

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
 		printf -v IN_TC "%s_%s_TC.nii.gz" $i $n
 		#CB
 		echo $IN_TC
  		printf -v OUT_NAME "%s_%s_deform_efTemp_test.nii.gz" $n $i  
 		echo $OUT_NAME
		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/$IN_TC $MASKDIR/$OUT_NAME -R \
		$REFERENCE $REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
		-i $REGDIREF/efTemp_2_mprageRAAffine.txt 
		#$REGDIREF/efTemp_2_mprageInverseWarp.nii.gz

 		printf -v OUT_NAME_alt "%s_%s_deform_slice_efTemp_test.nii.gz" $n $i  
 		echo $OUT_NAME_alt
		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/${OUT_NAME} \
		$MASKDIR/$OUT_NAME_alt -R $REFERENCE --tightest-bounding-box --reslice-by-header

	done
done 

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
 		printf -v IN_NAME "%s_%s_deform_slice_efTemp_test.nii.gz" $n $i 
 		printf -v OUT_NAME "%s_%s_efTemp_test.nii.gz" $n $i 
		fslmaths $MASKDIR/${IN_NAME} -thr .15 -bin $MASKDIR/${OUT_NAME}

	done
done 

done

#Different because have different creator, eventually will all be CB
SUBS=( MM_522 MM_523 MM_524 )

# MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521
# 
# 
#   

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
MASKDIR=$FSLDATADIR/masks

REGDIR=$FSLDATADIR/reg
REGDIREF=$REGDIR/ef_temp
REFERENCE=$REGDIREF/BOLD_template.nii.gz
 

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
 		printf -v IN_TC "%s_%s_CB.nii.gz" $i $n
 		#TC
 		echo $IN_TC
  		printf -v OUT_NAME "%s_%s_deform_efTemp_test.nii.gz" $n $i  
 		echo $OUT_NAME
		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/$IN_TC $MASKDIR/$OUT_NAME -R \
		$REFERENCE $REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
		-i $REGDIREF/efTemp_2_mprageRAAffine.txt 
		#$REGDIREF/efTemp_2_mprageInverseWarp.nii.gz

 		printf -v OUT_NAME_alt "%s_%s_deform_slice_efTemp_test.nii.gz" $n $i  
 		echo $OUT_NAME_alt
		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/${OUT_NAME} \
		$MASKDIR/$OUT_NAME_alt -R $REFERENCE --tightest-bounding-box --reslice-by-header

	done
done 

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
 		printf -v IN_NAME "%s_%s_deform_slice_efTemp_test.nii.gz" $n $i 
 		printf -v OUT_NAME "%s_%s_efTemp_test.nii.gz" $n $i 
		fslmaths $MASKDIR/${IN_NAME} -thr .15 -bin $MASKDIR/${OUT_NAME}

	done
done 

done

# /space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${IN_TC} ${OUTDIR}/${OUT_NAME} -R ${REFERNCE} \
#		${FSLDATADIR}/reg/hiRes2mprage_wSkullWarp.nii.gz ${FSLDATADIR}/reg/hiRes2mprage_wSkullAffine.txt


SUBS=( MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524 )

#  MM_503 MM_505 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519  MM_521
#MM_520
#  MM_507 

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
MASKDIR=$FSLDATADIR/masks/

		cd $MASKDIR

		fslmaths L_CA1_deform_slice_efTemp_test.nii.gz -sub L_CA3DG_deform_slice_efTemp_test.nii.gz L_1_g_2_efTemp_test

		fslmaths L_1_g_2_efTemp_test.nii.gz -thr 0 -bin L_over_for_1_efTemp_test

		fslmaths L_1_g_2_efTemp_test.nii.gz -uthr 0 -mul -1 -bin L_over_for_3_efTemp_test

		fslmaths L_CA1_efTemp_test.nii.gz -mul L_over_for_1_efTemp_test.nii.gz L_CA1_fixed_efTemp_test

		fslmaths L_CA3DG_efTemp_test.nii.gz -mul L_over_for_3_efTemp_test.nii.gz L_CA3DG_fixed_efTemp_test



		fslmaths R_CA1_deform_slice_efTemp_test.nii.gz -sub R_CA3DG_deform_slice_efTemp_test.nii.gz R_1_g_2_efTemp_test

		fslmaths R_1_g_2_efTemp_test.nii.gz -thr 0 -bin R_over_for_1_efTemp_test

		fslmaths R_1_g_2_efTemp_test.nii.gz -uthr 0 -mul -1 -bin R_over_for_3_efTemp_test

		fslmaths R_CA1_efTemp_test.nii.gz -mul R_over_for_1_efTemp_test.nii.gz R_CA1_fixed_efTemp_test

		fslmaths R_CA3DG_efTemp_test.nii.gz -mul R_over_for_3_efTemp_test.nii.gz R_CA3DG_fixed_efTemp_test
		
		
 		fslmaths R_Sub_efTemp_test.nii.gz -sub R_CA1_fixed_efTemp_test.nii.gz -sub R_CA3DG_fixed_efTemp_test.nii.gz -bin R_Sub_fixed_efTemp_test
		
		fslmaths L_Sub_efTemp_test.nii.gz -sub L_CA1_fixed_efTemp_test.nii.gz -sub L_CA3DG_fixed_efTemp_test.nii.gz -bin L_Sub_fixed_efTemp_test

	done

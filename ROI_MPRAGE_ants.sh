#!/bin/sh

# SUBS=( MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 )
# 
# # 
# # MM_522 MM_523 MM_524
# #
# # 
# 
# for sub in "${SUBS[@]}"; do
# 
# FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
# MASKDIR=$FSLDATADIR/masks
# 
# OUTDIR=$MASKDIR
# REGDIR=$FSLDATADIR/reg
# REFERENCE=$FSLDATADIR/reg/mprage.nii.gz
# 
# sides=( R L )
# areas=( CA1 CA3DG Sub )
# 
# 
# for n in "${sides[@]}"
# do
# 	for i in "${areas[@]}"
# 	do
#  		printf -v IN_TC "%s_%s_TC.nii.gz" $i $n
#  		echo $IN_TC
#   		printf -v OUT_NAME "%s_%s_deform.nii.gz" $n $i  
#  		echo $OUT_NAME
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/$IN_TC $OUTDIR/$OUT_NAME -R \
# 		$REFERENCE $REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
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


##Different because of different creators, eventually all should be CB

SUBS=( MM_522 MM_523 MM_524 )

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
MASKDIR=$FSLDATADIR/masks

OUTDIR=$MASKDIR
REGDIR=$FSLDATADIR/reg
REFERENCE=$FSLDATADIR/reg/mprage.nii.gz

sides=( R L )
areas=( CA1 CA3DG Sub )
#

# 
# 

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
 		printf -v IN_TC "%s_%s_CB.nii.gz" $i $n
 		echo $IN_TC
  		printf -v OUT_NAME "%s_%s_deform.nii.gz" $n $i  
 		echo $OUT_NAME
		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/$IN_TC $OUTDIR/$OUT_NAME -R \
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
done


#!/bin/sh
FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1

OUTDIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks
REFERNCE=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/raw/mprage/mprage_brain.nii.gz
TRANSFORM_A=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/reg/hiRes2mprage_wSkullWarp.nii.gz
TRANSFORM_B=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/reg/hiRes2mprage_wSkullAffine.txt

sides=( R L )
areas=( CA1 CA3DG Sub )

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
 		printf -v IN_TC "%s_%s_TC.nii.gz" $i $n
 		echo $IN_TC
 		printf -v OUT_NAME "%s_%s_deform.nii.gz" $n $i  
 		echo $OUT_NAME
 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${IN_TC} ${OUTDIR}/${OUT_NAME} -R ${REFERNCE} \
		${FSLDATADIR}/reg/hiRes2mprage_wSkullWarp.nii.gz ${FSLDATADIR}/reg/hiRes2mprage_wSkullAffine.txt
		

	done
done 

for n in "${sides[@]}"
do
	for i in "${areas[@]}"
	do
 		printf -v IN_NAME "%s_%s_deform.nii.gz" $n $i 
 		printf -v OUT_NAME "%s_%s.nii.gz" $n $i 
		fslmaths ${OUTDIR}/${IN_NAME} -thr .15 -bin ${OUTDIR}/${OUT_NAME}

	done
done 

# $ANTSPATH/WarpImageMultiTransform 3 high_res.nii.gz HR_2_EF.nii.gz -R \
# run1/ef.nii.gz hiRes2mprage_wSkullWarp.nii.gz hiRes2mprage_wSkullAffine.txt \
# mprage2mbwWarp.nii.gz mprage2mbwAffine.txt -i run1/ef2mbwAffine.txt
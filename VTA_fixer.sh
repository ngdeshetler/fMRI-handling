#!/bin/sh

	BASEREGDIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/ANTS_REG
	STANDARD=$BASEREGDIR/high_res_temp/HighResCombined2_template.nii.gz 

SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 )
#  

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}
	MASKDIR=$FSLDATADIR/masks
	
	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${MASKDIR}/VTA_alt.nii.gz \
	${BASEREGDIR}/VTA_fix/VTA_${sub}.nii.gz -R $STANDARD \
	$BASEREGDIR/high_res_temp/HighResCombined2_highRes_${sub}Warp.nii.gz \
	$BASEREGDIR/high_res_temp/HighResCombined2_highRes_${sub}Affine.txt
	
done

SUBS=( 10 11 12 13 14 16 17 18 19 20 21 22 23 24 25 26 )
#  
fslmaths ${BASEREGDIR}/VTA_fix/VTA_9.nii.gz ${BASEREGDIR}/VTA_fix/VTA_overlap.nii.gz

for sub in "${SUBS[@]}"; do
	
	fslmaths ${BASEREGDIR}/VTA_fix/VTA_overlap.nii.gz -add ${BASEREGDIR}/VTA_fix/VTA_${sub}.nii.gz \
	${BASEREGDIR}/VTA_fix/VTA_overlap.nii.gz
		
done

	SFORM="$(fslorient -getsform $STANDARD)"
	QFORM="$(fslorient -getqform $STANDARD)"

	fslorient -setsform ${SFORM} ${BASEREGDIR}/VTA_fix/VTA_overlap.nii.gz
	fslorient -setqform ${QFORM} ${BASEREGDIR}/VTA_fix/VTA_overlap.nii.gz
#!/bin/sh


SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 )
#
#
#  

FSLBDATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data

for sub in "${SUBS[@]}"; do

	FSLDATADIR=${FSLBDATADIR}/${sub}
	MASKDIR=${FSLDATADIR}/masks

	REGDIR=${FSLBDATADIR}/ANTS_REG/${sub}

	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $FSLBDATADIR/ProbAtlas/mean_VTA.nii.gz \
	$MASKDIR/VTA_est_HHR.nii.gz -R $REGDIR/high_res.nii.gz -i $FSLBDATADIR/ANTS_REG/HRtemp2MNIAffine.txt \
	$FSLBDATADIR/ANTS_REG/HRtemp2MNIInverseWarp.nii.gz \
	-i $FSLBDATADIR/ANTS_REG/high_res_temp/HighResCombined_highRes_${sub}Affine.txt \
	$FSLBDATADIR/ANTS_REG/high_res_temp/HighResCombined_highRes_${sub}InverseWarp.nii.gz
	
done
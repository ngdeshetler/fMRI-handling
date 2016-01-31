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
	
	for run in {1..3}; do

 		OUTDIR=$REGDIR/ROIs/run${run}

		#mkdir -p $OUTDIR
		REFERENCE=$REGDIR/run${run}/ef_LR.nii.gz
		RUNREGDIR=${REGDIR}/run${run}

	# /space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $FSLBDATADIR/ProbAtlas/mean_VTA.nii.gz \
# 	$OUTDIR/VTA_est.nii.gz -R $REFERENCE -i $FSLBDATADIR/ANTS_REG/HRtemp2MNIAffine.txt \
# 	$FSLBDATADIR/ANTS_REG/HRtemp2MNIInverseWarp.nii.gz \
# 	-i $FSLBDATADIR/ANTS_REG/high_res_temp/HighResCombined_highRes_${sub}Affine.txt \
# 	$FSLBDATADIR/ANTS_REG/high_res_temp/HighResCombined_highRes_${sub}InverseWarp.nii.gz \
# 	$REGDIR/ef_temp/efTemp_2_HRRAAffine.txt ${RUNREGDIR}/ef_2_efTempRAAffine.txt
	
	fslmaths $OUTDIR/VTA_est.nii.gz -thr .9 -bin $OUTDIR/VTA_10.nii.gz
	fslmaths $OUTDIR/VTA_est.nii.gz -thr .75 -bin $OUTDIR/VTA_25.nii.gz
	fslmaths $OUTDIR/VTA_est.nii.gz -thr .5 -bin $OUTDIR/VTA_50.nii.gz
	fslmaths $OUTDIR/VTA_est.nii.gz -thr .25 -bin $OUTDIR/VTA_75.nii.gz
	fslmaths $OUTDIR/VTA_est.nii.gz -thr .1 -bin $OUTDIR/VTA_90.nii.gz
	fslmaths $OUTDIR/VTA_est.nii.gz -bin $OUTDIR/VTA_100.nii.gz
	
	done
done
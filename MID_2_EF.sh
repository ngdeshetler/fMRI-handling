#!/bin/sh

SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 25 26 )
#
#
#  

BASEREGDIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/ANTS_REG
INPUT=/space/raid6/data/knowlton/PS_Reward_Study/Data/univariate/MID_9subs.gfeat/cope6.feat/stats/zstat1.nii.gz

for sub in "${SUBS[@]}"; do

	DATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}
	REGDIR=$BASEREGDIR/${sub}
 
	for run in {1..3}; do

		OUTDIR=$REGDIR/ROIs/run${run}
		REFERENCE=$REGDIR/run${run}/ef_LR.nii.gz

		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $INPUT $OUTDIR/$MID_all_zstat_alt.nii.gz -R \
		$REFERENCE -i $BASEREGDIR/high_res_temp/HighResCombined2_highRes_${sub}Affine.txt \
		$BASEREGDIR/high_res_temp/HighResCombined2_highRes_${sub}InverseWarp.nii.gz \
		-i $REGDIR/ef_temp/efTemp_2_HRRAAffine.txt  \
		-i $REGDIR/run${run}/ef_2_efTempAffine.txt $REGDIR/run${run}/ef_2_efTempInverseWarp.nii.gz 
		#

	done
done
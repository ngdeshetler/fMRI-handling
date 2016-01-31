#!/bin/bash

COPE_INDEX=( 4 5 6 10 11 12 )
NAMES=( loc_v_rest ani_v_rest ob_v_rest loc_v_ani_ob ani_v_loc_ob ob_v_loc_ani )
OTHER_NAMES=( location_t_map animal_t_map object_t_map location_v_others_t_map animal_v_others_t_map object_v_others_t_map ) 


SUBS=( MM_502 MM_503 MM_505 MM_508 MM_507 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 )

#
# 
#
# 

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
	MASKDIR=$FSLDATADIR/masks/NS
	#mkdir $MASKDIR
	REGDIR=$FSLDATADIR/reg
	TRANSFORM=$FSLDATADIR/analysis/STAT/localizer_output_noSmooth.feat/reg/example_func2highres.mat
	REFERENCE=$FSLDATADIR/raw/mprage/mprage_brain.nii.gz

	for index in 0 1 2 3 4 5; do

		printf -v FILE "tstat%d.nii.gz" ${COPE_INDEX[index]}
		printf -v OUT_FILE "%s.nii.gz" ${NAMES[index]}

		TSTAT=$FSLDATADIR/analysis/STAT/localizer_output_noSmooth.feat/stats/$FILE
		TOUT=$MASKDIR/$OUT_FILE

		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in $TSTAT -applyxfm -init \
		$TRANSFORM -out $TOUT -paddingsize 0.0 -interp nearestneighbour -ref $REFERENCE

		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/fslcreatehd 120 128 128 1 2 2 2 1 0 0 0 16  \
		$MASKDIR/${OTHER_NAMES[index]}_tmp.nii.gz ; \
		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in $TOUT \
		 -applyxfm -init /space/raid/fmri/fsl-5.0.2.1-centos6_64/etc/flirtsch/ident.mat \
		 -out $MASKDIR/${OTHER_NAMES[index]} \
		 -paddingsize 0.0 -interp nearestneighbour -ref $MASKDIR/${OTHER_NAMES[index]}_tmp
		 
		 rm $MASKDIR/${OTHER_NAMES[index]}.nii

		gunzip $MASKDIR/${OTHER_NAMES[index]}.nii.gz

	done
done

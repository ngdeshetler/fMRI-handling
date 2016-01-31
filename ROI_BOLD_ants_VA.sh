SUBS=( 502 503 505 508 507 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 )

# 
#
#
# 

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/MM_$sub
	MASKDIR=$FSLDATADIR/masks
	REGDIR=$FSLDATADIR/reg

	for run in {1..8}; do

		printf -v RUN "run%d" $run


		cd $MASKDIR
		#mkdir $RUN

		OUTDIR=$MASKDIR/$RUN
		REGRUNDIR=$REGDIR/$RUN
		REFERENCE=$REGRUNDIR/ef.nii.gz

		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/masks/MM_Visual_Association_mask.nii.gz \
		$OUTDIR/VA_mask_warp.nii.gz -R $REFERENCE -i /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/tempROI_2_mni_Affine.txt\
		-i /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${sub}/mprage__2_ROIs_Affine.txt \
		/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${sub}/mprage__2_ROIs_InverseWarp.nii.gz \
		-i $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt -i $REGRUNDIR/ef_2_efTempAffine.txt $REGRUNDIR/ef_2_efTempInverseWarp.nii.gz

		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/VA_mask_warp.nii.gz \
		${OUTDIR}/VA_mask.nii.gz -R $REFERENCE --tightest-bounding-box --reslice-by-header

		fslmaths ${OUTDIR}/VA_mask.nii.gz -thr .15 -bin ${OUTDIR}/VA_mask_bin

	done

done

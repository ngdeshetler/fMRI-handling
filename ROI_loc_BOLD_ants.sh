#!/bin/sh

SUBS=( MM_502 MM_503 MM_505 MM_508 MM_507 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524 )

#
#  
# 
#  

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
	MASKDIR=$FSLDATADIR/masks
	REGDIR=$FSLDATADIR/reg
	FSTAT=$FSLDATADIR/analysis/STAT/localizer_output_smooth.feat/stats/zfstat1.nii.gz

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		OUTDIR=$MASKDIR/$RUN
		REGRUNDIR=$REGDIR/$RUN
		REFERNCE=$REGRUNDIR/ef.nii.gz

		## to remove OLD
		rm $OUTDIR/zfstat1.nii.gz
		##

		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $FSTAT $OUTDIR/zfstat1.nii.gz \
		-R $REFERNCE $REGDIR/loc/ef_2_efTempRAAffine.txt \
		-i $REGRUNDIR/ef_2_efTempAffine.txt $REGDIR/loc/ef_2_efTempInverseWarp.nii.gz

		## create p map from z map
		fslmaths $OUTDIR/zfstat1.nii.gz -ztop $OUTDIR/pfstat1.nii.gz

		## create mask of all voxels < .05
		fslmaths $OUTDIR/pfstat1.nii.gz -uthr .05 -bin $OUTDIR/pfstat1_05.nii.gz

		## create mask of all voxels < .1
		fslmaths $OUTDIR/pfstat1.nii.gz -uthr .1 -bin $OUTDIR/pfstat1_10.nii.gz


		sides=( L R )
		areas=( CA1 CA3DG Sub )

		# 
		# 

		for n in "${sides[@]}"
		do
			for i in "${areas[@]}"
			do
			
			printf -v MASK_NAME "%s_%s_fixed_test.nii.gz" $n $i
			printf -v OUT_NAME "%s_%s_zfstat_test.nii.gz" $n $i
			printf -v OUT_NAME_25 "%s_%s_zfstat_25_alt_test.nii.gz" $n $i
			printf -v OUT_NAME_50 "%s_%s_zfstat_50_alt_test.nii.gz" $n $i
			
			fslmaths $OUTDIR/zfstat1.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
			THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
			THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)
			
						
			## create mask of top 25% of z scores
			fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25

			## create mask of top 50% of z scores
			fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50

			
			done
		done

		sides=( right left )
		areas=( CA1 CA3DG Sub )
		parts=( Head Tail ERC PHG )

		# 
		# 

		for n in "${sides[@]}"
		do
			for i in "${areas[@]}"
			do
			
			printf -v MASK_NAME "ASHS_%s_%s_fixed.nii.gz" $n $i
			printf -v OUT_NAME "%s_%s_zfstat_test.nii.gz" $n $i
			printf -v OUT_NAME_25 "%s_%s_zfstat_25_alt_test.nii.gz" $n $i
			printf -v OUT_NAME_50 "%s_%s_zfstat_50_alt_test.nii.gz" $n $i
			
			fslmaths $OUTDIR/zfstat1.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
			THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
			THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)
			
						
			## create mask of top 25% of z scores
			fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25

			## create mask of top 50% of z scores
			fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50

			
			done
			
			for i in "${parts[@]}"
			do
			
			printf -v MASK_NAME "ASHS_%s_%s.nii.gz" $n $i
			printf -v OUT_NAME "%s_%s_zfstat_test.nii.gz" $n $i
			printf -v OUT_NAME_25 "%s_%s_zfstat_25_alt_test.nii.gz" $n $i
			printf -v OUT_NAME_50 "%s_%s_zfstat_50_alt_test.nii.gz" $n $i
			
			fslmaths $OUTDIR/zfstat1.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
			THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
			THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)
			
						
			## create mask of top 25% of z scores
			fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25

			## create mask of top 50% of z scores
			fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50

			
			done
		done

	done 
done

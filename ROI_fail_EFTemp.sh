#!/bin/sh

SUBS=( MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_523 MM_524 MM_525 MM_526 MM_527 MM_528 MM_529 MM_530 )

#MM_507 
#  
#MM_522 

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
	OUTDIR=$FSLDATADIR/masks/sub_space

	rm $OUTDIR/*.nii

	ZSTAT=$FSLDATADIR/analysis/fail_all_s++.gfeat/cope1.feat/stats/zstat1.nii.gz
	cp $ZSTAT $OUTDIR/zstat1_fail_sans.nii.gz
	
	sides=( L R )
	areas=( CA1 CA3DG Sub )

	for n in "${sides[@]}"
	do
		for i in "${areas[@]}"
		do
		
			printf -v MASK_NAME "%s_%s_fixed.nii.gz" $n $i
			#_test
			printf -v OUT_NAME "%s_%s_zstat_fail_sans.nii.gz" $n $i

			#printf -v OUT_NAME_20 "%s_%s_zstat_20_fail_sans.nii.gz" $n $i
			printf -v OUT_NAME_25 "%s_%s_zstat_25_fail_sans.nii.gz" $n $i
			#printf -v OUT_NAME_50 "%s_%s_zstat_50_fail_sans.nii.gz" $n $i
			
			fslmaths $OUTDIR/zstat1_fail_sans.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
			#THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
			THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)	
			#THR_80=(`fslstats $OUTDIR/$OUT_NAME -P 80`)		
			
			## create mask of top 250% of z scores
			#fslmaths $OUTDIR/$OUT_NAME -thr $THR_80 -bin $OUTDIR/$OUT_NAME_20
					
			## create mask of top 25% of z scores
			fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25

			## create mask of top 50% of z scores
			#fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
			
		done
	done
done
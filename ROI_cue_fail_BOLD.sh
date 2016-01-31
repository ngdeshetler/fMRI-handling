#!/bin/sh

SUBS=( 502 503 505 508 507 509 510 511 512 513 514 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 )

#SUBS=( MM_502 MM_503 MM_505 MM_508 MM_507 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524 MM_525 MM_526 MM_527 MM_528 MM_529 MM_530 )
# 
 
# )
#
# 

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/MM_${sub}
	MASKDIR=$FSLDATADIR/masks
	REGDIR=$FSLDATADIR/reg
# 	ZSTAT=$FSLDATADIR/analysis/cue_all_s.gfeat/cope1.feat/stats/zstat1.nii.gz
# 	
# 	for run in {1..8}; do
# 
# 		printf -v RUN "run%d" $run
# 
# 		OUTDIR=$MASKDIR/$RUN
# 		REGRUNDIR=$REGDIR/$RUN
# 		REFERNCE=$REGRUNDIR/ef.nii.gz
# 
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $ZSTAT $OUTDIR/zstat1_cue.nii.gz \
# 		-R $REFERNCE -i $REGRUNDIR/ef_2_efTempAffine.txt $REGRUNDIR/ef_2_efTempInverseWarp.nii.gz
# 
# 		## create p map from z map
# 		fslmaths $OUTDIR/zstat1_cue.nii.gz -ztop $OUTDIR/pstat1_cue.nii.gz
# 
# 		## create mask of all voxels < .05
# 		fslmaths $OUTDIR/pstat1_cue.nii.gz -uthr .05 -bin $OUTDIR/pzstat1_05_cue.nii.gz
# 
# 		## create mask of all voxels < .1
# 		fslmaths $OUTDIR/pstat1_cue.nii.gz -uthr .1 -bin $OUTDIR/pzstat1_10_cue.nii.gz
# 		
# 		sides=( L R )
# 		areas=( CA1 CA3DG Sub )
# 
# 		# 
# 		# 
# 
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 			
# 				printf -v MASK_NAME "%s_%s_fixed_test.nii.gz" $n $i
# 				printf -v OUT_NAME "%s_%s_zstat_test.nii.gz" $n $i
# 
# 				printf -v OUT_NAME_25 "%s_%s_zstat_25_cue_test.nii.gz" $n $i
# 				printf -v OUT_NAME_50 "%s_%s_zstat_50_cue_test.nii.gz" $n $i
# 			
# 				fslmaths $OUTDIR/zstat1_cue.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)		
# 
# 						
# 				## create mask of top 25% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25
# 
# 
# 				## create mask of top 50% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
# 
# 			done
# 		done
# 	
# 		sides=( right left )
# 		areas=( CA1 CA3DG Sub )
# 		parts=( Head Tail ERC PHG )
# 
# 		# 
# 		# 
# 
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 			
# 				printf -v MASK_NAME "ASHS_%s_%s_fixed.nii.gz" $n $i
# 				printf -v OUT_NAME "%s_%s_zstat_test.nii.gz" $n $i
# 
# 				printf -v OUT_NAME_25 "%s_%s_zstat_25_cue_test.nii.gz" $n $i
# 				printf -v OUT_NAME_50 "%s_%s_zstat_50_cue_test.nii.gz" $n $i
# 			
# 				fslmaths $OUTDIR/zstat1_cue.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)		
# 
# 						
# 				## create mask of top 25% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25
# 
# 
# 				## create mask of top 50% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
# 
# 			done
# 		done
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${parts[@]}"
# 			do
# 			
# 				printf -v MASK_NAME "ASHS_%s_%s.nii.gz" $n $i
# 				printf -v OUT_NAME "%s_%s_zstat_test.nii.gz" $n $i
# 
# 				printf -v OUT_NAME_25 "%s_%s_zstat_25_cue_test.nii.gz" $n $i
# 				printf -v OUT_NAME_50 "%s_%s_zstat_50_cue_test.nii.gz" $n $i
# 			
# 				fslmaths $OUTDIR/zstat1_cue.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)		
# 
# 						
# 				## create mask of top 25% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25
# 
# 
# 				## create mask of top 50% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
# 
# 			done
# 		done
# 	done
	 
	### Same process, but for fail trials
# 
# ZSTAT=$FSLDATADIR/analysis/fail_all_s++.gfeat/cope1.feat/stats/zstat1.nii.gz
# 
# 	for run in {1..8}; do
# 
# 		printf -v RUN "run%d" $run
# 
# 		OUTDIR=$MASKDIR/$RUN
# 		REGRUNDIR=$REGDIR/$RUN
# 		REFERNCE=$REGRUNDIR/ef.nii.gz
# 		
# # 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $ZSTAT $OUTDIR/zstat1_fail_sans.nii.gz \
# # 		-R $REFERNCE -i $REGRUNDIR/ef_2_efTempAffine.txt $REGRUNDIR/ef_2_efTempInverseWarp.nii.gz
# 
# # 		## create p map from z map
# # 		fslmaths $OUTDIR/zstat1_fail.nii.gz -ztop $OUTDIR/pstat1_fail.nii.gz
# # 
# # 		## create mask of all voxels < .05
# # 		fslmaths $OUTDIR/pstat1_fail.nii.gz -uthr .05 -bin $OUTDIR/pzstat1_05_fail.nii.gz
# # 
# # 		## create mask of all voxels < .1
# # 		fslmaths $OUTDIR/pstat1_fail.nii.gz -uthr .1 -bin $OUTDIR/pzstat1_10_fail.nii.gz
# 		
# 		sides=( L R )
# 		areas=( CA1 CA3DG Sub )
# 
# 		# 
# 		# 
# 
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 			
# 				printf -v MASK_NAME "%s_%s_fixed.nii.gz" $n $i
# 				#_test
# 				printf -v OUT_NAME "%s_%s_zstat_fail_sans.nii.gz" $n $i
# 
# 				printf -v OUT_NAME_20 "%s_%s_zstat_20_fail_sans.nii.gz" $n $i
# # 				printf -v OUT_NAME_25 "%s_%s_zstat_25_fail_sans.nii.gz" $n $i
# # 				printf -v OUT_NAME_50 "%s_%s_zstat_50_fail_sans.nii.gz" $n $i
# 				
# 			
# 				fslmaths $OUTDIR/zstat1_fail_sans.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# # 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# # 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)	
# 				THR_80=(`fslstats $OUTDIR/$OUT_NAME -P 80`)		
# 
# 				
# 				## create mask of top 250% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_80 -bin $OUTDIR/$OUT_NAME_20
# 						
# # 				## create mask of top 25% of z scores
# # 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25
# # 				
# # 
# # 				## create mask of top 50% of z scores
# # 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
# 				
# 			done
# 		done
# 	done
		
# 		sides=( right left )
# 		areas=( CA1 CA3DG Sub )
# 		parts=( Head Tail ERC PHG )
# 
# 		# 
# 		# 
# 
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 			
# 				printf -v MASK_NAME "ASHS_%s_%s_fixed.nii.gz" $n $i
# 				printf -v OUT_NAME "%s_%s_zstat_fail_test.nii.gz" $n $i
# 
# 				printf -v OUT_NAME_25 "%s_%s_zstat_25_fail_test.nii.gz" $n $i
# 				printf -v OUT_NAME_50 "%s_%s_zstat_50_fail_test.nii.gz" $n $i
# 			
# 				fslmaths $OUTDIR/zstat1_fail.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)		
# 
# 						
# 				## create mask of top 25% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25
# 				
# 
# 				## create mask of top 50% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
# 				
# 			done
# 		done
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${parts[@]}"
# 			do
# 			
# 				printf -v MASK_NAME "ASHS_%s_%s.nii.gz" $n $i
# 				printf -v OUT_NAME "%s_%s_zstat_fail_test.nii.gz" $n $i
# 
# 				printf -v OUT_NAME_25 "%s_%s_zstat_25_fail_test.nii.gz" $n $i
# 				printf -v OUT_NAME_50 "%s_%s_zstat_50_fail_test.nii.gz" $n $i
# 			
# 				fslmaths $OUTDIR/zstat1_fail.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)		
# 
# 						
# 				## create mask of top 25% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25
# 				
# 
# 				## create mask of top 50% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
# 				
# 			done
# 		done
		
# 		sides=( L R )
# 		areas=( CA1 CA3DG Sub )
# 		parts=( Head Tail Body )
# 
# 		# 
# 		# 
# 
# 			
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 			
# 				for r in "${parts[@]}"
# 				do
# 			
# 				printf -v MASK_NAME "%s_%s_%s.nii.gz" $n $i $r
# 				printf -v OUT_NAME "%s_%s_%s_zstat_fail_sans.nii.gz" $n $i $r
# 
# 				printf -v OUT_NAME_25 "%s_%s_%s_zstat_25_fail_sans.nii.gz" $n $i $r
# 				printf -v OUT_NAME_50 "%s_%s_%s_zstat_50_fail_sans.nii.gz" $n $i $r
# 			
# 				fslmaths $OUTDIR/zstat1_fail_sans.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)		
# 
# 						
# 				## create mask of top 25% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25
# 				
# 
# 				## create mask of top 50% of z scores
# 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
# 				
# 				done
# 			done
# 		done


##FOR SUCC ALL F 

# ZSTAT=$FSLDATADIR/analysis/task.gfeat/cope1.feat/stats/zstat4.nii.gz
# 
# 	for run in {1..8}; do
# 
# 		printf -v RUN "run%d" $run
# 
# 		OUTDIR=$MASKDIR/$RUN
# 		REGRUNDIR=$REGDIR/$RUN
# 		REFERNCE=$REGRUNDIR/ef.nii.gz
# 		
# # 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $ZSTAT $OUTDIR/zstat1_task_succAll.nii.gz \
# # 		-R $REFERNCE -i $REGRUNDIR/ef_2_efTempAffine.txt $REGRUNDIR/ef_2_efTempInverseWarp.nii.gz
# 		sides=( L R )
# 		areas=( CA1 CA3DG Sub )
# 
# 		# 
# 		# 
# 
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 			
# 				printf -v MASK_NAME "%s_%s_fixed_test.nii.gz" $n $i
# 				#
# 				printf -v OUT_NAME "%s_%s_zstat_task_succAll.nii.gz" $n $i
# 
# 				printf -v OUT_NAME_25 "%s_%s_zstat_25_task_succAll.nii.gz" $n $i
# 				printf -v OUT_NAME_50 "%s_%s_zstat_50_task_succAll.nii.gz" $n $i
# 			
# 				fslmaths $OUTDIR/zstat1_task_succAll.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)		
# 
# 						
# 				## create mask of top 25% of z scores
# 				fslmaths $OUTDIR/zstat1_task_succAll.nii.gz -thr $THR_75 -mas $OUTDIR/$MASK_NAME -abs -bin $OUTDIR/$OUT_NAME_25
# 				
# 
# 				## create mask of top 50% of z scores
# 				fslmaths $OUTDIR/zstat1_task_succAll.nii.gz -thr $THR_50 -mas $OUTDIR/$MASK_NAME -abs -bin $OUTDIR/$OUT_NAME_50
# 				
# 			done
# 		done
# 
# 	done
# 	
# 	ZSTAT=$FSLDATADIR/analysis/task.gfeat/cope1.feat/stats/zfstat1.nii.gz
# 
# 	for run in {1..8}; do
# 
# 		printf -v RUN "run%d" $run
# 
# 		OUTDIR=$MASKDIR/$RUN
# 		REGRUNDIR=$REGDIR/$RUN
# 		REFERNCE=$REGRUNDIR/ef.nii.gz
# 		
# # 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $ZSTAT $OUTDIR/zstat1_task_succF.nii.gz \
# # 		-R $REFERNCE -i $REGRUNDIR/ef_2_efTempAffine.txt $REGRUNDIR/ef_2_efTempInverseWarp.nii.gz
# 		sides=( L R )
# 		areas=( CA1 CA3DG Sub )
# 
# 		# 
# 		# 
# 
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 			
# 				printf -v MASK_NAME "%s_%s_fixed_test.nii.gz" $n $i
# 				#
# 				printf -v OUT_NAME "%s_%s_zstat_task_succF.nii.gz" $n $i
# 
# 				printf -v OUT_NAME_25 "%s_%s_zstat_25_task_succF.nii.gz" $n $i
# 				printf -v OUT_NAME_50 "%s_%s_zstat_50_task_succF.nii.gz" $n $i
# 			
# 				fslmaths $OUTDIR/zstat1_task_succAll.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
# 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
# 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)		
# 
# 						
# 				## create mask of top 25% of z scores
# 				fslmaths $OUTDIR/zstat1_task_succF.nii.gz -thr $THR_75 -mas $OUTDIR/$MASK_NAME -abs -bin $OUTDIR/$OUT_NAME_25
# 				
# 
# 				## create mask of top 50% of z scores
# 				fslmaths $OUTDIR/zstat1_task_succF.nii.gz -thr $THR_50 -mas $OUTDIR/$MASK_NAME -abs -bin $OUTDIR/$OUT_NAME_50
# 				
# 			done
# 		done
# 
# 	done

ZSTAT=$FSLDATADIR/analysis/m3_all_runs_sans_s.gfeat/cope1.feat/stats/zstat1.nii.gz
ZSTAT=$FSLDATADIR/analysis/m4_cue_fail.gfeat/cope1.feat/stats/zstat1.nii.gz


	for run in {1..8}; do

		printf -v RUN "run%d" $run

		OUTDIR=$MASKDIR/$RUN
		REGRUNDIR=$REGDIR/$RUN
		REFERNCE=$REGRUNDIR/ef.nii.gz

		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $ZSTAT $OUTDIR/zstat1_CueFail.nii.gz \
		-R $REFERNCE -i $REGRUNDIR/ef_2_efTempAffine.txt $REGRUNDIR/ef_2_efTempInverseWarp.nii.gz
		
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $ZSTAT $OUTDIR/zstat1_m_mm.nii.gz \
# 		-R $REFERNCE -i /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/tempROI_2_mni_Affine.txt \
# 		-i /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${sub}/mprage__2_ROIs_Affine.txt \
# 		/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${sub}/mprage__2_ROIs_InverseWarp.nii.gz \
# 		-i $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt -i $REGRUNDIR/ef_2_efTempAffine.txt $REGRUNDIR/ef_2_efTempInverseWarp.nii.gz
		

# 		## create p map from z map
# 		fslmaths $OUTDIR/zstat1_fail.nii.gz -ztop $OUTDIR/pstat1_fail.nii.gz
# 
# 		## create mask of all voxels < .05
# 		fslmaths $OUTDIR/pstat1_fail.nii.gz -uthr .05 -bin $OUTDIR/pzstat1_05_fail.nii.gz
# 
# 		## create mask of all voxels < .1
# 		fslmaths $OUTDIR/pstat1_fail.nii.gz -uthr .1 -bin $OUTDIR/pzstat1_10_fail.nii.gz
		
		sides=( L R )
		areas=( CA1 CA3DG Sub )

		# 
		# 

		for n in "${sides[@]}"
		do
			for i in "${areas[@]}"
			do
			
				printf -v MASK_NAME "%s_%s_fixed_test.nii.gz" $n $i
				#_test
				printf -v OUT_NAME "%s_%s_zstat_CueFail.nii.gz" $n $i

				printf -v OUT_NAME_20 "%s_%s_zstat_20_CueFail.nii.gz" $n $i
 				printf -v OUT_NAME_25 "%s_%s_zstat_25_CueFail.nii.gz" $n $i
 				printf -v OUT_NAME_50 "%s_%s_zstat_50_CueFail.nii.gz" $n $i
				
			
				fslmaths $OUTDIR/zstat1_m_mm.nii.gz -mul $OUTDIR/$MASK_NAME $OUTDIR/$OUT_NAME
 				THR_50=(`fslstats $OUTDIR/$OUT_NAME -P 50`)
 				THR_75=(`fslstats $OUTDIR/$OUT_NAME -P 75`)	
				THR_80=(`fslstats $OUTDIR/$OUT_NAME -P 80`)		

				
				## create mask of top 250% of z scores
				fslmaths $OUTDIR/$OUT_NAME -thr $THR_80 -bin $OUTDIR/$OUT_NAME_20
						
 				## create mask of top 25% of z scores
 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_75 -bin $OUTDIR/$OUT_NAME_25
 				
 
 				## create mask of top 50% of z scores
 				fslmaths $OUTDIR/$OUT_NAME -thr $THR_50 -bin $OUTDIR/$OUT_NAME_50
				
			done
		done
	done

	
done


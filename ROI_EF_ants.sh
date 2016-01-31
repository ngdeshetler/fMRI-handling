#!/bin/sh

SUBS=(17 24)
#( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 )
#
#
#  

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}
	MASKDIR=$FSLDATADIR/masks

	REGDIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/ANTS_REG/${sub}

	sides=( right left )
	#areas=( ERC PHC PRC Fus )
	#areas=( CA1 CA23DG Sub )
	areas=( NAcc )
	#parts=( A P )
	#

	# 
	# 
	for run in {1..3}; do

 		OUTDIR=$REGDIR/ROIs/run${run}

		#mkdir -p $OUTDIR
		REFERENCE=$REGDIR/run${run}/ef_LR.nii.gz


		for n in "${sides[@]}"
		do
			for i in "${areas[@]}"
			do
				printf -v OUT_NAME "%s_%s_deform.nii.gz" $n $i
				# 
				echo $OUT_NAME
				/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/${n}/${i}_alt.nii.gz $OUTDIR/$OUT_NAME -R \
				$REFERENCE -i $REGDIR/ef_temp/efTemp_2_HRRAAffine.txt  \
				-i $REGDIR/run${run}/ef_2_efTempAffine.txt $REGDIR/run${run}/ef_2_efTempInverseWarp.nii.gz 
				#
				#$REGDIR/ef_temp/efTemp_2_HRInverseWarp.nii.gz
		
				#$REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
	
				printf -v OUT_NAME_alt "%s_%s_deform_slice.nii.gz" $n $i  
				#
				echo $OUT_NAME_alt
				/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${OUT_NAME} \
				${OUTDIR}/$OUT_NAME_alt -R $REFERENCE --tightest-bounding-box --reslice-by-header
				
				### bin
				printf -v IN_NAME_alt "%s_%s_deform_slice.nii.gz" $n $i
				#
				printf -v OUT_NAME_fin "%s_%s.nii.gz" $n $i
				#_fixed
				fslmaths ${OUTDIR}/${IN_NAME_alt} -thr .15 -bin ${OUTDIR}/${OUT_NAME_fin}
			
			done
		done 

cd $OUTDIR

# 	fslmaths left_CA1_deform_slice.nii.gz -sub left_CA23DG_deform_slice.nii.gz L_1_g_2_fixing
# 	fslmaths L_1_g_2_fixing.nii.gz -thr 0 -bin L_over_for_1_fixing
# 	fslmaths L_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin L_over_for_3_fixing
# 	fslmaths left_CA1.nii.gz -mul L_over_for_1_fixing.nii.gz left_CA1_fixed
# 	fslmaths left_CA23DG.nii.gz -mul L_over_for_3_fixing.nii.gz left_CA23DG_fixed
# 
# 
# 	fslmaths right_CA1_deform_slice.nii.gz -sub right_CA23DG_deform_slice.nii.gz R_1_g_2_fixing
# 	fslmaths R_1_g_2_fixing.nii.gz -thr 0 -bin R_over_for_1_fixing
# 	fslmaths R_1_g_2_fixing.nii.gz -uthr 0 -mul -1 -bin R_over_for_3_fixing
# 	fslmaths right_CA1.nii.gz -mul R_over_for_1_fixing.nii.gz right_CA1_fixed
# 	fslmaths right_CA23DG.nii.gz -mul R_over_for_3_fixing.nii.gz right_CA23DG_fixed
# 
# 	fslmaths right_Sub.nii.gz -sub right_CA1_fixed.nii.gz -sub right_CA23DG_fixed.nii.gz -bin right_Sub_fixed
# 	fslmaths left_Sub.nii.gz -sub left_CA1_fixed.nii.gz -sub left_CA23DG_fixed.nii.gz -bin left_Sub_fixed 
# 
# 	rm *_fixing.nii.gz
	
	# fslmaths left_CA23DG_fixed.nii.gz -add left_CA1_fixed.nii.gz -add left_Sub_fixed.nii.gz -bin left_hipp
# 	fslmaths right_CA23DG_fixed.nii.gz -add right_CA1_fixed.nii.gz -add right_Sub_fixed.nii.gz -bin right_hipp
# 	
# 	fslmaths left_hipp.nii.gz -add right_hipp.nii.gz -bin hipp
# 	
# 	fslmaths left_ERC_fixed.nii.gz -add left_PHC_fixed.nii.gz -add left_PRC_fixed.nii.gz -add left_Fus_fixed.nii.gz -bin left_MTL_cortex
# 	fslmaths right_ERC_fixed.nii.gz -add right_PHC_fixed.nii.gz -add right_PRC_fixed.nii.gz -add right_Fus_fixed.nii.gz -bin right_MTL_cortex
# 	
# 	fslmaths left_MTL_cortex.nii.gz -add right_MTL_cortex.nii.gz -bin MTL_cortex
# 	
# 	fslmaths left_hipp.nii.gz -add left_MTL_cortex.nii.gz -bin left_MTL
# 	fslmaths right_hipp.nii.gz -add right_MTL_cortex.nii.gz -bin right_MTL
# 	
# 	fslmaths left_MTL.nii.gz -add right_MTL.nii.gz -bin MTL
	

#################### PARTS ########################

# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 				for m in "${parts[@]}"
# 				do
# 					printf -v OUT_NAME "%s_%s_%s_deform.nii.gz" $n $i $m 
# 					# 
# 					echo $OUT_NAME
# 					/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 $MASKDIR/${n}/${i}_${m}_alt.nii.gz $OUTDIR/$OUT_NAME -R \
# 					$REFERENCE -i $REGDIR/ef_temp/efTemp_2_HRRAAffine.txt  \
# 					-i $REGDIR/run${run}/ef_2_efTempAffine.txt $REGDIR/run${run}/ef_2_efTempInverseWarp.nii.gz 
# 					#
# 					#$REGDIR/ef_temp/efTemp_2_HRInverseWarp.nii.gz
# 	
# 					#$REGDIR/hiRes2mprage_wSkullWarp.nii.gz $REGDIR/hiRes2mprage_wSkullAffine.txt \
# 
# 					printf -v OUT_NAME_alt "%s_%s_%s_deform_slice.nii.gz" $n $i $m   
# 					#
# 					echo $OUT_NAME_alt
# 					/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${OUTDIR}/${OUT_NAME} \
# 					${OUTDIR}/$OUT_NAME_alt -R $REFERENCE --tightest-bounding-box --reslice-by-header
# 	
# 				done
# 
# 			done
# 		done 
# 
# 		for n in "${sides[@]}"
# 		do
# 			for i in "${areas[@]}"
# 			do
# 				for m in "${parts[@]}"
# 				do
# 					printf -v IN_NAME "%s_%s_%s_deform_slice.nii.gz" $n $i $m 
# 					#
# 					printf -v OUT_NAME "%s_%s_%s.nii.gz" $n $i $m 
# 					#
# 					fslmaths ${OUTDIR}/${IN_NAME} -thr .15 -bin ${OUTDIR}/${OUT_NAME}
# 	
# 				done
# 			done
# 		done
# 
# 		cd $OUTDIR
# 
# 		for m in "${parts[@]}"
# 		do
# 
# 			fslmaths left_CA1_${m}_deform_slice.nii.gz -sub left_CA23DG_${m}_deform_slice.nii.gz L_1_g_2_${m}_fixing
# 			fslmaths L_1_g_2_${m}_fixing.nii.gz -thr 0 -bin L_over_for_1_${m}_fixing
# 			fslmaths L_1_g_2_${m}_fixing.nii.gz -uthr 0 -mul -1 -bin L_over_for_3_${m}_fixing
# 			fslmaths left_CA1_${m}.nii.gz -mul L_over_for_1_${m}_fixing.nii.gz left_CA1_${m}_fixed
# 			fslmaths left_CA23DG_${m}.nii.gz -mul L_over_for_3_${m}_fixing.nii.gz left_CA23DG_${m}_fixed
# 
# 
# 			fslmaths right_CA1_${m}_deform_slice.nii.gz -sub right_CA23DG_${m}_deform_slice.nii.gz R_1_g_2_${m}_fixing
# 			fslmaths R_1_g_2_${m}_fixing.nii.gz -thr 0 -bin R_over_for_1_${m}_fixing
# 			fslmaths R_1_g_2_${m}_fixing.nii.gz -uthr 0 -mul -1 -bin R_over_for_3_${m}_fixing
# 			fslmaths right_CA1_${m}.nii.gz -mul R_over_for_1_${m}_fixing.nii.gz right_CA1_${m}_fixed
# 			fslmaths right_CA23DG_${m}.nii.gz -mul R_over_for_3_${m}_fixing.nii.gz right_CA23DG_${m}_fixed
# 
# 			fslmaths right_Sub_${m}.nii.gz -sub right_CA1_${m}_fixed.nii.gz -sub right_CA23DG_${m}_fixed.nii.gz -bin right_Sub_${m}_fixed
# 			fslmaths left_Sub_${m}.nii.gz -sub left_CA1_${m}_fixed.nii.gz -sub left_CA23DG_${m}_fixed.nii.gz -bin left_Sub_${m}_fixed 
# 
# 			rm *_fixing.nii.gz
# 		done
# 
 	done
done
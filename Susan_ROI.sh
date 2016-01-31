#!/bin/bash

SUBS=( MM_502 MM_503 MM_505 MM_508 MM_507 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_522 MM_523 MM_524 )
#

#  
#   

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		MASKDIR=$FSLDATADIR/masks/$RUN
		STATSDIR=$FSLDATADIR/analysis/PRE/$RUN
		
		cd $MASKDIR
		
		fslmaths R_CA1_fixed_test.nii.gz -add L_CA1_fixed_test.nii.gz -bin CA1_mask
		fslmaths R_CA3DG_fixed_test.nii.gz -add L_CA3DG_fixed_test.nii.gz -bin CA3DG_mask
		fslmaths R_Sub_fixed_test.nii.gz -add L_Sub_fixed_test.nii.gz -bin Sub_mask
		
		cd $STATSDIR
		
		fslmaths filtered_func_data_NS.nii.gz -mas $MASKDIR/hipp_ashs.nii.gz filtered_func_data_NS_hipp
		fslmaths filtered_func_data_NS.nii.gz -mas $MASKDIR/CA1_mask.nii.gz filtered_func_data_NS_CA1
		fslmaths filtered_func_data_NS.nii.gz -mas $MASKDIR/CA3DG_mask.nii.gz filtered_func_data_NS_CA3DG
		fslmaths filtered_func_data_NS.nii.gz -mas $MASKDIR/Sub_mask.nii.gz filtered_func_data_NS_Sub
		
		hipp_med=(`fslstats filtered_func_data_NS_hipp.nii.gz -k $MASKDIR/hipp_ashs.nii.gz -p 50`)
		med_75_hipp=$(echo "scale=6; ${hipp_med} *.75" | bc)
		
		CA1_med=(`fslstats filtered_func_data_NS_CA1.nii.gz -k $MASKDIR/CA1_mask.nii.gz -p 50`)
		med_75_CA1=$(echo "scale=6; ${CA1_med} *.75" | bc)
		
		CA3DG_med=(`fslstats filtered_func_data_NS_CA3DG.nii.gz -k $MASKDIR/CA3DG_mask.nii.gz -p 50`)
		med_75_CA3DG=$(echo "scale=6; ${CA3DG_med} *.75" | bc)
		
		Sub_med=(`fslstats filtered_func_data_NS_Sub.nii.gz -k $MASKDIR/Sub_mask.nii.gz -p 50`)
		med_75_Sub=$(echo "scale=6; ${Sub_med} *.75" | bc)
		
		fslmaths filtered_func_data_NS_hipp.nii.gz -Tmean mean_func_hipp
		fslmaths filtered_func_data_NS_CA1.nii.gz -Tmean mean_func_CA1
		fslmaths filtered_func_data_NS_CA3DG.nii.gz -Tmean mean_func_CA3DG
		fslmaths filtered_func_data_NS_Sub.nii.gz -Tmean mean_func_Sub
		
		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/susan filtered_func_data_NS_hipp ${med_75_hipp} 2.123 3 1 1 \
		mean_func_hipp ${med_75_hipp} filtered_func_data_NS_hipp_susan
		
		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/susan filtered_func_data_NS_CA1 ${med_75_CA1} 2.123 3 1 1 \
		mean_func_CA1 ${med_75_CA1} filtered_func_data_NS_CA1_susan
		
		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/susan filtered_func_data_NS_CA3DG ${med_75_CA3DG} 2.123 3 1 1 \
		mean_func_CA3DG ${med_75_CA3DG} filtered_func_data_NS_CA3DG_susan
		
		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/susan filtered_func_data_NS_Sub ${med_75_Sub} 2.123 3 1 1 \
		mean_func_Sub ${med_75_Sub} filtered_func_data_NS_Sub_susan

		fslmaths filtered_func_data_NS_hipp_susan.nii.gz -mas $MASKDIR/hipp_ashs.nii.gz filtered_func_data_NS_hipp_susan
		fslmaths filtered_func_data_NS_CA1_susan.nii.gz -mas $MASKDIR/CA1_mask.nii.gz filtered_func_data_NS_CA1_susan
		fslmaths filtered_func_data_NS_CA3DG_susan.nii.gz -mas $MASKDIR/CA3DG_mask.nii.gz filtered_func_data_NS_CA3DG_susan
		fslmaths filtered_func_data_NS_Sub_susan.nii.gz -mas $MASKDIR/Sub_mask.nii.gz filtered_func_data_NS_Sub_susan
		
		
		fslmaths filtered_func_data_S.ica/mask.nii.gz -add $MASKDIR/hipp_ashs.nii.gz -add $MASKDIR/CA1_mask.nii.gz \
		-add $MASKDIR/CA3DG_mask.nii.gz -add $MASKDIR/Sub_mask.nii.gz for_dividing
		
		fslmaths filtered_func_data_S.nii.gz -add filtered_func_data_NS_hipp.nii.gz -add filtered_func_data_NS_CA1.nii.gz \
		-add filtered_func_data_NS_CA3DG.nii.gz -add filtered_func_data_NS_Sub.nii.gz -div for_dividing.nii.gz \
		filtered_func_data_ROI_smooth
		
		rm filtered_func_data_NS_hipp*
		rm filtered_func_data_NS_CA1*
		rm filtered_func_data_NS_CA3DG*
		rm filtered_func_data_NS_Sub*
		rm mean_func_*
		rm for_dividing.nii.gz
		
	done
done
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
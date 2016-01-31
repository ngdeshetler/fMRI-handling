#!/bin/bash

SUBS=( MM_519 )

# MM_503 MM_505 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 
#  MM_502 
# MM_507 
# MM_520 MM_521 

# sides=( R L )
# areas=( CA1 CA3DG Sub )

for sub in "${SUBS[@]}"; do

	for run in {1..8}; do

		printf -v RUN "run%d" $run

		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S.nii.gz \
		 -applyxfm -init /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/reg_native/example_func2standard.mat \
		 -out /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native.nii.gz -paddingsize 0.0 \
		 -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/raw/mprage/mprage_brain.nii.gz


		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/fslcreatehd 120 128 128 1 2 2 2 1 0 0 0 16  \
		/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native_2mm.nii.gz_tmp.nii.gz ; \
		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native.nii.gz \
		 -applyxfm -init /space/raid/fmri/fsl-5.0.2.1-centos6_64/etc/flirtsch/ident.mat -out \
		 /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native_2mm.nii.gz \
		 -paddingsize 0.0 -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native_2mm.nii.gz_tmp

		gunzip /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native_2mm.nii.gz

	done
	


	# for n in "${sides[@]}"
	# do
	# 	for i in "${areas[@]}"
	# 	do
	#  		printf -v ROI_PRE "%s_%s.nii.gz" $n $i  
	#  		printf -v ROI_POST "2mm_%s_%s.nii.gz" $n $i
	# 		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/fslcreatehd 120 128 128 1 2 2 2 1 0 0 0 16  \
	# 		/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/masks/$ROI_POST_tmp ; \
	# 		/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/masks/$ROI_PRE \
	#  		-applyxfm -init /space/raid/fmri/fsl-5.0.2.1-centos6_64/etc/flirtsch/ident.mat -out \
	#  		/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/masks/$ROI_POST \
	# 		-paddingsize 0.0 -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/masks/$ROI_POST_tmp
	# 	done
	# done 

done

sub=MM_507

for run in 1 4 6 7 8; do

	printf -v RUN "run%d" $run

	/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S.nii.gz \
	 -applyxfm -init /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/reg_native/example_func2standard.mat \
	 -out /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native.nii.gz -paddingsize 0.0 \
	 -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/raw/mprage/mprage_brain.nii.gz


	/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/fslcreatehd 120 128 128 1 2 2 2 1 0 0 0 16  \
	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native_2mm.nii.gz_tmp.nii.gz ; \
	/space/raid/fmri/fsl-5.0.2.1-centos6_64/bin/flirt -in /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native.nii.gz \
	 -applyxfm -init /space/raid/fmri/fsl-5.0.2.1-centos6_64/etc/flirtsch/ident.mat -out \
	 /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native_2mm.nii.gz \
	 -paddingsize 0.0 -interp nearestneighbour -ref /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native_2mm.nii.gz_tmp
	 
	 gunzip /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/analysis/PRE/$RUN/filtered_func_data_S_2native_2mm.nii.gz

done
		
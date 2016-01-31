#!/bin/bash
# ants_featregapply: N. De Shetler, 1/26/13
# Shell script that replaces the output of fsl's featregapply, which applies fsl registration
# to the cope and varcope images, with the same outputs but using ANTS registration. This
# script will apply the registration of a BOLD scan to a standard template (following the  
# BOLD -> initial high res (mbw) -> high res (mprage) -> standard method) that was calculated
# using Advanced Normalization Tools (ANTs). This script runs locally, so might take a while
# to run if being applied to many feat directories. 
# This script is designed to use the outputs and structure that was created by the ants_reg.sh
# script.

# This script has been hard coded for the original project which it was created for, however
# notes have been included below to indicate what would need to be altered for use on another
# project.
  
# Notes about fsl and featregapply: when you run a higher-level analysis in fsl the first
# pre step is converting some of the images created in the first-level analysis into a standard
# space.  Before this point all statistics were performed in native space.  feat calls the 
# function featregapply to make theses conversions, and the registered images are kept in
# the directory reg_standard. fsl tries to save time by not rerunning featregapply if the
# content of this folder is newer than the content of the reg (and stats ??) directory. In
# this way ones own registrations can be used, and will not be replaced when running higher
# analyses if no other alterations to the first-level directories have been made.


# USAGE: ./ants_featregapply.sh <subject_dir>

#########################################################################################
#########################################################################################


## below creates variables that hold the location of the subject's directory, where the 
## ants registration is saved, and where the feat directories live
DATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/MM_${1}
REGDIR=$DATADIR/reg
STATSDIR=$DATADIR/analysis/STAT

## The location of the standard template to which bold is to be registered to. This can be
## either a template made from ones own mprage images, using buildtemplateparallel.sh, or
## another standard image, such as MNI.  I've included the 2mm MNI template below, uncomment to use.
#STANDARD=/space/raid/fmri/fsl-4.1.9-centos5_64/data/standard/MNI152_T1_2mm_brain.nii.gz
#STANDARD=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_temp/mprage_template.nii.gz
STANDARD=$REGDIR/ef_temp/BOLD_template.nii.gz
#STANDARD=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/tempROI_2_mni_deformed.nii.gz 

## The range inside the {} represents the number of feat run directories to apply registration to.  
## This might have to be more heavily edited if feat directories don't use a run index.
# 7 8
#
for i in {1..8}
do
	
	## 
	printf -v WORKINGDIR "%s/run%d_output_%s.feat" $STATSDIR $i ${2}
	#"%s/run%d_output_m3_smooth_sans.feat"
	#"%s/run%d_output_m3_noSmooth_sans.feat"
	#"%s/run%d_output_m4_smooth_denoised.feat"
	#"%s/run%d_output_m3_smooth.feat"
	printf -v RUNREGDIR "%s/run%d" $REGDIR $i
	
	## Uncomment if featregapply has not already been applied to the directories
 	cd ${WORKINGDIR}
  	mkdir reg_standard
 	cd reg_standard
  	mkdir stats
  	mkdir reg
	##
	
	cd ${WORKINGDIR}/reg_standard
	
	## Comment out if featregapply has not already been applied to the directories
	rm example_func.nii.gz
	rm mask.nii.gz
	rm mean_func.nii.gz
	##
	
# 	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${WORKINGDIR}/example_func.nii.gz example_func.nii.gz \
# 	-R /space/raid/fmri/fsl-5.0.4-centos6_64/data/standard/MNI152_T1_2mm.nii.gz --use-NN \
# 	${RUNREGDIR}/ef_2_efTempRAAffine.txt $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${1}/mprage__2_ROIs_Warp.nii.gz \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${1}/mprage__2_ROIs_Affine.txt \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/tempROI_2_mni_Affine.txt
# 	
# 	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${WORKINGDIR}/mask.nii.gz mask.nii.gz \
# 	-R /space/raid/fmri/fsl-5.0.4-centos6_64/data/standard/MNI152_T1_2mm.nii.gz --use-NN \
# 	${RUNREGDIR}/ef_2_efTempRAAffine.txt $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${1}/mprage__2_ROIs_Warp.nii.gz \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${1}/mprage__2_ROIs_Affine.txt \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/tempROI_2_mni_Affine.txt
# 	
# 	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${WORKINGDIR}/mean_func.nii.gz mean_func.nii.gz \
# 	-R /space/raid/fmri/fsl-5.0.4-centos6_64/data/standard/MNI152_T1_2mm.nii.gz --use-NN \
# 	${RUNREGDIR}/ef_2_efTempRAAffine.txt $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${1}/mprage__2_ROIs_Warp.nii.gz \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${1}/mprage__2_ROIs_Affine.txt \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/tempROI_2_mni_Affine.txt
			
	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${WORKINGDIR}/example_func.nii.gz example_func.nii.gz -R ${STANDARD} \
		${RUNREGDIR}/ef_2_efTempRAAffine.txt 
		
	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${WORKINGDIR}/mask.nii.gz mask.nii.gz -R ${STANDARD} \
		${RUNREGDIR}/ef_2_efTempRAAffine.txt
		
	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${WORKINGDIR}/mean_func.nii.gz mean_func.nii.gz -R ${STANDARD} \
		${RUNREGDIR}/ef_2_efTempRAAffine.txt
	
	cd ${WORKINGDIR}/reg_standard/reg
	
	## Comment out if featregapply has not already been applied to the directories
	rm highres.nii.gz
	##
	
# 	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${REGDIR}/mprage_brain.nii.gz highres.nii.gz -R ${STANDARD} \
# 		${REGDIR}/mprage2tempWarp.nii.gz ${REGDIR}/mprage2tempAffine.txt 
		
# 	/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${REGDIR}/mprage_brain.nii.gz highres.nii.gz \
# 	-R /space/raid/fmri/fsl-5.0.4-centos6_64/data/standard/MNI152_T1_2mm.nii.gz \
# 	$REGDIR/mprage2templateWarp.nii.gz $REGDIR/mprage2templateAffine.txt \
# 	/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/temp_2mniAffine.txt
		
	cp $STANDARD highres.nii.gz
		
	cd ${WORKINGDIR}/stats
	
	COPELIST=( $(ls cope?.nii.gz) )
	VARCOPELIST=( $(ls varcope?.nii.gz) )
	COPELIST_alt=( $(ls cope??.nii.gz) )
	VARCOPELIST_alt=( $(ls varcope??.nii.gz) )	
	
	declare -a COMBLIST
	COMBLIST=( ${COPELIST[@]} ${VARCOPELIST[@]} ${COPELIST_alt[@]} ${VARCOPELIST_alt[@]} )
	
	cd ${WORKINGDIR}/reg_standard/stats	
	
	## Comment out if featregapply has not already been applied to the directories
	rm cope*.nii.gz
	rm varcope*.nii.gz
	rm FEtdof_*.nii.gz
	##
	
	for n in "${COMBLIST[@]}"
	do
		
# 		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${WORKINGDIR}/stats/${n} ${n} \
# 		-R /space/raid/fmri/fsl-5.0.4-centos6_64/data/standard/MNI152_T1_2mm.nii.gz --use-NN \
# 		${RUNREGDIR}/ef_2_efTempRAAffine.txt $REGDIR/ef_temp/efTemp_2_mprageRAAffine.txt \
# 		/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${1}/mprage__2_ROIs_Warp.nii.gz \
# 		/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/${1}/mprage__2_ROIs_Affine.txt \
# 		/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_ROIs_template/tempROI_2_mni_Affine.txt
			
			
		/space/raid/fmri/ANTs/bin/WarpImageMultiTransform 3 ${WORKINGDIR}/stats/${n} ${n} -R ${STANDARD} \
			${RUNREGDIR}/ef_2_efTempRAAffine.txt

	done
	
done



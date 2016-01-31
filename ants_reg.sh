#!/bin/bash
# ants_reg: N. De Shetler, 1/26/13
# Shell script for running all the necessary steps for calculating registration of a BOLD 
# scan to a standard template (following the BOLD -> initial high res (mbw) -> high res 
# (mprage) -> standard method) using Advanced Normalization Tools (ANTs) on the func grid.
# This script is designed to prepare for the use of the ants_featregapply.sh, which applies
# registration to a FSL feat directory. 
# Additionally, this script includes registration of a sperate high res scan, used for ROI  
# creation, to mprage image.

# This script has been hard coded for the original project which it was created for, however
# notes have been included below to indicate what would need to be altered for use on another
# project.  Additionally, the ANTS settings where optimized for the original project, and
# should be edited based of experiments with ANTS sets using antsIntroduction.sh


# USAGE: ./ants_reg.sh <subject_dir>

#########################################################################################
#########################################################################################


## below creates variables that hold the location of the subject's directory and anatomical 
## images. Use of symbolic links in the raw directory makes this the same for all subjects
DATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/${1}
ANATFILE=${DATADIR}/raw/mprage/mprage.nii.gz
#INTANATFILE=${DATADIR}/analysis/STAT/run1_output_m1_smooth.feat/reg/unwarp/initial_highres_undistorted.nii.gz
#INTANATFILE=${DATADIR}/raw/mbw/mbw.nii.gz


## for the extra hires image; comment out if not needed
HIRESFILE=${DATADIR}/raw/high_res/high_res.nii.gz
##

## The location of the standard template to which bold is to be registered to. This can be
## either a template made from ones own mprage images, using buildtemplateparallel.sh, or
## another standard image, such as MNI.  I've included the 2mm MNI template below, uncomment to use.
#STAND_TEMP=/space/raid/fmri/fsl-4.1.9-centos5_64/data/standard/MNI152_T1_2mm_brain.nii.gz
#STAND_TEMP=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_temp/mprage_template.nii.gz

cd ${DATADIR} #move to subject directory

#mkdir reg #makes a new directory to hold the registration results

cd reg

## creates links to anatomical images to the can be called from the current directory
ln -s ${ANATFILE} mprage.nii.gz
#ln -s ${INTANATFILE} mbw_brain.nii.gz
#ln -s ${INTANATFILE} mbw.nii.gz
## comment out below if not using extra hires
ln -s ${HIRESFILE} high_res.nii.gz
##
#ln -s ${STAND_TEMP} stand.nii.gz

## Below submits ANTS jobs to the grid.  Make sure to edit the command inside the quotes
## based on settings that work best.  antsIntroduction.sh prints the command to use in its
## output.  
#sge qsub '/space/raid/fmri/ANTs/bin/ANTS 3 -m PR[mbw_brain.nii.gz,mprage_brain.nii.gz,1,4] -t GreedyExp[0.5,10] -r Gauss[3,0.5] -o mprage2mbw -i 30x90x20 --use-Histogram-Matching  --number-of-affine-iterations 10000x10000x10000x10000x10000 --MI-option 32x16000'

#sge qsub '/space/raid/fmri/ANTs/bin/ANTS 3 -m  PR[stand.nii.gz,mprage_brain.nii.gz,1,4] -t SyN[0.25] -r Gauss[3,0] -o mprage2temp -i 30x90x20 --use-Histogram-Matching  --number-of-affine-iterations 10000x10000x10000x10000x10000 --MI-option 32x16000'

## comment out below if not using extra hires
sge qsub '/space/raid/fmri/ANTs/bin/ANTS 3 -m  PR[mprage.nii.gz,high_res.nii.gz,1,4] -t SyN[0.25] -r Gauss[3,0] -o hiRes2mprage_wSkull -i 30x90x20 --use-Histogram-Matching  --number-of-affine-iterations 10000x10000x10000x10000x10000 --MI-option 32x16000'
##

## Natalie's extra step to deal with difference between skull version of mbw (which works better for the non-liner reg) and the unwarped version of the mbw (which works better for the unwarped BOLD to mbw)
#sge qsub '/space/raid/fmri/ANTs/bin/ANTS 3 -m PR[mbw.nii.gz,mbw_brain.nii.gz,1,4] -o mbw_unwarp_2_mbw_skull.nii.gz -i 0 --use-Histogram-Matching --number-of-affine-iterations 10000x10000x10000x10000x10000 --MI-option 32x16000  --do-rigid: true' 
##

## Number of feat run directories to apply registration to.  This might have to be more heavily
## edited if feat directories don't use a run index

# for i in {1..8}
# do
# 	printf -v runname "run%d" $i
# 	
# 	mkdir ${runname} #makes a directory to hold the BOLD -> MBW step for each run
# 	cd ${runname}
# 	
# 	## Below creates a variable that holds the location of the example_func image that is
# 	## created in a feat analysis.  The name of the feat path and directory should be  
# 	## edited based on ones naming convention.
# 	printf -v EF_FILE "%s/analysis/STAT/run%d_output_m1_noSmooth.feat/example_func.nii.gz" $DATADIR $i
# 	
# 	ln -s ${EF_FILE} ef.nii.gz #link so that the example_func image can be called from current directory
# 	ln -s ../mbw_brain.nii.gz mbw_brain.nii.gz #same for mbw image
# 
# 	## again, edit based on ANTS settings that work best.
# 	sge qsub '/space/raid/fmri/ANTs/bin/ANTS 3 -m PR[mbw_brain.nii.gz,ef.nii.gz,1,4] -o ef2mbw.nii.gz -i 0 --use-Histogram-Matching --number-of-affine-iterations 10000x10000x10000x10000x10000 --MI-option 32x16000  --rigid-affine true'
# 	
# 	cd ..	
# done


#mkdir loc #makes a directory to hold the BOLD -> MBW step for each run
#cd loc
	
## Below creates a variable that holds the location of the example_func image that is
## created in a feat analysis.  The name of the feat path and directory should be  
## edited based on ones naming convention.
#printf -v EF_FILE "%s/analysis/STAT/localizer_output_smooth.feat/example_func.nii.gz" $DATADIR $i
	
#ln -s ${EF_FILE} ef.nii.gz #link so that the example_func image can be called from current directory
#ln -s ../mbw_brain.nii.gz mbw_brain.nii.gz #same for mbw image

## again, edit based on ANTS settings that work best.
#sge qsub '/space/raid/fmri/ANTs/bin/ANTS 3 -m PR[mbw_brain.nii.gz,ef.nii.gz,1,4] -o ef2mbw.nii.gz -i 0 --use-Histogram-Matching --number-of-affine-iterations 10000x10000x10000x10000x10000 --MI-option 32x16000  --rigid-affine true'
	

## DD (Diffeomorphic Demons style exponential mapping) transformation model command
#/space/raid/fmri/ANTs/bin/ANTS 3 -m  PR[FIXED,MOVNING,1,4] -t GreedyExp[0.5,10] -r Gauss[3,0.5] -o OUTPUT -i 30x90x20 --use-Histogram-Matching  --number-of-affine-iterations 10000x10000x10000x10000x10000 --MI-option 32x16000  



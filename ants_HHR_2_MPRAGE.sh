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
DATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${1}

ANATFILE=${DATADIR}/activations/MPRAGE.nii.gz



## for the extra hires image; comment out if not needed
HIRESFILE=${DATADIR}/activations/HHR_struct.nii.gz
##

## The location of the standard template to which bold is to be registered to. This can be
## either a template made from ones own mprage images, using buildtemplateparallel.sh, or
## another standard image, such as MNI.  I've included the 2mm MNI template below, uncomment to use.
#STAND_TEMP=/space/raid/fmri/fsl-4.1.9-centos5_64/data/standard/MNI152_T1_2mm_brain.nii.gz
#STAND_TEMP=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_temp/mprage_template.nii.gz

cd /space/raid6/data/knowlton/PS_Reward_Study/Data/ANTS_REG #move to subject directory

mkdir ${1} #makes a new directory to hold the registration results
cd ${1}

## creates links to anatomical images to the can be called from the current directory
ln -s ${ANATFILE} mprage.nii.gz
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









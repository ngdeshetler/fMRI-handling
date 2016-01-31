#!/bin/bash

#source /space/raid/linux/sge-root/FUNC_Grid/common/settings.csh


SUBS=( MM_502 MM_503 MM_505 MM_507 MM_508 MM_509 MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521 MM_523 MM_522 MM_523 MM_524 )

# 
#  
#  

for sub in "${SUBS[@]}"; do

DATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub
REGDIR=$DATADIR/reg

cd $REGDIR
# mkdir ef_temp
# cd ef_temp

# for i in 1 2 3 4 6 7 8
# do
# 	
# 	printf -v RUNREGDIR "%s/run%d" $REGDIR $i
# 	printf -v LINKNAME "ef_run%d.nii.gz" $i
# 	
# 	ln -s $RUNREGDIR/ef.nii.gz $LINKNAME
# 	
# done
# 
# cp /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/buildtemplateparallel.sh .
# 
# sh buildtemplateparallel.sh -d 3 -o BOLD_ ef_run?.nii.gz
#1 2 3 4 5 6 7 8

for i in {1..8}
do
	
	printf -v RUNREGDIR "%s/run%d" $REGDIR $i
	#mkdir $RUNREGDIR
	cd $RUNREGDIR
	
	#cp $DATADIR/analysis/STAT/run${i}_output_m3_noSmooth.feat/example_func.nii.gz ef.nii.gz
	
	sh $ANTSPATH/antsIntroduction.sh -d 3 -i ef.nii.gz -r ../ef_temp/BOLD_template.nii.gz -o ef_2_efTempRA -t RA
done

#mkdir loc
cd $REGDIR/loc
#cp $DATADIR/analysis/STAT/localizer_output_smooth.feat/example_func.nii.gz ef.nii.gz
sh $ANTSPATH/antsIntroduction.sh -d 3 -i ef.nii.gz -r ../ef_temp/BOLD_template.nii.gz -o ef_2_efTempRA -t RA



# cd $REGDIR/ef_temp
# 
# sh $ANTSPATH/antsIntroduction.sh -d 3 -i BOLD_template.nii.gz -r ../mprage.nii.gz -o efTemp_2_mprage

done
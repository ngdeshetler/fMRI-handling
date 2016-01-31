#!/bin/bash

#source /space/raid/linux/sge-root/FUNC_Grid/common/settings.csh


SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 )

# 

for sub in "${SUBS[@]}"; do

	DATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}
	REGDIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/ANTS_REG/${sub}

### Build EF template

 	cd $REGDIR
 	mkdir -p ef_temp
	cd ef_temp

	for i in {1..3}
	do
	
		NVOLS_RC=`fslnvols ${DATADIR}/activations/HHR_func_recall_run${i}_reslice.nii.gz`
			NVOLS_RC_rmn=$((NVOLS_RC%2)) #the remander, so that can deal with both even and odd volumes
			DIV_RC=$(((NVOLS_RC/2)-$NVOLS_RC_rmn)) #Find the middle voxel (removing the remainder if odd) 
		NVOLS_LR=`fslnvols ${DATADIR}/activations/HHR_func_learn_run${i}_reslice.nii.gz`
			NVOLS_LR_rmn=$((NVOLS_LR%2))
			DIV_LR=$(((NVOLS_LR/2)-$NVOLS_LR_rmn)) 
	
		fslroi ${DATADIR}/activations/HHR_func_recall_run${i}_reslice.nii.gz ef_RC_${i} ${DIV_RC} 1
		fslroi ${DATADIR}/activations/HHR_func_learn_run${i}_reslice.nii.gz ef_LR_${i} ${DIV_LR} 1
	
	done
	
	NVOLS_MID=`fslnvols ${DATADIR}/activations/HHR_func_MID_reslice.nii.gz`
		NVOLS_MID_rmn=$((NVOLS_MID%2))
		DIV_MID=$(((NVOLS_MID/2)-$NVOLS_MID_rmn))
		
	fslroi ${DATADIR}/activations/HHR_func_MID_reslice.nii.gz ef_MID ${DIV_MID} 1

	cp /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/buildtemplateparallel.sh .

	sh buildtemplateparallel.sh -d 3 -o BOLD_ ef_*.nii.gz

### Register ef to eftemp

 	cd $REGDIR

for i in {1..3}
do
	
	printf -v RUNREGDIR "%s/run%d" $REGDIR $i
	mkdir -p $RUNREGDIR
	cd $RUNREGDIR
	
	ln -s ../ef_temp/ef_LR_${i}.nii.gz ef_LR.nii.gz
	
	sh $ANTSPATH/antsIntroduction.sh -d 3 -i ef_LR.nii.gz -r ../ef_temp/BOLD_template.nii.gz -o ef_2_efTemp
	sh $ANTSPATH/antsIntroduction.sh -d 3 -i ef_LR.nii.gz -r ../ef_temp/BOLD_template.nii.gz -o ef_2_efTempRA -t RA
	cd ..
done

mkdir -p MID
cd MID

	ln -s ../ef_temp/ef_MID.nii.gz ef_MID.nii.gz
	
	sh $ANTSPATH/antsIntroduction.sh -d 3 -i ef_MID.nii.gz -r ../ef_temp/BOLD_template.nii.gz -o ef_2_efTemp
	sh $ANTSPATH/antsIntroduction.sh -d 3 -i ef_MID.nii.gz -r ../ef_temp/BOLD_template.nii.gz -o ef_2_efTempRA -t RA
	cd ..


	# cd $REGDIR/ef_temp
	# 
	# sh $ANTSPATH/antsIntroduction.sh -d 3 -i BOLD_template.nii.gz -r ../mprage.nii.gz -o efTemp_2_mprage

done

### Register EFtemp to HR

for sub in "${SUBS[@]}"; do

	DATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}
	REGDIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/ANTS_REG/${sub}
 	cd $REGDIR/ef_temp/
	
	$ANTSPATH/antsIntroduction.sh -d 3 -i BOLD_template.nii.gz \
	-r ${DATADIR}/activations/HHR_struct.nii.gz -o efTemp_2_HRRA -t RA
	
done
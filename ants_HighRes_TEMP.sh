#!/bin/bash

#source /space/raid/linux/sge-root/FUNC_Grid/common/settings.csh


SUBS=( 8 9 10 11 12 13 15 16 17 18 19 20 21 22 23 24 25 26  )
#14 
# 
REGDIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/ANTS_REG/high_res_temp/poor
cd $REGDIR
# 
# for sub in "${SUBS[@]}"; do
# 
# 	ln -s /space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}/activations/HHR_struct.nii.gz highRes_${sub}.nii.gz
# 	
# 
# done
# 
 	cp /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/buildtemplateparallel.sh .
	sh buildtemplateparallel.sh -d 3 -r 1 -o HighRes_ highRes_*.nii.gz
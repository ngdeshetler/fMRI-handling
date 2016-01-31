#!/bin/sh

SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 25 )

# 24  26

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}
STATDIR=$FSLDATADIR/analysis

for run in {1..3}; do
 RUNDIR=$STATDIR/run${run}_memory_value_noDis_NS.feat
 
 if [ ! -f $RUNDIR/cluster_mask_zstat1.nii.gz ]
 then
 	rm -r /space/raid6/data/knowlton/PS_Reward_Study/Data/$sub/analysis/run${run}_memory_value*.feat
		feat /space/raid6/data/knowlton/PS_Reward_Study/Data/$sub/analysis/FEAT_FILES/FEAT_${run}_MV_noDis_NS.fsf
		feat /space/raid6/data/knowlton/PS_Reward_Study/Data/$sub/analysis/FEAT_FILES/FEAT_${run}_MV_noDis_S.fsf
		feat /space/raid6/data/knowlton/PS_Reward_Study/Data/$sub/analysis/FEAT_FILES/FEAT_${run}_MV_NS.fsf
		feat /space/raid6/data/knowlton/PS_Reward_Study/Data/$sub/analysis/FEAT_FILES/FEAT_${run}_MV_S.fsf
 fi
 
 done
 done
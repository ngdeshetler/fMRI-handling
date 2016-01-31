#!/bin/sh
SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 25 26 )
# 
# 24
count = 0

for sub in "${SUBS[@]}"; do

FSLDATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/$sub

#for run in 1 2 3; do
 #DATA=${FSLDATADIR}/activations/HHR_func_recall_run${run}
 DATA=${FSLDATADIR}/activations/HHR_func_MID

#pixdim_3=(`fslinfo ${DATA}.nii.gz | sed -n 9p | awk -F "pixdim3" '{print $2}' | tr -d ' '`)
#pixdim_2=(`fslinfo ${DATA}.nii.gz | sed -n 8p | awk -F "pixdim2" '{print $2}' | tr -d ' '`)
#pixdim_1=(`fslinfo ${DATA}.nii.gz | sed -n 7p | awk -F "pixdim1" '{print $2}' | tr -d ' '`)

dim_1=(`fslval ${DATA}.nii.gz dim1`)
dim_2=(`fslval ${DATA}.nii.gz dim2`)
dim_3=(`fslval ${DATA}.nii.gz dim3`)

pixdim_1=(`fslval ${DATA}.nii.gz pixdim1`)
pixdim_2=(`fslval ${DATA}.nii.gz pixdim2`)
pixdim_3=(`fslval ${DATA}.nii.gz pixdim3`)

dim_1_new=(` echo "$dim_1 / 2" | bc`)
dim_2_new=(` echo "$dim_2 / 2" | bc`)

pixdim_1_new=(` echo "$pixdim_1 * 2" | bc`)
pixdim_2_new=(` echo "$pixdim_2 * 2" | bc`)


/space/raid/fmri/fsl-5.0.7-centos6_64/bin/fslcreatehd $dim_1_new $dim_2_new $dim_3 1 $pixdim_1_new $pixdim_2_new $pixdim_3 1 0 0 0 4  \
${DATA}_reslice.nii.gz_tmp.nii.gz ; /space/raid/fmri/fsl-5.0.7-centos6_64/bin/flirt -in ${DATA}.nii.gz \
 -applyxfm -init /space/raid/fmri/fsl-5.0.7-centos6_64/etc/flirtsch/ident.mat \
 -out ${DATA}_reslice.nii.gz -paddingsize 0.0 -interp trilinear -ref ${DATA}_reslice.nii.gz_tmp
 
 
#done
done
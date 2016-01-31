#!/bin/sh

FSLDATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1
STUDYDIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/masks

for run in 1 2 3 4 5 6 7 8; do
 printf -v runnum "mm_run%d" $run
 printf -v NEWNAME "mm_run%d_reslice" $run
 RUNDIR=$FSLDATADIR/raw/$runnum
 cd $RUNDIR
 flirt -in $runnum.nii.gz -ref $FSLDATADIR/raw/mbw/mbw.nii.gz -applyxfm -init $STUDYDIR/no_move.mat -out $NEWNAME -v -interp nearestneighbour 

done
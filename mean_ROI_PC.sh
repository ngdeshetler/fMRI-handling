#!/bin/bash

DATADIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1
STATSDIR=$DATADIR/analysis
MASKDIR=/space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$1/masks

#/Native

sides=( R L )
areas=( CA1 CA3DG )
# Sub 

FEATLIST=( ${STATSDIR}/probe_test+.gfeat/cope1.feat )
# ${STATSDIR}/allRuns_output_m3_native_alt.gfeat/cope1.feat

#${STATSDIR}/probe_analysis_p1_native.gfeat/cope1.feat \
#	${STATSDIR}/probe_analysis_p2_native.gfeat/cope1.feat \
#	${STATSDIR}/cue_analysis_native.gfeat/cope1.feat 

# ${STATSDIR}/allRuns_output_m1_native.gfeat/cope1.feat \
#	${STATSDIR}/allRuns_output_m2_native.gfeat/cope1.feat
	
	

# for n in "${FEATLIST[@]}"
# do
# 	cd $n/stats
# 	
# 	echo $n
# 	
# 	PCLIST=( $(ls *_perChanges.nii.gz) )
# 	
# 	for r in "${PCLIST[@]}"
# 	do
# 	
# 		for m in "${sides[@]}"
# 		do
#  		printf -v ROI "%s/%s-%sHipp.nii.gz" $MASKDIR $1 $m
#  		
#  		IFS='_' read -r id string <<< "$r"
# 		
# 		printf -v OUT_FILE "%s_%sHipp_mean.txt" $id $m
# 		
# 		echo $OUT_FILE
# 		
# 		fslstats $r -k $ROI -M > ${OUT_FILE}	
# 		
# 		done
# 	done
# done

for n in "${FEATLIST[@]}"
do
	cd $n/stats
	
	echo $n
	
	PCLIST=( $(ls *_perChanges.nii.gz) )
	
	for r in "${PCLIST[@]}"
	do
	
		for m in "${sides[@]}"
		do
		
			for p in "${areas[@]}"
			do
 				printf -v ROI "%s/%s_%s_fixed_efTemp.nii.gz" $MASKDIR $m $p
 				#printf -v ROI "%s/%s_%s_fixed.nii.gz" $MASKDIR $m $p
 		
 				IFS='_' read -r id string <<< "$r"
		
				printf -v OUT_FILE "%s_%s%s_mean.txt" $id $m $p
		
				echo $OUT_FILE
		
				fslstats $r -k $ROI -M > ${OUT_FILE}	
			done
		done
	done
done
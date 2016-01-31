#!/bin/sh

SUBS=( 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 )
#  

sides=( right left )
sides_alt=( Right Left )
#areas=( ERC PHC PRC Fus )
#areas=( CA1 CA23DG Sub )
areas=( NAcc )
#parts=( A P )
#

# 
# 

for sub in "${SUBS[@]}"; do

	FSLDATADIR=/space/raid6/data/knowlton/PS_Reward_Study/Data/${sub}
	MASKDIR=$FSLDATADIR/masks

	SFORM="$(fslorient -getsform ${FSLDATADIR}/activations/HHR_struct.nii.gz)"
	QFORM="$(fslorient -getqform ${FSLDATADIR}/activations/HHR_struct.nii.gz)"
		

# 	for n in 0 1
# 	#"${sides[@]}"
# 	do
# 		for i in "${areas[@]}"
# 		do
# 			#for m in "${parts[@]}"
# 			#do
# 			
# 			cp $MASKDIR/${i}${sides_alt[n]}.nii.gz $MASKDIR/${sides[n]}/${i}_alt.nii.gz
# 			#_${m}
# 			#${m}_
# 			
# 			fslorient -setsform ${SFORM} $MASKDIR/${sides[n]}/${i}_alt.nii.gz
# 			#${m}_
# 			fslorient -setqform ${QFORM} $MASKDIR/${sides[n]}/${i}_alt.nii.gz
# 			#${m}_
# 			
# 			#done
# 		done
# 	done
	
	cp $MASKDIR/VTA.nii.gz $MASKDIR/VTA_alt.nii.gz
				
	fslorient -setsform ${SFORM} $MASKDIR/VTA_alt.nii.gz
	fslorient -setqform ${QFORM} $MASKDIR/VTA_alt.nii.gz	

done

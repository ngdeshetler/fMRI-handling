#!/bin/sh


SUBS=( 502 503 505 508 507 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 )
#   
model=m3_smooth_sans_preEx 
# )
#MM_525 MM_526
#  

for sub in "${SUBS[@]}"; do

sh /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/scripts/processing_bash_code/ants_featregapply_common.sh $sub $model

#sh /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/scripts/processing_bash_code/ants_featregapply_subject.sh $sub $model

done
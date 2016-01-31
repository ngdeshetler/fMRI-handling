#!/bin/bash

#setenv ASHS_ROOT /space/raid/fmri/ashs/ashs_Linux64_rev89_20120524
#source /space/raid/linux/sge-root/FUNC_Grid/common/settings.csh

SUBS=( MM_522 MM_523 MM_524 )

#MM_502 
#   MM_503 MM_505 MM_507 MM_508 MM_509 
#  MM_510 MM_511 MM_512 MM_513 MM_514 MM_515 MM_516 MM_517 MM_518 MM_519 MM_520 MM_521

for sub in "${SUBS[@]}"; do

cd /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/masks

/space/raid/fmri/ashs/ashs_Linux64_rev89_20120524/bin/ashs_main.sh \
-a /space/raid/fmri/ashs/atlas_vacind_20120314 \
-g /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/raw/mprage/mprage.nii.gz \
-f /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/$sub/raw/high_res/high_res.nii.gz \
-w ASHS -Q

done

# /space/raid/fmri/ashs/ashs_Linux64_rev89_20120524/bin/ashs_main.sh \
# -a /space/raid/fmri/ashs/atlas_vacind_20120314 \
# -g /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/mprage_temp/mprage_template.nii.gz \
# -f /space/raid6/data/rissman/Natalie/MATCH_MISMATCH/ants_reg/hires_temp/HiRes_6_template.nii.gz \
# -w ASHS -Q
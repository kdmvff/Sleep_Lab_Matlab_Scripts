pain_1 = textread('/storage/hpc/group/sleeplab/preprocessing/SPIN2_320_V1_unknown/rp_aSPIN2_320_V1_p_run1.txt')

pain_2 = textread('/storage/hpc/group/sleeplab/preprocessing/SPIN2_320_V1_unknown/rp_aSPIN2_320_V1_p_run2.txt')

pain_3 = textread('/storage/hpc/group/sleeplab/preprocessing/SPIN2_320_V1_unknown/rp_aSPIN2_320_V1_p_run3.txt')

resting_1 = textread('/storage/hpc/group/sleeplab/preprocessing/SPIN2_320_V1_unknown/rp_aSPIN2_320_V1_r_run1.txt')

resting_2 = textread('/storage/hpc/group/sleeplab/preprocessing/SPIN2_320_V1_unknown/rp_aSPIN2_320_V1_r_run2.txt')

maxval_pain1 = max(pain_1(:,:))

maxval_pain2 = max(pain_2(:,:))

maxval_pain3 = max(pain_3(:,:))

maxval_resting1 = max(resting_1(:,:))

maxval_resting2 = max(resting_2(:,:))

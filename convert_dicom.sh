#!/bin/bash

###############################
#
#	CREATED ON:		2017-10-10
#	CREATED BY:		JASON CRAGGS
#	PURPOSE:		CONVERT RAW DCM FILES TO NII FORMAT
#
#	MODIFIED ON:		2017_10_19
#  	MODIFIED ON:		2017_12_06
#       MODIFIED ON:		2019_02_20    BY Ashley Curtis (and friends)
#       MODIFIED ON:            2019-08-09
#       MODIFIED:   2020_01_20
#       Usage:			1_convert_dicom.sh [subject] [visit] [condition]
#
###############################
#
# Default subject naming convention

if [ -z $1 ] ; then 
  sub='SPIN2_013'
else
  sub=$1
fi
# Default visit naming convention
if [ -z $2 ] ; then 
  visit='V1'
else
  visit=$2
fi
# Default condition naming convention
if [ -z $3 ] ; then 
  cond='unknown'
else
  cond=$3
fi
# Set the input and output directories
# Example input file: SPIN2_001_v1

# load pigz
module load pigz/pigz-2.4

dicomData=/storage/htc/sleeplab/raw/${sub}_${visit}/
niixOutput=/storage/htc/sleeplab/preprocessing/${sub}_${visit}_${cond}/

#Create the desired output folder
mkdir $niixOutput

#Converts the Dicom to Nifti
# %p=protocol %s=series number
/storage/htc/sleeplab/software/dcm2niix-1.0.20181125/bin/dcm2niix -b y -z y -o ${niixOutput} -f ${sub}_%p_s%2s ${dicomData}

echo ${dicomData}
echo ${niixOutput}
cd ${niixOutput}

#		CREATE NEW DIRECTORY AND MOVE EXTRA FILES
mkdir -p metadata
mv *.json ./metadata

#               CREATE NEW DIRECTORY AND MOVE DTI FILES TO THAT DIRECTORY
mkdir DTI
mv ${sub}_D* ./DTI


# 		RENAMING FILES 

mv $niixOutput/${sub}_fMRI_\(Pain_1\)*.nii.gz $niixOutput/${sub}_${visit}_p_run1.nii.gz
mv $niixOutput/${sub}_fMRI_\(Pain_2\)*.nii.gz $niixOutput/${sub}_${visit}_p_run2.nii.gz
mv $niixOutput/${sub}_fMRI_\(Pain_3\)*.nii.gz $niixOutput/${sub}_${visit}_p_run3.nii.gz
mv $niixOutput/${sub}_fMRI_\(resting_1\)*.nii.gz $niixOutput/${sub}_${visit}_r_run1.nii.gz
mv ${sub}_fMRI_\(resting_2\)*.nii.gz ${sub}_${visit}_r_run2.nii.gz
mv ${sub}_t1*.nii.gz ${sub}_${visit}_t1.nii.gz


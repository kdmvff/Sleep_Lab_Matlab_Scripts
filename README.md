# PURPOSE: TO DOCUMENT THE PROCESSING STEPS OF NEUROIMAGING DATA FOR THE SLEEP LAB

# Author(s): Kevin McGovney, Jason Craggs 
#  MODIFIED:  2020_01_20


# NOTE: AS OF January 20, 2020 THE DATA HAVE BEEN MOVED TO THE HTC SERVER
# NOTE: ALL OF THE PREPEPROCESSING SCRIPTS WILL NEEED THE PATHS TO THE DATA MODIFIED.  

# The sleep lab group has the following major directories: raw, preprocessing, preprocessed, software, and Psychometric.


# RAW

# This directory contains all of the raw MRI files for SPIN2 and SPINCWP. Every participant visit has a unique folder (i.e. if the participant had multiple visits, they will have a folder for each visit). Every visit folder contains the MRI and thermal data for that visit. The MRI data is in DICOM format, and the thermal data is in an excel file.

# We export MRI files as enhanced DICOM files, and we need to ensure that they are not deidentified

# The naming convention for SPIN2 is SPIN2_xxx_V1

# The naming convention for SPINCWP is SPxxx_Visit_1

# PREPROCESSING

# This directory contains all of the MRI files that have additional pre-processing steps to be performed. Once all pre-processing steps are performed on an MRI file, the participant folder should be moved to PREPROCESSED.

# Every MRI file in this directory should be a .nii. The first script (see PSYCHOMETRIC folder) converts the raw DICOM MRI data to compressed niifti files (.nii.gz). 

# If the dicom2niix script worked correctly, a folder will be created for each participant that contains the following example files: SPIN2_359_gre_field_mapping_s11_ph.nii.gz, SPIN2_359_SAG_T2_SPACE_s03.nii.gz, SPIN2_359_V1_p_run1.nii.gz,  SPIN2_359_V1_p_run2.nii.gz, SPIN2_359_V1_p_run3.nii.gz, SPIN2_359_V1_r_run1.nii.gz, SPIN2_359_V1_r_run2.nii.gz, SPIN2_359_V1_t1.nii.gz

# If the dicom2niix script did not work successfully, then these files will not appear as shown above. They may appear as DEIDENTIFIED, in which case they need to re-exported immediately from Radiology.





# PREPROCESSED

# This folder contains all of the MRI files from the visits that have gone through the entirety of the preprocessing steps.




# PSYCHOMETRIC

# This directory contains all of the scripts required to process the data.

# The scripts will be in the subfolder "AUTOMATED PROCESSING"

# SPIN2 SCRIPTS

# Basic order of scripts: "convert_dicom.sh", "Mc_step2_preprocessing.m", "Mc_step2_2_maxvals.m", "Mc_step3_norm123.m".


# SCRIPT 1

# Name: "convert_dicom.sh"

# Description: This script takes a raw DICOM file in the RAW folder, converts it to .nii format, compresses the file, and places the .nii files in a new folder in PREPROCESING

# The script can be ran from any directory with the absolute path name, followed by the SPIN2 ID, the visit #, and the treatment assignment.

# Note, the treatment assignment can be re-specified later, so it is not essential to include in the script.

# The script will assume that the visit is V1 if not otherwise specified, and it will assume an unknown treatment assignment

# Command: "/storage/hpc/group/sleeplab/Psychometric/automated_processing/convert_dicom.sh SPIN2_xxx V2"

# The above command runs the 1st script on SPIN2_xxx in RAW, and specifies the visit as visit 2


# SCRIPT 2

# Open MATLAB to run the following commands

# To obtain a MATLAB license on lewis, run the following command:
# "srun --pty -p Interactive -c2 --mem 8G --time=4:00:00 --licenses=matlab:1 /bin/bash"

# Open MATLAB with the following command: "module load matlab/matlab-R2018b;matlab"

# Navigate to the directory of the automated processing folder in MATLAB

# enter "Mc_step2_preprocessing.m", and allow it to run through all of the steps. If there is an error, then there is likely a problem with the .nii file or its name
# This script does
1. Sets path of files to be processed
2. Gets subject list
3. anat pattern 
4. functional pattern
5. number of runs
6. numbers of volumes, slices and TR of the fMRI scans
7. slice order
8. reslices to voxel size of 2mm
9. specifies the bounding box of the data
10. set smoothing kernel of epi data (set at 6mm)
11. compute time to acquisition
12. find subjects in root folder
13. create subject list of all the files in the group path
14. for loop to do all the following
- set primary path
- gzips all the files
- locates the corrects files
- checks to make sure the correct number of files are present
- checks the number of slices
- converts the data to float 32 to reduce precision loss
- smooths structural (FWHM 12mm)
- coregister the smoothed structural to the old T1 template
- segments the structural 
- normalizes the segmented files to the T1 template
- skull strips the segmented structural files
- generates functional file names
- corrects slice timing of functional
- motion correction and realignment
- smooths the mean functional image
- coregisters the functional to the epi template
- coregisters the functional to the T1 (this is done so the anat file can be overlaid on the functional files)
- normalizes the epi data to MNI
- smooth the epi data (FWHM 6mm)
####### END OF SCRIPT


 

# SCRIPT 3
NOTE: This script was used prior to the Atlanta trip to identify excessive motion  
NOTE: After the Atlanta trip we will use the ART toolbox (as of January 16, 2020 = WIP)

# Description: Determines the maximum value of motion for all 5 functional scans. Must be ran 1 participant visit at a time.

# We want to determine the maximum values of motion for all motion parameters (x, y, z, pitch, roll, yaw) for every functional scan. 

# This script is a little clunky, and could be made simpler by specifying particpant ID as a variable in MATLAB

# Open the script "Mc_step2_2_maxvals.m", and change the participant ID and visit to the desired participant every time the participant ID appears in the script.

# The script should produce the maximum value of motion for x, y, z, pitch, roll, and yaw for each of the 5 functional scans.

# If motion for any paramter exceeds 3, then flag this ID and wait to run additional analyses.



# SCRIPT 4

# Description: Normalizes all of the files in PREPROCESSING
# In matlab, navigate to the automated processing directory and run " Mc_step3_norm123.m"





# SOFTWARE

# This folder contains all of the dependencies for software. It contains the toolboxes for Matlab. If a new toolbox is added to SOFTWARE, it must also be added to the PATH in Matlab in order to use the toolbox.


# THERMAL DATA (PROCESSING)

# The thermal data exists in RAW. There should be 3 files for each participant (1 for each functional pain scan)

# It is necessary to determine the timestamp of each initial stimulus for each pain run (there are 16 initial stimuli for each pain run).

# Initial stimuli is defined as the time in miliseconds from the start of the scan when the temperature first reaches the destination tempe
# rature. Again, this happens 16 times each scan.

# We also want to determine the duration of each stimulus (i.e. for how long did the participant experience each stimulus?)

# The duration of each stimulus should be approximately 5 seconds

# An excel sheet with a macro is created and exists in PREPROCESSED/SPIN2_thermal

# The macro is able to determine the initial stimuli and duration of each of these files 1 at a time.

# The macro is in sheet 1 of the excel sheet, and the instructions for the macro are in sheet 2 of the excel sheet.

# The timestamped initial stimuli and duration of scan are then pasted into wide format in PREPROCESSED/SPIN2_thermal/Thermal_inital_stimul
# i.xlsx

# In the file with timestamps, b_p1_1 is an abbreviation for baseline, pain 1 , stimulus 1

# Similary p_p2_6 would be post, pain 2, stimulus 6,


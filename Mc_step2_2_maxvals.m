
% Specify the subject name

% SPIN2 Example = 'SPIN2_011_V1'

% SPIN-CWP Example = 'SP076_Visit_1'

subject = 'SP021_Visit_1'

% The remaining variables are static variables

file_part_1 = '/storage/hpc/group/sleeplab/preprocessing/'

file_part_2 = '/rp_a'

file_part_3 = '_p_run1.txt'

file_part_4 = '_p_run2.txt'

file_part_5 = '_p_run3.txt'

file_part_6 = '_r_run1.txt'

file_part_7 = '_r_run2.txt'

p1_filename = strcat(file_part_1,subject,file_part_2,subject,file_part_3)

p2_filename = strcat(file_part_1,subject,file_part_2,subject,file_part_4)

p3_filename = strcat(file_part_1,subject,file_part_2,subject,file_part_5)

r1_filename = strcat(file_part_1,subject,file_part_2,subject,file_part_6)

r2_filename = strcat(file_part_1,subject,file_part_2,subject,file_part_7)

pain_1 = textread(p1_filename)

pain_2 = textread(p2_filename)

pain_3 = textread(p3_filename)

resting_1 = textread(r1_filename)

resting_2 = textread(r2_filename)

% Maxvals returns the maximum motion for all 6 parameters
% (x,y,z,pitch,roll,and yaw)

% Maxval (singular) returns the overall maximum value of all 6 parameters

% We are going to check if any exceed 3

maxvals_pain1 = max(pain_1(:,:))

maxval_p1 = max(maxvals_pain1)

maxvals_pain2 = max(pain_2(:,:))

maxval_p2 = max(maxvals_pain2)

maxvals_pain3 = max(pain_3(:,:))

maxval_p3 = max(maxvals_pain3)

maxvals_resting1 = max(resting_1(:,:))

maxval_r1 = max(maxvals_resting1)

maxvals_resting2 = max(resting_2(:,:))

maxval_r2 = max(maxvals_resting2)

all_maximum_values = [maxval_p1,maxval_p2,maxval_p3,maxval_r1,maxval_r2]

absolute_maximum = max(all_maximum_values)
 
if maxval_p1 >3
    fprintf('Pain 1 motion is greater than 3')
elseif maxval_p2 >3
    fprintf('Pain 2 motion is greater than 3')
elseif maxval_p3 >3
    fprintf('Pain 3 motion is greater than 3')
elseif maxval_r1 >3
    fprintf('Resting 1 motion is greater than 3')
elseif maxval_r2 >3
    fprintf('Resting 2 motion is greater than 3')
else
    fprintf('No Motion Issues for this file')
end
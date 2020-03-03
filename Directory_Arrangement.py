import os
# os.listdir() will give you everything that's in a directory - files and directories
from os import listdir
from os import path
import shutil
import glob

# Creates a list of directories
dir_list = os.listdir("/storage/htc/sleeplab/preprocessed")

path = "/storage/htc/sleeplab/preprocessed"

for directory in dir_list:

    # If subject is from SPIN2, this will differentiate the subject from SPINCWP, create a new directory that is just the subject ID
    # The new directory will not include the visit number.
   
    if directory[2] == "I":
        ID = directory[0:9]
        new_directory= os.path.join(path,ID)

    # If the Subject ID (e.g. SPIN2_013) already exists, it will move any sessions (e.g. SPIN2_013_V2, SPIN2_013_V3) to the subject ID directory

        if os.path.isdir(new_directory):
            shutil.move(directory,new_directory)

    # If the Subject ID (e.g. SPIN2_013) does not exist, it will create the directory and move sessions to that directory

        else: 
            os.mkdir(ID)
            shutil.move(directory,new_directory)


    # If subject is from SPINCWP the format will be (SPxxx)
    # This code will differentiate the subject from SPIN2 by noting that the first character is "S" 3rd character is not "I"
    elif directory[0] == "S" and directory[2] !="I":
        ID = directory[0:5]
        new_directory= os.path.join(path,ID)

    # If the Subject ID (e.g. SP100) already exists, it will move any sessions (e.g. SP100_Visit_2) to the subject ID directory

        if os.path.isdir(new_directory):
            shutil.move(directory,new_directory)

    # If the Subject ID (e.g. SP100) does not exist, it will create the directory and move sessions to that directory
        else: 
            os.mkdir(ID)
            shutil.move(directory,new_directory)


     



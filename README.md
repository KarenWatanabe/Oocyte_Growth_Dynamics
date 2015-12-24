# Oocyte_Growth_Dynamics
A computational model for oocyte growth dynamics in fish

This version of the Oocyte Growth Dynamics Model simulates multiple batches of oocytes growing in a user-specified number of fathead minnows.  A simulation represents one fish, and the number of batches of oocytes simulated will depend upon the length of the simulation.  It was used to perform the simulations in a paper by Watanabe et al., 'Predicting fecundity of fathead minnows (Pimephales promelas) exposed to endocrine-disrupting chemicals using a MATLAB(R)-based model of oocyte growth dynamics.'

There is a graphical user interface (GUI) which should make running the model somewhat intuitive. You will need to input the number of simulations to run, simulation length, fish identification numbers/names (alphanumeric entries allowed) and plasma vitellogenin concentrations (nmol/uL).  The model has a start-up period of 80 days with a default plasma vitellogenin concentration of 0.1 nmol/uL (t = -80 to 0 days), then uses the user-specified plasma VTG concentration for times  > 0 (t = 1 to user specified simulation length in days).

Sample input data files are provided in the SampleInputFiles folder so that you can test the 'Upload Data' feature, though data can be entered manually through the GUI by choosing the 'EnterData' button.

Model output is provided in OGDM_ResultsSummary_#.txt, where # represents the nth fish simulated.  The ResultsSummary files include spawn times, clutch sizes, spawn intervals, and total number of eggs spawned.  Additional output files include: OGDM_ClutchSizeSummary.txt and OGDM_SpawningSummary.txt.  Output files are written to the directory where the OGDM application is located.

Instructions to Run the Oocyte Growth Dynamics Model

In each platform (e.g., Mac, PC) folder, you will find a *_pkg.zip file and a  *_distrib folder.
 
The*_pkg.zip file contains  the Oocyte Growth Dynamics Model application and a Matlab Compiler Runtime (MCR) installer for users who don't have a working Matlab license, or a Matlab version older than R2012b. If you have Matlab 2012b installed on your computer, you only need the contents of the *_distrib folder for your operating system (e.g., Mac, PC). Follow instructions in the readme.txt file to install the MCR.

To run OGDM_v3 follow the platform-specific instructions below:

Mac (64-bit Mac OS X v. 10.6.8):
OGDM_v3 writes to standard output, so it must be run from a Terminal window.
Open a Terminal window and change to the directory where the OGDM_v3.app is located.
After installing MCR v8.0, run the OGDM*.sh file with the location of the MCR files (<mcr_directory> in command below; the final directory in the MCR path will be 'v80')
  > ./run_OGDM_v3.sh <mcr_directory>

Note: There may be a short delay before the OGDM GUI opens.

PC (Windows XP 32-bit):
After installing MCR v. 8.0, open a Command Prompt window
Change directories to the directory where OGDM_v2PC.exe is located.  At the command prompt type
    > OGDM_v3PC.exe

Note: There may be a short delay before the OGDM GUI opens.

# Oocyte_Growth_Dynamics
A computational model for oocyte growth dynamics in fish

This version of the Oocyte Growth Dynamics Model (OGDM) simulates multiple batches of oocytes growing in a user-specified number of fathead minnows.  A simulation represents one fish, and the number of batches of oocytes simulated will depend upon the length of the simulation.  It was used to perform the simulations in a paper by Watanabe et al., 'Predicting fecundity of fathead minnows (Pimephales promelas) exposed to endocrine-disrupting chemicals using a MATLAB(R)-based model of oocyte growth dynamics.'

There is a graphical user interface (GUI) which should make running the model somewhat intuitive. You will need to input the number of simulations to run, simulation length, fish identification numbers/names (alphanumeric entries allowed) and plasma vitellogenin concentrations (nmol/uL).  The model has a start-up period of 80 days with a default plasma vitellogenin concentration of 0.1 nmol/uL (t = -80 to 0 days), then uses the user-specified plasma VTG concentration for times  > 0 (t = 1 to user specified simulation length in days).

Sample input data files are provided in OGDMInputData_Watanabe_etal_2015.zip so that you can test the 'Upload Data' feature, though data can be entered manually through the GUI by choosing the 'EnterData' button.

Model output is provided in OGDM_ResultsSummary_#.txt, where # represents the nth fish simulated.  The ResultsSummary files include spawn times, clutch sizes, spawn intervals, and total number of eggs spawned.  Additional output files include: OGDM_ClutchSizeSummary.txt, OGDM_SpawningSummary.txt, and OGDM_OocMassVol.csv.  Output files are written to the directory where the OGDM application is located.

The source code provided here runs in MATLAB 2012b; the graphical user interface does not render properly in MATLAB 2015a, but will be updated soon.  Please contact Dr. Karen Watanabe (watanabk@ohsu.edu) if you do not have a MATLAB license and would like a copy of the executable version of the OGDM.

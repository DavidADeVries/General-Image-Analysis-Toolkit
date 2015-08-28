General Image Analysis Toolkit (GIANT)
New Module Manual

What is contained within this folder are all the folders and files you need to get your next GIANT module off the ground. All the files and figures are currently configured into a working example, so feel free to run GIANT_BASE.m to see what the base functionality of GIANT looks like. It is up to you to take this base and make into the module you desire.
The files (classes and functions) you must provide to GIANT are:

-> Classes:
    ->  CacheEntry.m
    ->  <YourFileTypeNameHere.m> [must inherit from File.m; do not have to define if not needed]
        -> must provide function: isValid = isValidForExport(file)
    ->  <YourPatientTypeNameHere.m> [must inherit from Patient.m; do not have to define if not needed]

-> CSV Export Functions:
    ->  [ values ] = getExportValues(patient, study, series, file, sequenceNumber)
    ->  [ header ] = getHeader()
    ->  [] = printToFile(fileId, lineNumber, values, newline, delim)
    ->  [ values ] = setFields(cellValues)

-> Draw Functions
    ->  [ handles ] = drawAll(currentFile, handles, hObject)
    ->  [ handles ] = emptyDisplayHandles(handles)

-> Patient and File Functions
    ->  [ file ] = createFile(imageFilename, dicomInfo, imagePath, image)
    ->  [ patient ] = createPatient(patientId, studies)
    ->  [ file ] = emptyFile()
    ->  [ patient ] = emptyPatient(varargin)

->  Update GUI
    ->  [] = disableAllToggles(handles)
    ->  [] = updateGui(currentFile, handles)
    ->  [] = updateGuiForSeriesImageChange(currentFile, handles)
    ->  [] = updateGuiForUndoRedo(currentFile, handles)
    ->  [] = updateToggleButtons(handles)

All of these classes/functions have already been made and are contained within the subfolders of there directories. Simply change them to fit your needs.
It is also recommended to rename the GIANT_BASE.fig and GIANT_BASE.m files to reflect your module name, such as GAS_SAM.fig and GAS_SAM.m
When you do this not that you may have to do some find and replaces in the .m file as well re-generate all the callbacks in the .fig file. And don't worry about trying to find all the callbacks by yourself, because it'll throw errors until you get them, trust me :)
Once you're done that, you can start adding your own UI elements and callbacks to build up your module!

In the working directory of any study that uses your new module you must provide these two files, usually in a folder called 'Code Files':

-> Constants.m [see example file for what constants must be defined]
-> HighLevelConstants.m [see example file for what constants must be defined]

These files must be added to the path in the BOOT.m file (see example). The path to the folder these files are in is passed as a parameter to BOOT, so to startup this example module we would use the command:

BOOT('../Example Study/Code Files');

The BOOT function takes care of adding in all necessary folders/files to the path, and then ends off by starting up the GUI.

Good luck!
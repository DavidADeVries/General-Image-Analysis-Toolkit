function [  ] = giantOpen(hObject, handles)
%[  ] = giantOpen(hObject, handles)
% for any module in GIANT, this will open a saved patient
% 
% Required functions:
%   updateGui(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:
%   Constants.SAVED_PATIENTS_DIRECTORY

allowedFileOptions = {...
    '*.mat','Patient Analysis Files (*.mat)'};
popupTitle = 'Select Patient Analysis Files';
startingDirectory = Constants.SAVED_PATIENTS_DIRECTORY;

[imageFilename, imagePath, ~] = uigetfile(allowedFileOptions, popupTitle, startingDirectory);

if imageFilename ~= 0 %user didn't click cancel!
    completeFilepath = strcat(imagePath, imageFilename);
    
    openCancelled = false;
    
    % load previous analysis file .mat
    loadedData = load(completeFilepath);
    
    patient = loadedData.patient;
    
    [patientNum, ~] = findPatient(handles.patients, patient.patientId);
    
    if patientNum == 0 % create new
        handles.numPatients = handles.numPatients + 1;
        patientNum = handles.numPatients;
    else %overwrite whatever patient with the same id was there before
        openCancelled = overwritePatientDialog(); %confirm with user that they want to overwrite
    end
    
    if ~openCancelled        
        handles.currentPatientNum = patientNum;
        
        currentFile = patient.getCurrentFile();
        
        handles = updatePatient(patient, handles);
        
        %update Gui
        updateGui(currentFile, handles);
        
        handles = drawAll(currentFile, handles, hObject);        
        
        % pushup changes
        guidata(hObject, handles);
    end
    
end

end


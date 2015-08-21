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

[imageFilenames, imagePath, ~] = uigetfile(allowedFileOptions, popupTitle, startingDirectory, 'MultiSelect', 'on');

if ~isa(imageFilenames, 'double') %user didn't click cancel! (0 returned for cancel)
    if ~iscell(imageFilenames)
        imageFilenames = {imageFilenames};
    end
    
    numFiles = length(imageFilenames);
    
    if numFiles == 1
        message = 'opening patient file.';
    else
        message = 'opening patient files.';
    end
    
    pleaseWaitHandle = pleaseWaitDialog(message);
    
    for i=1:length(imageFilenames)
        completeFilepath = strcat(imagePath, imageFilenames{i});
        
        openCancelled = false;
        
        error = false;
        
        % load previous analysis file .mat
        
        try
            loadedData = load(completeFilepath);
        catch
            error = true;
        end
        
        if ~error
            patient = loadedData.patient;
            
            [patientNum, ~] = findPatient(handles.patients, patient.patientId);
            
            if patientNum == 0 % create new
                handles.numPatients = handles.numPatients + 1;
                patientNum = handles.numPatients;
            else %overwrite whatever patient with the same id was there before
                openCancelled = overwritePatientDialog(patient.patientId); %confirm with user that they want to overwrite
            end
            
            if ~openCancelled
                handles.currentPatientNum = patientNum;
                
                currentFile = patient.getCurrentFile();
                
                handles.currentImage = currentFile.getImage();
                
                patient.savePath = completeFilepath; % this may change if some saves the patient, moves it using the OS, and then reopens it later. We wouldn't want the savePath pointing somewhere else
                
                handles = updatePatient(patient, handles);
                
                %update Gui
                updateGui(currentFile, handles);
                
                handles = drawAll(currentFile, handles, hObject);
                
                % pushup changes
                guidata(hObject, handles);
            end
        else
            message = ['An error occurred when trying to open the saved patient data at ', completeFilePath];
            icon = 'error';
            title = 'Open Error';
            
            waitfor(msgbox(message, title, icon));
        end
    end
    
    delete(pleaseWaitHandle);
end

end


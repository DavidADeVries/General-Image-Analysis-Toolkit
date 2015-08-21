function [ ] = giantImportPatientDirectory(hObject, handles)
%[ ] = giantImportPatientDirectory(hObject, handles)
% for any module from GIANT, this function will import a directory into a
% patient structure
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%   createPatient(patientId, studies)
%
% Required constants:

folderPath = uigetdir(Constants.RAW_DATA_DIRECTORY, 'Select Patient Directory');

if folderPath ~= 0 %didn't click cancel
    len = length(Constants.ROOT_PATH);
    
    if (length(folderPath) >= len) && strcmp(folderPath(1:len), Constants.ROOT_PATH) % must get data from within the root path, or else proper file references for the images will likely get disrupted
        
        waitHandle = pleaseWaitDialog('importing directory.');
        
        [studies, patientId] = createStudies(folderPath); %recursively creates studies, containing series, containing files (dicoms)
        
        if ~isempty(patientId) %if empty, there must have been no files contained in the directories given
            [patientNum, ~] = findPatient(handles.patients, patientId); %see if the patient already exists
            
            openCancelled = false;
            
            if patientNum ~= 0 %ask user if they want to overwrite whatever patient with the same id was there before
                openCancelled = overwritePatientDialog(patientId); %confirm with user that they want to overwrite
            else
                handles.numPatients = handles.numPatients + 1;
                patientNum = handles.numPatients;
            end
            
            if ~openCancelled %is not cancelled, assign new patient
                handles.currentPatientNum = patientNum;
                
                patient = createPatient(patientId, studies);
                
                patient = patient.sortStudies();
                
                patient.changesPending = true;
                
                handles = updatePatient(patient, handles);
                
                currentFile = getCurrentFile(handles);
                
                handles.currentImage = currentFile.getImage();
                
                %update view
                updateGui(currentFile, handles);
                
                handles = drawAll(currentFile, handles, hObject);
                
                %push up changes
                
                guidata(hObject, handles);
            end
        end
        
        delete(waitHandle);
    else
        invalidDirectoryDialog();
    end
end

end


function [ ] = giantAddPatient(hObject, handles)
%[ ] = giantAddPatient(hObject, handles)
% for any module from GIANT, this function will let the user add a custom
% patient
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%   createPatient(patientId, studies)
%
% Required constants:

patientId = patientIdDialog();

if ~isempty(patientId) %empty means user pressed cancel, do nothing
    [patientNum, ~] = findPatient(handles.patients, patientId); %see if the patient already exists
    
    openCancelled = false;
    
    if patientNum ~= 0 %ask user if they want to overwrite whatever patient with the same id was there before
        openCancelled = overwritePatientDialog(); %confirm with user that they want to overwrite
    else
        handles.numPatients = handles.numPatients + 1;
        patientNum = handles.numPatients;
    end
    
    if ~openCancelled %is not cancelled, assign new patient
        handles.currentPatientNum = patientNum;   
        
        newPatient = createPatient(patientId, Study.empty);
        newPatient.changesPending = true;
        
        handles = updatePatient(newPatient, handles); %will automatically set newPatient into current patient spot
        
        currentFile = getCurrentFile(handles);
        
        handles.currentImage = currentFile.getImage();
        
        %update GUI
        updateGui(currentFile, handles);
        
        %draw new image
        handles = drawAll(currentFile, handles, hObject);
        
        %push up changes
        guidata(hObject, handles);
    end
end


end


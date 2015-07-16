function [ ] = giantSaveAll(hObject, handles)
%[ ] = giantSaveAll(hObject, handles)
% for any module from GIANT, this function will save all the patients that
% are open
%
% Required functions:
%   updateToggleButtons(handles)
%
% Required constants:

cachedCurrentPatientNum = handles.currentPatientNum;

for i=1:handles.numPatients
    handles.currentPatientNum = i;
    
    currentFile = getCurrentFile(handles);
    
    handles.currentImage = currentFile.getImage();
    
    %GUI updated
    updateGui(currentFile, handles);
    
    %displayed imaged updated
    handles = drawAll(currentFile, handles, hObject);    
    
    patient = handles.patients(i).saveToDisk();
        
    handles = updatePatient(patient, handles, i);    
end

handles.currentPatientNum = cachedCurrentPatientNum;

currentFile = getCurrentFile(handles);
    
handles.currentImage = currentFile.getImage();

%GUI updated
updateGui(currentFile, handles);

%displayed imaged updated
handles = drawAll(currentFile, handles, hObject);

%push back changes
guidata(hObject, handles);

end


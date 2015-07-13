function [ ] = giantClosePatient(hObject, handles)
%[ ] = giantClosePatient(hObject, handles)
% for any module from GIANT, this function will close the current patient
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

currentPatient = getCurrentPatient(handles);

closeCancelled = false;
saveFirst = false;

if currentPatient.changesPending;
    [closeCancelled, saveFirst] = pendingChangesDialog(); %prompts user if they want to save unsaved changes
end

if ~closeCancelled
    if saveFirst %user chose to save
        currentPatient.saveToDisk();
    end
    
    handles = removeCurrentPatient(handles); %patient removed from patient list
    
    currentFile = getCurrentFile(handles);
    
    %GUI updated
    updateGui(currentFile, handles);
    
    %displayed imaged updated
    handles = drawAll(currentFile, handles, hObject);
    
    %push up changes
    guidata(hObject, handles);  
end


end


function [ closeCancelled, handles ] = closePatient(hObject, handles)
%[ closeCancelled, handles ] = closePatient(hObject, handles)
% closes the current patient, prompting user to save or cancel if needed
% returns if the user pressed cancelled or not, as well as the updated
% handles to pushed back to the hObject
%
% Required functions:
%   updateGui(currentFile, handles)
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
    
    handles.currentImage = currentFile.getImage();
    
    %GUI updated
    updateGui(currentFile, handles);
    
    %displayed imaged updated
    handles = drawAll(currentFile, handles, hObject);
end

end


function [ ] = giantRemoveFile(hObject, handles)
%[ ] = giantRemoveFile(hObject, handles)
% for any module from GIANT, this function will go remove the current file
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

question = 'Are you sure you want to remove the current file? This cannot be undone!';
title = 'Remove Current File';

cancelled = confirmRemoveDialog(question, title);

if ~cancelled    
    currentPatient = getCurrentPatient(handles);
    
    currentPatient = currentPatient.removeCurrentFile(); 
    
    currentPatient.changesPending = true;
    
    handles = updatePatient(currentPatient, handles);    
    currentFile = currentPatient.getCurrentFile();
    
    handles.currentImage = currentFile.getImage();
    
    %GUI updated
    updateGui(currentFile, handles);
    
    %displayed imaged updated
    handles = drawAll(currentFile, handles, hObject);
    
    %push up changes
    guidata(hObject, handles);  
end

end


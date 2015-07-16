function [ ] = giantRemoveStudy(hObject, handles)
%[ ] = giantRemoveStudy(hObject, handles)
% for any module from GIANT, this function will remove the current study
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

question = 'Are you sure you want to remove the current study and all contained series and files? This cannot be undone!';
title = 'Remove Current Study';

cancelled = confirmRemoveDialog(question, title);

if ~cancelled
    currentPatient = getCurrentPatient(handles);
    
    currentPatient = currentPatient.removeCurrentStudy();
    currentPatient.changesPending = true;
    
    handles = updatePatient(currentPatient, handles);
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


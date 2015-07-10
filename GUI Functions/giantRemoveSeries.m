function [ ] = giantRemoveSeries(hObject, handles)
%[ ] = giantRemoveSeries(hObject, handles)
% for any module from GIANT, this function will go to the latest image in
% a series
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

question = 'Are you sure you want to remove the current series and all contained files? This cannot be undone!';
title = 'Remove Current Series';

cancelled = confirmRemoveDialog(question, title);

if ~cancelled
    currentPatient = getCurrentPatient(handles);
    
    currentPatient = currentPatient.removeCurrentSeries();
    currentPatient.changesPending = true;
    
    handles = updatePatient(currentPatient, handles);
    currentFile = getCurrentFile(handles);
    
    %update GUI
    updateGui(currentFile, handles);
    
    %draw new image
    handles = drawAll(currentFile, handles, hObject);
    
    %push up changes
    guidata(hObject, handles);
end

end


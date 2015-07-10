function [ ] = giantAddSeries(hObject, handles)
%[ ] = giantAddSeries(hObject, handles)
% for any module from GIANT, this function will allow the user to create a
% custom series
%
% Required functions:
%   emptyFile()
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

seriesName = seriesNameDialog();

if ~isempty(seriesName) %empty means user pressed cancel, do nothing
    currentPatient = getCurrentPatient(handles);

    newSeries = Series(seriesName, emptyFile());
    
    currentPatient = currentPatient.addSeries(newSeries);
    
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


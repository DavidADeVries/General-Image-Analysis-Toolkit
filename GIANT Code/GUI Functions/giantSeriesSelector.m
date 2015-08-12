function [ ] = giantSeriesSelector(hObject, handles)
%[ ] = giantSeriesSelector(hObject, handles)
% for any module from GIANT, this function is called when the series
% selector is changed
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

currentPatient = getCurrentPatient(handles);

currentPatient = currentPatient.setCurrentSeriesNum(get(hObject,'Value'));
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


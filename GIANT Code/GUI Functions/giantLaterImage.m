function [ ] = giantLaterImage(hObject, handles)
%[ ] = giantLaterImage(hObject, handles)
% for any module from GIANT, this function will go to the later image in
% a series
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

currentPatient = getCurrentPatient(handles);

currentPatient = currentPatient.laterImage();

currentPatient.changesPending = true;

handles = updatePatient(currentPatient, handles);

currentFile = getCurrentFile(handles);

handles.currentImage = currentFile.getImage();

%update GUI
updateGuiForSeriesImageChange(currentFile, handles);

%draw new image
handles = drawAll(currentFile, handles, hObject);

%push up changes
guidata(hObject, handles);

end


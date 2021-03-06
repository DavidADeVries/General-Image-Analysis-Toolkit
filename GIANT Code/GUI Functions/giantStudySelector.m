function [ ] = giantStudySelector(hObject, handles)
%[ ] = giantStudySelector(hObject, handles)
% for any module from GIANT, this function is called when the study
% selector is changed
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

currentPatient = getCurrentPatient(handles);

currentPatient.currentStudyNum = get(hObject,'Value');
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


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

handles = updatePatient(currentPatient, handles);

currentFile = getCurrentFile(handles);

%update GUI
updateGui(currentFile, handles);

%draw new image
handles = drawAll(currentFile, handles, hObject);

%push up changes
guidata(hObject, handles);


end


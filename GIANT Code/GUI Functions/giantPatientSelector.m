function [ ] = giantPatientSelector(hObject, handles)
% [ ] = giantPatientSelector(hObject, handles)
% for any module from GIANT, this function is triggered when the patient
% selector is changed
%
% Required functions:
%   updateGui(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

handles.currentPatientNum = get(hObject,'Value');

currentFile = getCurrentFile(handles);

%update GUI
updateGui(currentFile, handles);

%draw new image
handles = drawAll(currentFile, handles, hObject);

%push up changes
guidata(hObject, handles);

end


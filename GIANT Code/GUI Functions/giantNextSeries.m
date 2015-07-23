function [ ] = giantNextSeries(hObject, handles)
%[ ] = giantNextSeries(hObject, handles)
% for any module from GIANT, this function will go to the next series
% in a study
%
% Required functions:
%   updateGui(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

currentPatient = getCurrentPatient(handles);

currentPatient = currentPatient.nextSeries();

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


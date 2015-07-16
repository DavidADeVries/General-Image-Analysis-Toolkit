function [ ] = giantOpeningFcn(hObject, handles)
%giantOpeningFcn(hObject, handles)
% for any module from GIANT, this function should be run in the OpeningFcn
% callback
%
% Required functions:
%   updateGui(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%   emptyPatient()
%   emptyFile()
%   emptyDisplayHandles(handles)
%
% Required constants:

handles.output = hObject;

handles.numPatients = 0; %records the number of images that are currently open
handles.currentPatientNum = 0; %the current image being displayed
handles.updateUndoCache = false; %tells upclick listener whether or not to save undo data

handles.patients = emptyPatient();

handles.currentImage = [];

% empty handle structures
handles = emptyDisplayHandles(handles);


%clear axes

axes(handles.imageAxes);
imshow([],[]);
cla(handles.imageAxes); % clear axes

updateGui(emptyFile(), handles);

% Update handles structure
guidata(hObject, handles);

end


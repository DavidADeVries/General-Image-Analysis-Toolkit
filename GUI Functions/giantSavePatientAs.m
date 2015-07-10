function [ ] = giantSavePatientAs(hObject, handles)
%[ ] = giantSavePatientAs(hObject, handles)
% for any module from GIANT, this function will allow the user to save the
% current patient into a new file
%
% Required functions:
%   updateToggleButtons(handles)
%
% Required constants:

currentPatient = getCurrentPatient(handles);

currentPatient.savePath = ''; %clear it so that it will be redefined (save as)

currentPatient = currentPatient.saveToDisk();

handles = updatePatient(currentPatient, handles);

updateToggleButtons(handles);

guidata(hObject, handles);

end


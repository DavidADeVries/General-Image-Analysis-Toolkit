function [ ] = giantSavePatient(hObject, handles)
%[ ] = giantSavePatient(hObject, handles)
% for any module from GIANT, this function will save the patient to disk
%
% Required functions:
%   updateToggleButtons(handles)
%
% Required constants:

currentPatient = getCurrentPatient(handles);

currentPatient = currentPatient.saveToDisk();

handles = updatePatient(currentPatient, handles);

updateToggleButtons(handles);

guidata(hObject, handles);

end


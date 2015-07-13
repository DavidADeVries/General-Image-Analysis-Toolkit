function [ ] = giantSaveAll(hObject, handles)
%[ ] = giantSaveAll(hObject, handles)
% for any module from GIANT, this function will save all the patients that
% are open
%
% Required functions:
%   updateToggleButtons(handles)
%
% Required constants:

for i=1:handles.numPatients
    patient = handles.patients(i).saveToDisk();
        
    handles = updatePatient(patient, handles, i);    
end

updateToggleButtons(handles);

guidata(hObject, handles);

end


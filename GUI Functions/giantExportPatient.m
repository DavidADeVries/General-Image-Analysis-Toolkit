function [ ] = giantExportPatient(hObject, handles)
%[ ] = giantExportPatient(hObject, handles)
% for any module from GIANT, this function will export all patient to csv

exportPatients(getCurrentPatient(handles));

end


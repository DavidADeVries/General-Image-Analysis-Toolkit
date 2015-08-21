function [ openingCancelled ] = overwritePatientDialog(patientId)
%overwritePatientDialog when opening a saved patient and than patient is
%already open, the user is asked if they want to overwrite the patient or
%not

openingCancelled = true;

question = ['The patient ', patientId, ' is already open in your workspace, but you are trying to load the same patient from a saved file. Do you wish to replace the open patient with the copy from the file?'];
            
overwrite = 'Replace';
cancel = 'Don''t Replace';

default = overwrite;

choice = questdlg(question, 'Patient Conflict', overwrite, cancel, default);

switch choice
    case overwrite
        openingCancelled = false;
    case cancel
        openingCancelled = true;
end

end


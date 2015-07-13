function [  ] = giantCloseAllPatients( hObject, handles )
%[  ] = giantCloseAllPatients( hObject, handles )
% for any module from GIANT, this function will close all the patients
%
% Required functions:
%   updateGui(currentFile, handles)
%   emptyPatient()
%   emptyFile()
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

for i=1:handles.numPatients
    patient = handles.patients(i);
    
    closeCancelled = false;
    saveFirst = false;
    
    if patient.changesPending;
        [closeCancelled, saveFirst] = pendingChangesDialog(); %prompts user if they want to save unsaved changes
    end
    
    if closeCancelled
        break;
    elseif saveFirst %user chose to save
        patient.saveToDisk();
    end  
end

if ~closeCancelled
    handles.patients = emptyPatient();
    handles.currentPatientNum = 0;
    handles.numPatients = 0;
    
    currentFile = emptyFile();
    
    %GUI updated
    updateGui(currentFile, handles);
    
    %displayed imaged updated
    handles = drawAll(currentFile, handles, hObject);
    
    %push up changes
    guidata(hObject, handles);
end

end


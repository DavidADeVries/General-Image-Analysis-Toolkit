function [ ] = giantAddStudy(hObject, handles)
%[ ] = giantAddStudy(hObject, handles)
% for any module from GIANT, this function will let the user create a
% custom study
%
% Required functions:
%   updateGuiForSeriesImageChange(currentFile, handles)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

studyName = studyNameDialog();

if ~isempty(studyName) %empty means user pressed cancel, do nothing
    currentPatient = getCurrentPatient(handles);
    
    newStudy = Study(studyName, Series.empty);
    
    currentPatient = currentPatient.addStudy(newStudy);
    
    currentPatient.changesPending = true;
    
    handles = updatePatient(currentPatient, handles);
    currentFile = getCurrentFile(handles);
    
    %update GUI
    updateGui(currentFile, handles);
    
    %draw new image
    handles = drawAll(currentFile, handles, hObject);
    
    %push up changes
    guidata(hObject, handles);
end

end


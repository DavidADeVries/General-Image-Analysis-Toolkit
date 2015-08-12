function [] = updateGui(currentFile, handles)
%[ ] = updateGui( currentFile, handles )
%
% ** REQUIRED BY GIANT **
%
% updates the entire GUI not just specific elements
% useful when switching patients/studies/series/files, a bit overkill if
% just making updates to the file

% EX:

updateImageInfo(currentFile, handles);

updatePatientSelector(handles);
updateStudySelector(handles);
updateSeriesSelector(handles);

updateToggleButtons(handles);


end


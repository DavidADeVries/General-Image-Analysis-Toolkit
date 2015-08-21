function [] = invalidDirectoryDialog()
% [] = invalidDirectoryDialog()
% This dialog box is displayed when a user tries to import a DICOM file
% that is outside of the root path of the study
% This is done since the reference paths to the original DICOM images for
% each File class object are relative to the root path, in order to keep
% them from getting disrupted by path changes up stream from the root path

message = ['The directory you tried to import was not inside the study folder. Please select a directory inside of ', Constants.ROOT_PATH];
title = 'Invalid Directory';

errordlg(message, title);

end


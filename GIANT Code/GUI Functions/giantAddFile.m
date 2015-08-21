function [ ] = giantAddFile(hObject, handles)
%[ ] = giantAddFile(hObject, handles)
% for any module from GIANT, this function will add your file
%
% Required functions:
%   updateGui(currentFile, handles)
%   createFile(imageName, dicomInfo, imagePath, dicomImage)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:
%   Constants.RAW_DATA_DIRECTORY


allowedFileOptions = {...
    '*.dcm','DICOM Files (*.dcm)'};
popupTitle = 'Select Images';
startingDirectory = Constants.RAW_DATA_DIRECTORY;

[imageFilenames, imagePath, ~] = uigetfile(allowedFileOptions, popupTitle, startingDirectory, 'MultiSelect', 'on');

if ~isa(imageFilenames, 'double'); %user didn't click cancel! (returns 0)
    if ~iscell(imageFilenames)
        imageFilenames = {imageFilenames};
    end
    
    numFiles = length(imageFilenames);
    
    if numFiles == 1
        message = 'opening image file.';
    else
        message = 'opening image files.';
    end
    
    len = length(Constants.ROOT_PATH);
    
    if (length(imagePath) >= len) && strcmp(imagePath(1:len), Constants.ROOT_PATH) % must get data from within the root path, or else proper file references for the images will likely get disrupted
        
        pleaseWaitHandle = pleaseWaitDialog(message);
        
        for i=1:numFiles
            filename = imageFilenames{i};
            
            currentPatient = getCurrentPatient(handles);
            
            completeFilepath = strcat(imagePath, filename);
            dicomInfo = dicominfo(completeFilepath);
            
            if strcmp(dicomInfo.PatientID, currentPatient.patientId) %double check sure patient is the same
                dicomImage = double(dicomread(completeFilepath));
                
                if (length(size(dicomImage)) == 2) %no multisplice support, sorry
                    newFile = createFile(filename, dicomInfo, completeFilepath, dicomImage);
                    
                    currentPatient = currentPatient.addFile(newFile);
                    
                    currentPatient.changesPending = true;
                    
                    handles = updatePatient(currentPatient, handles);
                    
                    currentFile = getCurrentFile(handles);
                    
                    handles.currentImage = dicomImage;
                    
                    %update view
                    updateGui(currentFile, handles);
                    
                    handles = drawAll(currentFile, handles, hObject);
                    
                    %push up changes
                    
                    guidata(hObject, handles);
                else
                    waitfor(msgbox('Multi-slice images are not supported!','Error','error'));
                end
            else
                waitfor(patientIdConflictDialog(currentPatient.patientId, dicomInfo.PatientID, completeFilepath));
            end
            
        end
        
        delete(pleaseWaitHandle);
    else
        invalidDirectoryDialog();
    end
end


end


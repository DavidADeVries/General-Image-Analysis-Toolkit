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
popupTitle = 'Select Image';
startingDirectory = Constants.RAW_DATA_DIRECTORY;

[imageFilename, imagePath, ~] = uigetfile(allowedFileOptions, popupTitle, startingDirectory);

if imageFilename ~= 0 %user didn't click cancel!
    currentPatient = getCurrentPatient(handles);
    
    completeFilepath = strcat(imagePath, imageFilename);
    dicomInfo = dicominfo(completeFilepath);
    
    if strcmp(dicomInfo.PatientID, currentPatient.patientId) %double check sure patient is the same
        dicomImage = double(dicomread(completeFilepath));
        
        if (length(size(dicomImage)) == 2) %no multisplice support, sorry            
            newFile = createFile(imageFilename, dicomInfo, completeFilepath, dicomImage);
            
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


end


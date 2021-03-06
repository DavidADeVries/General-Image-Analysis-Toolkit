function [studies, patientId] = createStudies(folderPath)
% [studies, patientId] = createStudies(folderPath)
% creates a list of studies based upon the path given. Each directory at
% the path given will be considered a study, each containing directories of
% studies, which in turn contain .dcm (DICOM) files
% also returns the patientId of the DICOM files

% requires:
%   createFile(imageName, dicomInfo, imagePath, dicomImage)

    dirList = dir(folderPath);
    studies = Study.empty;

    numStudies = 0;
    
    patientId = '';

    for i=1:length(dirList)
        entry = dirList(i);
        name = entry.name;

        if entry.isdir && ~(strcmp(name, '..') || strcmp(name, '.'))
            numStudies = numStudies + 1;

            [series, patientId, studyDate] = createSeries(strcat(folderPath,'/', name), patientId); 

            studies(numStudies) = Study(name, series, studyDate);
        end
    end
end

function [series, patientId, studyDate] = createSeries(folderPath, patientId)
    dirList = dir(folderPath);
    
    series = Series.empty;
    numSeries = 0;
    
    studyDate = '';
    
    for i=1:length(dirList)
        entry = dirList(i);
        name = entry.name;
        
        if entry.isdir && ~(strcmp(name, '..') || strcmp(name, '.'))
            numSeries = numSeries + 1;
            
            [files, patientId, studyDate] = createFiles(strcat(folderPath,'/', name), patientId, studyDate);
            
            series(numSeries) = Series(name, files);
        end
    end
end

function [files, patientId, studyDate] = createFiles(folderPath, patientId, studyDate)
    dirList = dir(folderPath);
    
    files = emptyFile();
    numFiles = 0;
    
    for i=1:length(dirList)
        entry = dirList(i);
        name = entry.name;
        
        if ~entry.isdir %must be file!
            len = length(name);
            fileType = name(len-2:len);
            
            if strcmp(fileType, 'dcm'); %make sure it's a dicom
                completeFilepath = strcat(folderPath,'/', name);
                dicomImage = double(dicomread(completeFilepath));
                
                if (length(size(dicomImage)) == 2)
                    dicomInfo = dicominfo(completeFilepath);
                    
                    newPatientId = dicomInfo.PatientID;
                    
                    if isempty(patientId)
                        patientId = newPatientId;
                    end
                    
                    if strcmp(patientId, newPatientId) %verify all the files are from the same patient
                        
                        numFiles = numFiles + 1;
                        
                        files(numFiles) = createFile(name, dicomInfo, completeFilepath, dicomImage);
                        
                        if isfield(dicomInfo, 'StudyDate') && isempty(studyDate)
                            studyDate = dicomInfo.StudyDate;
                        end
                    else
                        waitfor(patientIdConflictDialog(patientId, newPatientId, completeFilepath));
                        drawnow;
                    end
                end
            end
        end
    end
end
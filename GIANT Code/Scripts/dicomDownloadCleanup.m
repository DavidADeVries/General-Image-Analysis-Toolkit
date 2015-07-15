function [] = dicomDownloadCleanup(rawDataPath)

dirList = dir(rawDataPath);

for i=1:length(dirList)
    entry = dirList(i);
    downloadFolderName = entry.name;
    
    if entry.isdir && ~(strcmp(downloadFolderName,'.') || strcmp(downloadFolderName,'..'))
        if ~isempty(strfind(downloadFolderName, 'download')) %is a download folder
            [patientName, oldPatientDir] = cleanupPatient(strcat(rawDataPath,'/',downloadFolderName));
            
            patientFolderName = cleanString(patientName);
            
            newName = strcat(rawDataPath, '/', patientFolderName);
            
            patientAlreadyExists = exist(newName, 'dir');
            
            if patientAlreadyExists ~= 0
                warning(['Directory already exists at: ', newName, '. Processed patient at ', strcat(rawDataPath,'/',downloadFolderName,'/',patientFolderName) , ' will not be copied over']);
            else            
                movefile(oldPatientDir, newName);
            
                rmdir(strcat(rawDataPath,'/',downloadFolderName));
            end
        end            
    end
end


end

function [patientName, oldPatientDir] = cleanupPatient(downloadPath)

    dirList = dir(downloadPath);

    patientFolder = '';

    if length(dirList) == 3
        for i=1:length(dirList)
            entry = dirList(i);
            name = entry.name;

            if entry.isdir && ~(strcmp(name, '..') || strcmp(name, '.'))
                patientFolder = name;
            end
        end

        patientName = cleanupStudies(strcat(downloadPath, '/', patientFolder));
        
        oldPatientDir = strcat(downloadPath, '/', patientFolder);
        
    elseif isempty(dirList)
        warning('Directory does not exist!');
    else
        warning('Imcompatible Folder! Should only contain a single patient!');
    end
end

function patientName = cleanupStudies(patientPath)

dirList = dir(patientPath);

patientName = '';

studyCounter = 1;

dateFormat = 'mm-dd-yyyy'; %DO NOT PUT /'s in this! Is used in folder name!
dummyTime = cdfepoch(datestr(1,0,0)); %Jan 1, 000

for i=1:length(dirList)
    entry = dirList(i);
    studyFolder = entry.name;
    
    if entry.isdir && ~(strcmp(studyFolder, '..') || strcmp(studyFolder, '.'))
        
        [patientName, studyDescription, studyTime] = cleanupSeries(strcat(patientPath,'/', studyFolder), patientName);
        
        if ~isempty(studyDescription)
            if isempty(studyTime)
                studyTime = dummyTime;
            end
            
            dateNum = todatenum(studyTime);
            
            if dateNum == 1
                studyTimeString = 'No Date';
            else
                studyTimeString = datestr(dateNum, dateFormat);
            end
            
            studies(studyCounter) = struct('folder', studyFolder, 'studyDescription', studyDescription, 'studyTimeString', studyTimeString, 'sort', dateNum);
            studyCounter = studyCounter + 1;
        end
    end
end

%sort studies struct array so that they can be renamed in order
studiesCell = struct2cell(studies);
dims = size(studiesCell);

studiesCell = reshape(studiesCell, dims(1), [])';
sortedStudiesCell = sortrows(studiesCell, 4); %sort on date, column 4

sortedStudiesCell = reshape(sortedStudiesCell', dims);

sortedStudies = cell2struct(sortedStudiesCell, fieldnames(studies), 1);



for i=1:length(sortedStudies)
    study = sortedStudies(i);
    
    numDuplicates = checkForStudyDuplicates(sortedStudies, i);
    
    if numDuplicates == 0
        uniqueEnd = '';
    else
        uniqueEnd = [' (',num2str(numDuplicates+1),')'];
    end
    
    oldName = [patientPath, '/', study.folder];
    newName = [patientPath, '/', study.studyTimeString, ' - ', cleanString(study.studyDescription), uniqueEnd];
    
    if ~strcmp(oldName, newName)
        movefile(oldName, newName);
    end
end

end

function [patientName, studyDescription, studyTime] = cleanupSeries(studyPath, patientName)

dirList = dir(studyPath);

studyDescription = '';
studyTime = '';

seriesFolderNames = cell(0);
numSeries = 0;

for i=1:length(dirList)
    entry = dirList(i);
    seriesFolder = entry.name;
    
    if entry.isdir && ~(strcmp(seriesFolder, '..') || strcmp(seriesFolder, '.'))
        [patientName, studyDescription, studyTime, seriesNumber, seriesDescription] = cleanupFiles(strcat(studyPath,'/', seriesFolder), patientName, studyDescription, studyTime);
        
        if isempty(seriesDescription)
            seriesDescription = 'No Description';
        end
        
        if isempty(seriesNumber)
            seriesNumberString = '####';
        else
            seriesNumberString = padWithZeros(seriesNumber, 4);
        end
        
        seriesFolderName = [seriesNumberString, ' - ', cleanString(seriesDescription)];
        
        numDuplicates = checkForDuplicates(seriesFolderNames, seriesFolderName);
        
        if numDuplicates == 0
            uniqueEnd = '';
        else
            uniqueEnd = [' (', num2str(numDuplicates + 1), ')'];
        end
        
        numSeries = numSeries + 1;
        
        seriesFolderNames{numSeries} = seriesFolderName;
            
        
        oldName = [studyPath, '/', seriesFolder];
        newName = [studyPath, '/', seriesFolderName, uniqueEnd];
        
        if ~strcmp(oldName, newName)            
            movefile(oldName, newName);
        end
    end
end

end

function [patientName, studyDescription, studyTime, seriesNumber, seriesDescription] = cleanupFiles(seriesPath, patientName, studyDescription, studyTime)

dirList = dir(seriesPath);

seriesDescription = '';
seriesNumber = 0;

newFileNames = cell(0);
numNewFiles = 0;

for i=1:length(dirList)
    entry = dirList(i);
    fileName = entry.name;
    
    if entry.isdir 
        if ~(strcmp(fileName, '..') || strcmp(fileName, '.')) % another directory is present, shouldn't happen
            error(['Directory found when expecting DICOMs at: ', seriesPath, '/', fileName]);
        end  
    else
        len = length(fileName);
        fileType = fileName(len-2:len);
        
        if strcmp(fileType, 'dcm') %import this bad boy
            dicomHeader = dicominfo(strcat(seriesPath,'/',fileName));
            [patientName, studyDescription, studyTime, seriesNumber, seriesDescription] = extractHeaderInfo(dicomHeader, patientName, studyDescription, studyTime, seriesNumber, seriesDescription);
            
            if isfield(dicomHeader, 'InstanceNumber')            
                newFileName = padWithZeros(dicomHeader.InstanceNumber, 4);
            else
                newFileName = '####';
            end            
                    
            numDuplicates = checkForDuplicates(newFileNames, newFileName);
            
            if numDuplicates == 0
                uniqueEnd = '';
            else
                uniqueEnd = [' (', num2str(numDuplicates + 1), ')'];
            end
            
            numNewFiles = numNewFiles + 1;
            
            newFileNames{numNewFiles} = newFileName;
            
            
            oldName = strcat(seriesPath,'/', fileName);
            newName = strcat(seriesPath,'/', newFileName, uniqueEnd,'.dcm');
            
            if ~strcmp(oldName, newName)
                movefile(oldName, newName);
            end
        else
            warning(['Non DICOM file found at: ', seriesPath, '/', fileName]);
        end
    end
    
end
end

function str = cleanString(str)
    str = strrep(str, '/', '-');
    str = strrep(str, '\', '-');
end

function str = padWithZeros(num, targetLength)
    baseStr = num2str(num);
    
    len = length(baseStr);
    
    if len <= targetLength
        prefix = '';
        
        for i=len:targetLength-1
            prefix = [prefix, '0'];
        end
        
        str = [prefix, baseStr];
    else
        %warning([baseStr, ' is too long for a target length of ', num2str(targetLength)]);
        
        str = baseStr;
    end
end

function epoch = dateAndTimeToEpoch(dateString, timeString)
    yearString = dateString(1:4);
    monthString = dateString(5:6);
    dayString = dateString(7:8);
    
    if isempty(timeString)
        hourString = '0';
        minuteString = '00';    
    elseif mod(length(timeString), 2) == 0 %even length, hour is double digit
        hourString = timeString(1:2);
        minuteString = timeString(3:4);
    else %odd length, hour is single digit
        hourString = timeString(1);
        minuteString = timeString(2:3);
    end

    dateString = datestr([str2double(yearString), str2double(monthString), str2double(dayString), str2double(hourString), str2double(minuteString), 0]);
    epoch = cdfepoch(dateString);
end

function [patientName, studyDescription, studyTime, seriesNumber, seriesDescription] = extractHeaderInfo(dicomHeader, patientName, studyDescription, studyTime, seriesNumber, seriesDescription)

    if isempty(patientName)
        patientName = dicomHeader.PatientName.FamilyName;
    end

    if isempty(studyDescription)
        studyDescription = dicomHeader.StudyDescription;
    end
    
    if isfield(dicomHeader, 'StudyDate')
        studyDateString = dicomHeader.StudyDate;
    else
        studyDateString = '00000101'; %Jan 1, 0000 as dummy date
    end
    
    if isfield(dicomHeader, 'StudyTime')
        studyTimeString = dicomHeader.StudyTime;
    else
        studyTimeString = '0000'; % 00:00 as dummy time
    end    
    
    dicomStudyTime = dateAndTimeToEpoch(studyDateString, studyTimeString);
    
    if isempty(studyTime)
        studyTime = dicomStudyTime;
    end

    if isfield(dicomHeader, 'SeriesDescription')
        dicomSeriesDescription = dicomHeader.SeriesDescription;
    else
        dicomSeriesDescription = 'No Description';
    end

    if isempty(seriesDescription)
        seriesDescription = dicomSeriesDescription;
    end

    if isfield(dicomHeader, 'SeriesNumber')
        dicomSeriesNumber = dicomHeader.SeriesNumber;
    else
        dicomSeriesNumber = '';
    end

    if seriesNumber == 0
        seriesNumber = dicomSeriesNumber;
    end

    if ~(strcmp(patientName, dicomHeader.PatientName.FamilyName))
        warning('PatientName mismatch!');
    end

    if ~(strcmp(studyDescription, dicomHeader.StudyDescription))
        %warning('StudyDescription mismatch!');
    end

    if ~(strcmp(studyTime, dicomStudyTime))
        %warning('StudyTime mismatch!');
    end

    if ~(strcmp(seriesDescription, dicomSeriesDescription))
        %warning('SeriesDescription mismatch!');
    end

    if seriesNumber ~= dicomSeriesNumber
        %warning('SeriesNumber mismatch!');
    end

end

function numDuplicates = checkForStudyDuplicates(sortedStudies, i)
% since sortedStudies is sorted, only backtrack, looking to see how many so
% far would have been made

masterStudy = sortedStudies(i);

numDuplicates = 0;

i=i-1; %start backtracking

while i > 0
    prevStudy = sortedStudies(i);
    
    if strcmp(prevStudy.studyTimeString, masterStudy.studyTimeString) && strcmp(prevStudy.studyDescription, masterStudy.studyDescription)
        numDuplicates = numDuplicates + 1;
    elseif ~strcmp(prevStudy.studyTimeString, masterStudy.studyTimeString)
        break; % no need to search further
    end
    
    i = i-1;
end

end

function numDuplicates = checkForDuplicates(folderNames, matchName)
    numDuplicates = 0;
    
    for i=1:length(folderNames)
        if strcmp(folderNames{i}, matchName)
            numDuplicates = numDuplicates + 1;
        end
    end
end
function [ error ] = exportToCsv(patients, exportPath, overwrite)
%exportToCsv exports the list of patients to the given .csv path.
%'overwrite' specifies whether to overwrite the file completely, or whether
%to append. Note that when appending, only the patients in the file that
%are NOT in the list of patients are saved. If a patient in is the file and
%in the list, the one in the list takes precedent and COMPLETELY overwrites
%the existing patient data

% required functions
% - setFields(splitFormatted)
% - getHeader()
% - printToFile(fileId, lineNumber, values, newline, delim)
% - getExportValues(patient, study, series, file, sequenceNumber)
% - file.isValidForExport()

newline = '\n';
delim = ',';
header = getHeader();

linesToKeep = cell(0);

error = false;

if ~overwrite
    [fileId, err] = fopen(exportPath, 'r');
    
    if isempty(err)
        for i=1:height(header)
            fgets(fileId); %ignore header lines
        end
        
        line = fgets(fileId); %first line of data
        
        ignoreTillNextId = false;
        
        i = 1;
        
        while(ischar(line))
            line = strrep(line, [delim, delim], [delim, ' ', delim]); %makes sure empty cells aren't swept aside
            split = strsplit(line, ',');
            patientId = char(split(1));
            
            if ignoreTillNextId && ~isempty(patientId)
                ignoreTillNextId = false;
            end
            
            if ~ignoreTillNextId && isPatientIdPresent(patientId, patients) %need to be removed, do not save lines
                ignoreTillNextId = true;
            end
            
            if ~ignoreTillNextId
                splitFormatted = cell(length(split),1);
                
                for j=1:length(split)
                    splitFormatted{j} = strrep(char(split(j)), ' ', ''); %make empty cells original
                end
                
                linesToKeep{i} = setFields(splitFormatted);
                
                i = i + 1;
            end
            
            line = fgets(fileId);
        end
        
        fclose(fileId);
    else
        message = 'An error occurred when trying open the .csv to append to! The export was aborted!';
        icon = 'error';
        title = 'Export Error';
        
        msgbox(message, title, icon);
        
        error = true;
    end
end
    
[fileId, err] = fopen(exportPath, 'w');

if isempty(err) %write file anew
    %write column headers
    
    lineNumber = 1;
    
    for i=1:height(header)
        headerLine = header(i,:);
        
        numCells = length(headerLine);
        
        for j=1:numCells
            fprintf(fileId, headerLine{j});
            
            if j ~= numCells
                fprintf(fileId, ',');
            end
        end
        
        fprintf(fileId, newline);
        
        lineNumber = lineNumber + 1;
    end
        
    %write data from previous file if choosen to not overwrite
    
    for i=1:length(linesToKeep)
        printToFile(fileId, lineNumber, linesToKeep{i}, newline, delim);
        lineNumber = lineNumber + 1;
    end
    
    %write new data from patient list
    
    %loop through patients
    for i=1:length(patients)
        patient = patients(i);
        
        sequenceNumber = 1; %reset sequence number counter for each patient
        
        studies = patient.studies;
        
        %loop through studies
        for j=1:length(studies)
            study = studies(j);
            
            series = study.series;
            
            %loop through series
            for k=1:length(series)
                singularSeries = series(k);
                
                files = singularSeries.files; 
                
                %loop through files
                for l=1:length(files)
                    file = files(l);
                    
                    if file.isValidForExport()
                        values = getExportValues(patient, study, singularSeries, file, sequenceNumber);
                        printToFile(fileId, lineNumber, values, newline, delim);
                        
                        lineNumber = lineNumber + 1;
                        sequenceNumber = sequenceNumber + 1;
                    end
                end
            end
        end
    end
    
    fclose(fileId); % close file after done writing
    
else
    message = 'An error occurred when trying to export to the .csv! The export was aborted!';
    icon = 'error';
    title = 'Export Error';
    
    msgbox(message, title, icon);
    
    error = true;
end

end

function [bool] = isPatientIdPresent(patientId, patients)
    bool = false;
    
    i=1;
    
    while (i <= length(patients) && ~bool)
        if strcmp(patients(i).patientId, patientId)
            bool = true;
        end
        
        i = i+1;
    end
end
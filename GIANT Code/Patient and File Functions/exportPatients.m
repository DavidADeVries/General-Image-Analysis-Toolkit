function [ ] = exportPatients(patients)
%[ ] = exportPatients(patients) interacts with the user to handle the
%exporting of the patient list given
%
% Required functions:
%   exportToCsv(patients, exportPath, overwrite)
%
% Required constants:
%   Constants.CSV_EXPORT_DIRECTORY

[cancelled, overwrite] = overwriteOrAppendDialog(); %user can choose to overwrite file or append to it

if ~cancelled
    path = strcat(Constants.CSV_EXPORT_DIRECTORY, '*.csv');
    
    fileOptions = {'*.csv','Comma Delimited Spreadsheets (*.csv)'};
    popupTitle = 'Export Analysis Data';
    
    if overwrite
        [exportFilename, exportPathname] = uiputfile(path, popupTitle);
    else %append
        [exportFilename, exportPathname, ~] = uigetfile(fileOptions, popupTitle, path);
    end
    
    if exportFilename ~= 0 %didn't click cancel
        exportPath = strcat(exportPathname, exportFilename);
        
        error = exportToCsv(patients, exportPath, overwrite);
        
        if ~error
            waitfor(exportCompleteDialog());
        end
    end
    
end

end

classdef Constants
    %Constants stores the constants
    
        
    properties (Constant = true)
        % for dev
        GIANT_PATH = strcat(HighLevelConstants.BASE_DIRECTORY, '/General Image Analysis Toolkit/GIANT/metadata/');
        ALLOW_CLOSE = true;
        
        % for released
        %GIANT_PATH = strcat(HighLevelConstants.BASE_DIRECTORY, '/General Image Analysis Toolkit/Current Release/metadata/');
        %ALLOW_CLOSE = false;
        
        
        SAVED_PATIENTS_DIRECTORY = strcat(HighLevelConstants.BASE_DIRECTORY, HighLevelConstants.STUDY_DIRECTORY, '/Saved Patient Analysis/'); %make sure it's absolute and ends with '/'
        RAW_DATA_DIRECTORY = strcat(HighLevelConstants.BASE_DIRECTORY, HighLevelConstants.STUDY_DIRECTORY, '/Raw Data/');
        CSV_EXPORT_DIRECTORY = strcat(HighLevelConstants.BASE_DIRECTORY, HighLevelConstants.STUDY_DIRECTORY, '/Exported Spreadsheets/');
        SNAPSHOT_DIRECTORY = strcat(HighLevelConstants.BASE_DIRECTORY, HighLevelConstants.STUDY_DIRECTORY, '/Snapshots/');
        
        SAVE_TITLE_SUGGESTION = 'New Module File';
        
    end
    
    methods
    end
    
end


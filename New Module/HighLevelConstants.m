classdef HighLevelConstants
    %basically stores the constants for the constants, because MATLAB don't
    %let you do dat
    
    properties (Constant = true) 
        BASE_DIRECTORY = '/data/projects';
    
        % DEV:
        STUDY_DIRECTORY = '/General Image Analysis Toolkit/GIANT/Example Study';
        
        % PROD:
        % STUDY_DIRECTORY = '/General Image Analysis Toolkit/GIANT/metadata/New Module/Example Study';
    end       
    
    methods
    end
    
end


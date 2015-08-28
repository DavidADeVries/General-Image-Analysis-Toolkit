classdef NewModuleFile < File
    % NewModuleFile
    % (please rename to be unique to your module, e.g. GasSamFile, FamSamFile, etc.)
    %
    % ** REQUIRED BY GIANT **
    %
    % this class is the file type specific to your module.
    % it inherits from the GIANT File type to already have all base fields
    % needed, all you need to do is add the fields relevant for the
    % analysis your module will conduct.
    % Your constuctor may take any form you wish, though you must make the
    % functions:
    %
    %   - createFile(imageFilename, dicomInfo, imagePath, image)
    %   - emptyFile()
    %
    % these functions give GIANT a standard abstraction layer to leverage
    %
    % NOTE: You do not have to define this if no new File properities or
    % methods are needed
    
    properties
        % new fields for your analysis
        %
        % EX:
        
        field1
        field2
        field3
        
    end
    
    methods
        %% ** MANDATORY FUNCTIONS ** %%
        
        %% Constructor %%
        function newModuleFile = NewModuleFile(name, dicomInfo, imagePath, image, newVar1, newVar2, newVar3)
            newModuleFile@File(name, dicomInfo, imagePath, image); % must use File constructor first
            
            % Set any new fields if needed
            %
            % EX:
            
            newModuleFile.field1 = newVar1;
            newModuleFile.field2 = newVar2;
            newModuleFile.field3 = newVar3;
        end
        
        %% isValidForExport %%
        % ** REQUIRED BY GIANT **
        % returns if file meets the requirements to have it's analysis
        % results exported
        function isValid = isValidForExport(file)
            isValid = ~(isempty(file.field1) || isempty(file.field2) || isempty(file.field3));
        end
        
        %% ** ADD NEW FUNCTIONS BELOW **
        
        %% newFunction1 %%
        % write any new functions you need
        function file = newFunction1(file)
        end
        
        %% newFunction2 %%
        % write any new functions you need
        function file = newFunction2(file)
        end
        
        %% newFunction3 %%
        % write any new functions you need
        function file = newFunction3(file)
        end
        
         
end

end

classdef CacheEntry
    %CacheEntry
    %
    % ** REQUIRED BY GIANT **
    %
    % stores the relevant fields from a File to allow an undo
    % command to be performed
    
    properties
        % these should be the fields to be saved for undo/redo
        %
        % EX:
        
        field1
        field2
        field3
    end
    
    methods
        %% CONSTRUCTOR %%
        % stores fields to be saved into CacheEntry object
        % NOTE: The input/ouput parameters for this function must stay fixed!
        function cacheEntry = CacheEntry(file)
            % EX:
            
            cacheEntry.field1 = file.field1;
            cacheEntry.field2 = file.field2;
            cacheEntry.field3 = file.field3;
        end
        
        %% restoreToFile %%
        % takes whatever relevant fields were stored in the CacheEntry and
        % restores them to the File's fields
        % NOTE: The input/ouput parameters for this function must stay fixed!
        function file = restoreToFile(cacheEntry, file)
            % EX:
            
            file.field1 = cacheEntry.field1;
            file.field2 = cacheEntry.field2;
            file.field3 = cacheEntry.field3;
        end
    end
    
end
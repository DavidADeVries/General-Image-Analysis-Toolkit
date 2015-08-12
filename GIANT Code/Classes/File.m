classdef File
    %file represents an open DICOM file
    
    properties
        dicomInfo
        name = '';
        imagePath = '';
        zoomLims = struct('xLim', [], 'yLim', []);
        
        date % I know dicomInfo would hold this, but to have it in an easily compared form is nice

        undoCache = UndoCache.empty;
    end
    
    methods
        %% Constructor %%
        function file = File(name, dicomInfo, imagePath, image)                        
            file.name = name;
            file.dicomInfo = dicomInfo;
            file.imagePath = imagePath;
            file.date = Date(dicomInfo.StudyDate);
            
            file = file.setToDefaultZoom(image);
            
            file.undoCache = UndoCache(file);
        end
        
        %% getImage %%
        function image = getImage(file)
            if isempty(file)
                image = [];
            else
                try
                    image = double(dicomread(file.imagePath));
                catch
                    image = [];
                    
                    message = ['An error occurred when trying to open the file at: ', file.imagePath];
                    icon = 'error';
                    title = 'File Error';
                    
                    waitfor(msgbox(message, title, icon));
                end
            end
        end
                        
        %% getSeriesDescription %%
        function description = getSeriesDescription(file)
            header = file.dicomInfo;
            
            if isfield(header, 'SeriesDescription')
                description = header.SeriesDescription;
            else
                description = 'No Description Found';
            end
        end
        
        %% getStudyDescription %%
        function description = getStudyDescription(file)
            header = file.dicomInfo;
            
            if isfield(header, 'StudyDescription')
                description = header.StudyDescription;
            else
                description = 'No Description Found';
            end
        end
        
                        
        %% updateUndoCache %%
        % saves the file at current into its own undo cache
        function [ file ] = updateUndoCache( file )
            %updateUndoCache takes whatever is in the currentFile that could be changed
            %and caches it
            
            cache = file.undoCache;
            
            oldCacheEntries = cache.cacheEntries;
            
            newCacheSize = cache.numCacheEntries()  - cache.cacheLocation + 2;
            
            maxCacheSize = cache.cacheSize;
            
            if newCacheSize > maxCacheSize
                newCacheSize = maxCacheSize;
            end
            
            newCacheEntries = CacheEntry.empty(newCacheSize,0);
            
            newCacheEntries(1) = CacheEntry(file); %most recent is now the current state (all previous redo options eliminated)
            
            %bring in all entries that are still in the "past". Any before
            %cacheLocation are technically in a "future" that since a change has been
            %made, it would be inconsistent for this "future" to be reachable, and so
            %the entries are removed.
            
            for i=2:newCacheSize
                newCacheEntries(i) = oldCacheEntries(cache.cacheLocation + i - 2);
            end
            
            cache.cacheEntries = newCacheEntries;
            cache.cacheLocation = 1;
            
            file.undoCache = cache;            
        end
        
        
        %% performUndo %%
        function [ file ] = performUndo( file )
            %performUndo actually what it says on the tin
            
            cacheLocation = file.undoCache.cacheLocation;
            
            numCacheEntries = length(file.undoCache.cacheEntries);
            
            cacheLocation = cacheLocation + 1; %go back in time
            
            if cacheLocation > numCacheEntries
                cacheLocation = numCacheEntries;
            end
            
            if cacheLocation > file.undoCache.cacheSize
                cacheLocation = file.undoCache.cacheSize;
            end
            
            file.undoCache.cacheLocation = cacheLocation;
            
            cacheEntry = file.undoCache.cacheEntries(cacheLocation);
            
            file = cacheEntry.restoreToFile(file);           
        end
        
        %% performRedo %%
        function [ file ] = performRedo( file )
            %performUndo actually what it says on the tin
                        
            cacheLocation = file.undoCache.cacheLocation;
            
            cacheLocation = cacheLocation - 1; %go forward in time
            
            if  cacheLocation == 0
                cacheLocation = 1;
            end
            
            file.undoCache.cacheLocation = cacheLocation;
            
            cacheEntry = file.undoCache.cacheEntries(cacheLocation);
            
            file = cacheEntry.restoreToFile(file); 
        end
        
        %% getZoomLims %%
        function [xLim, yLim] = getZoomLims(file)
            xLim = file.zoomLims.xLim;
            yLim = file.zoomLims.yLim;
        end
        
        %% setZoomLims
        function file = setZoomLims(file, xLim, yLim)
            file.zoomLims.xLim = xLim;
            file.zoomLims.yLim = yLim;
        end        
        
        %% setToDefaultZoom %%
        function file = setToDefaultZoom(file, image)
            dims = size(image);
            xLim = [0.5, dims(2) + 0.5];
            yLim = [0.5, dims(1) + 0.5];
            
            file.zoomLims.xLim = xLim;
            file.zoomLims.yLim = yLim;
        end
        
        
    end
    
end

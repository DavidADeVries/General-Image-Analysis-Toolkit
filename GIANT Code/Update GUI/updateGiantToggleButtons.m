function [ ] = updateGiantToggleButtons( handles )
%updateToggleGiantButtons(handles)
%only updates the toggle buttons that are common for all GIANT applications

disableAllToggles(handles);

% always available

% drop downs too
set(handles.patientSelector, 'Enable', 'on');
set(handles.studySelector, 'Enable', 'on');
set(handles.seriesSelector, 'Enable', 'on');

set(handles.open, 'Enable', 'on');
set(handles.menuOpen, 'Enable', 'on');

set(handles.importPatientDirectory, 'Enable', 'on');
set(handles.addPatient, 'Enable', 'on');

set(handles.menuImportPatientDirectory, 'Enable', 'on');
set(handles.menuAddPatient, 'Enable', 'on');


currentPatient = getCurrentPatient(handles);

if ~isempty(currentPatient) %add in patient operations
    
    if ~currentPatient.changesPending
        set(handles.savePatient, 'Enable', 'off');
        set(handles.menuSavePatient, 'Enable', 'off');
    else
        set(handles.savePatient, 'Enable', 'on');
        set(handles.menuSavePatient, 'Enable', 'on');        
    end
    
    set(handles.saveAll, 'Enable', 'on');
    set(handles.exportPatient, 'Enable', 'on');
    set(handles.exportAllPatients, 'Enable', 'on');
    
    set(handles.addStudy, 'Enable', 'on');
    set(handles.closePatient, 'Enable', 'on');
    set(handles.closeAllPatients, 'Enable', 'on');
    
    set(handles.menuOpen, 'Enable', 'on');
    set(handles.menuSavePatientAs, 'Enable', 'on');
    set(handles.menuSaveAll, 'Enable', 'on');
    set(handles.menuExportPatient, 'Enable', 'on');
    set(handles.menuExportAllPatients, 'Enable', 'on');
    
    set(handles.menuImportPatientDirectory, 'Enable', 'on');
    set(handles.menuAddPatient, 'Enable', 'on');    
    set(handles.menuAddStudy, 'Enable', 'on');
    set(handles.menuClosePatient, 'Enable', 'on');
    set(handles.menuCloseAllPatients, 'Enable', 'on');
           
    currentStudy = currentPatient.getCurrentStudy();
    
    if ~isempty(currentStudy) %add in study operations
        set(handles.addSeries, 'Enable', 'on');        
        set(handles.removeStudy, 'Enable', 'on');
                
        set(handles.menuAddSeries, 'Enable', 'on');        
        set(handles.menuRemoveStudy, 'Enable', 'on');
                
        currentSeries = currentStudy.getCurrentSeries();
        
        if ~isempty(currentSeries) %add in series operations
            set(handles.addFile, 'Enable', 'on');        
            set(handles.removeSeries, 'Enable', 'on');
                
            set(handles.menuAddFile, 'Enable', 'on');        
            set(handles.menuRemoveSeries, 'Enable', 'on');
            
            if currentPatient.getCurrentSeriesNumInStudy() ~= 1
                set(handles.previousSeries, 'Enable', 'on');
                
                set(handles.menuPreviousSeries, 'Enable', 'on');
            end
            
            if currentPatient.getCurrentSeriesNumInStudy() ~= currentPatient.getNumSeriesInStudy()
                set(handles.nextSeries, 'Enable', 'on');
                
                set(handles.menuNextSeries, 'Enable', 'on');
            end
            
            currentFile = currentSeries.getCurrentFile();
            
            if ~isempty(currentFile) %add in file operations
                % on no matter what state currentFile is in
                set(handles.removeFile, 'Enable', 'on');
                set(handles.exportAsImage, 'Enable', 'on');
                
                set(handles.menuRemoveFile, 'Enable', 'on');                
                set(handles.menuExportAsImage, 'Enable', 'on');
                
                set(handles.zoomIn, 'Enable', 'on');
                set(handles.zoomOut, 'Enable', 'on');
                set(handles.pan, 'Enable', 'on');
                
                set(handles.resetImage, 'Enable', 'on');
                set(handles.menuResetImage, 'Enable', 'on');
                
                   
                % undo/redo buttons
                
                undoCache = currentFile.undoCache;
                
                if undoCache.cacheLocation ~= 1
                    set(handles.redo, 'Enable', 'on');
                    set(handles.menuRedo, 'Enable', 'on');
                end
                
                if undoCache.cacheLocation ~= undoCache.numCacheEntries()
                    set(handles.undo, 'Enable', 'on');
                    set(handles.menuUndo, 'Enable', 'on');
                end
                                
                % time moving buttons
                
                if currentPatient.getCurrentFileNumInSeries() ~= 1
                    set(handles.earlierImage, 'Enable', 'on');
                    set(handles.earliestImage, 'Enable', 'on');
                    
                    set(handles.menuEarlierImage, 'Enable', 'on');
                    set(handles.menuEarliestImage, 'Enable', 'on');
                end
                
                if currentPatient.getCurrentFileNumInSeries() ~= currentPatient.getNumFilesInSeries()
                    set(handles.laterImage, 'Enable', 'on');
                    set(handles.latestImage, 'Enable', 'on');
                    
                    set(handles.menuLaterImage, 'Enable', 'on');
                    set(handles.menuLatestImage, 'Enable', 'on');
                end
            end
        end
    end      
end
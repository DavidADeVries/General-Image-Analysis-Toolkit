function [ ] = disableAllGiantToggleButtons( handles )
%disableAllGiantToggleButtons(handles)
%disable all the buttons that are common between GIANT modules

% drop downs too
set(handles.patientSelector, 'Enable', 'off');
set(handles.studySelector, 'Enable', 'off');
set(handles.seriesSelector, 'Enable', 'off');

%toolbar options
set(handles.open, 'Enable', 'off');
set(handles.savePatient, 'Enable', 'off');
set(handles.saveAll, 'Enable', 'off');
set(handles.exportPatient, 'Enable', 'off');
set(handles.exportAllPatients, 'Enable', 'off');
set(handles.exportAsImage, 'Enable', 'off');

set(handles.undo, 'Enable', 'off');
set(handles.redo, 'Enable', 'off');

set(handles.importPatientDirectory, 'Enable', 'off');
set(handles.addPatient, 'Enable', 'off');
set(handles.addStudy, 'Enable', 'off');
set(handles.addSeries, 'Enable', 'off');
set(handles.addFile, 'Enable', 'off');
set(handles.closePatient, 'Enable', 'off');
set(handles.closeAllPatients, 'Enable', 'off');
set(handles.removeStudy, 'Enable', 'off');
set(handles.removeSeries, 'Enable', 'off');
set(handles.removeFile, 'Enable', 'off');

set(handles.previousSeries, 'Enable', 'off');
set(handles.nextSeries, 'Enable', 'off');

set(handles.earliestImage, 'Enable', 'off');
set(handles.earlierImage, 'Enable', 'off');
set(handles.laterImage, 'Enable', 'off');
set(handles.latestImage, 'Enable', 'off');

set(handles.generalAccept, 'Visible', 'off');
set(handles.generalDecline, 'Visible', 'off');

%menu options
set(handles.menuOpen, 'Enable', 'off');
set(handles.menuSavePatient, 'Enable', 'off');
set(handles.menuSavePatientAs, 'Enable', 'off');
set(handles.menuSaveAll, 'Enable', 'off');
set(handles.menuExportPatient, 'Enable', 'off');
set(handles.menuExportAllPatients, 'Enable', 'off');

set(handles.menuUndo, 'Enable', 'off');
set(handles.menuRedo, 'Enable', 'off');

set(handles.menuImportPatientDirectory, 'Enable', 'off');
set(handles.menuAddPatient, 'Enable', 'off');
set(handles.menuAddStudy, 'Enable', 'off');
set(handles.menuAddSeries, 'Enable', 'off');
set(handles.menuAddFile, 'Enable', 'off');
set(handles.menuClosePatient, 'Enable', 'off');
set(handles.menuCloseAllPatients, 'Enable', 'off');
set(handles.menuRemoveStudy, 'Enable', 'off');
set(handles.menuRemoveSeries, 'Enable', 'off');
set(handles.menuRemoveFile, 'Enable', 'off');
set(handles.menuExportAsImage, 'Enable', 'off');

set(handles.menuPreviousSeries, 'Enable', 'off');
set(handles.menuNextSeries, 'Enable', 'off');

set(handles.menuEarliestImage, 'Enable', 'off');
set(handles.menuEarlierImage, 'Enable', 'off');
set(handles.menuLaterImage, 'Enable', 'off');
set(handles.menuLatestImage, 'Enable', 'off');

end


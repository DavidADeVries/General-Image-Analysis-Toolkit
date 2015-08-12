function [] = giantPanCallback(hObject)
% [] = giantPanCallback(hObject)
% saves the current zoom/pan state of the axes to the current file
% also calls "panCallback(currentFile, hObject, handles)" in case there's anything the
% module needs to do.

handles = guidata(hObject);

axesHandles = handles.imageAxes;

xLim = get(axesHandles, 'XLim');
yLim = get(axesHandles, 'YLim');

currentFile = getCurrentFile(handles);

currentFile = currentFile.setZoomLims(xLim, yLim);

updateUndo = false;
pendingChanges = true;

handles = updateFile(currentFile, updateUndo, pendingChanges, handles);

handles = panCallback(currentFile, hObject, handles);

% update GUI
updateToggleButtons(handles);

% push up changes
guidata(hObject, handles);

end


function [ ] = giantRedo(hObject, handles)
%[ ] = giantRedo(hObject, handles)
% for any module from GIANT, this function will perform an redo with the
% current file
%
% Required functions:
%   updateGuiForUndoRedo(currentFile, handles)
%   createFile(imageName, dicomInfo, dicomImage)
%   drawAll(currentFile, handles, hObject)
%
% Required constants:


currentFile = getCurrentFile(handles);

currentFile = currentFile.performRedo();

% finalize changes
updateUndo = false;
pendingChanges = true; 
handles = updateFile(currentFile, updateUndo, pendingChanges, handles);

% update display
handles = drawAll(currentFile, handles, hObject);

updateGuiForUndoRedo(currentFile, handles);

% push up the changes
guidata(hObject, handles);

end


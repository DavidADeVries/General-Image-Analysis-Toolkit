function [ ] = giantWindowButtonUpFcn(hObject, handles)
%[ ] = giantWindowButtonUpFcn(hObject, handles)
% is triggered when a click is done (button up)
% the handles.updateUndoCache variable makes it so that only at the end of
% a click-and-drag is the data pushed back and saved, and cached in the
% undoCache

if handles.updateUndoCache    
    currentFile = getCurrentFile(handles);
        
    %save changes
    updateUndo = true;
    pendingChanges = true;
    
    handles = updateFile(currentFile, updateUndo, pendingChanges, handles); %undo cache will be auto updated
    
    % reset updateUndoCache variable (will on go again when a callback is
    % triggered, not just any click)
    handles.updateUndoCache = false;
    
    updateToggleButtons(handles);
    
    %push up changes
    guidata(hObject, handles);
end

end


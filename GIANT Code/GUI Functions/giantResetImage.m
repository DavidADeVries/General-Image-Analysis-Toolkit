function [ ] = giantResetImage(hObject, handles)
%[ ] = giantResetImage(hObject, handles)
% for any module from GIANT, this function will go reset any changes
% (analysis, ROIs, contrast, etc.) made to the image
%
% Required functions:
%   ??
%
% Required constants:

question = 'Are you sure you want to reset the current image? All completed analysis will be removed.';
title = 'Reset Current Image';

cancelled = confirmRemoveDialog(question, title);

if ~cancelled    
    currentFile = getCurrentFile(handles);
    
    currentFile = currentFile.reset(handles.currentImage);
    
    updateUndo = true;
    pendingChanges = false;
    
    handles = updateFile(currentFile, updateUndo, pendingChanges, handles);
        
    %GUI updated
    updateGui(currentFile, handles);
    
    %displayed imaged updated
    handles = drawAll(currentFile, handles, hObject);
    
    %push up changes
    guidata(hObject, handles);  
end

end


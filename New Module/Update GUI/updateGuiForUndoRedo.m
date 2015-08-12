function [] = updateGuiForUndoRedo(currentFile, handles)
%[] = updateGuiForUndoRedo(currentFile, handles)
%
% ** REQUIRED BY GIANT **
%
% similar to updateGui, but we need to do even less because we aren't even
% changing images. For the most part just the buttons need to be updated,
% maybe an analysis table or unit panel if that's what your module has

updateToggleButtons(handles);

end


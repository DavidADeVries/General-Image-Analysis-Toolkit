function [] = updateGuiForSeriesImageChange(currentFile, handles)
%[] = updateGuiForSeriesImageChange(currentFile, handles)
%
% ** REQUIRED BY GIANT **
%
% similar to updateGui, except that we don't need to update all the
% patient, study, or series specific GUI elements, such as the dropdowns

updateImageInfo(currentFile, handles);
updateToggleButtons(handles);

end


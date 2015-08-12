function handles = zoomCallback(currentFile, hObject, handles)
% handles = zoomCallback(currentFile, hObject, handles)
%
% ** REQUIRED BY GIANT **
%
% This function is triggered automatically whenever the zoom changes. The
% zoom state may then be saved and stuff redrawn if need be
%
% NOTE: the push back of data (aka. guidata(hObject, handles)) will be done
% by GIANT, you just need to return the updated handles.

% EX:

handles = drawAll(currentFile, handles, hObject); % doing drawAll is not recommended because it'll be slow, but you get the idea

end


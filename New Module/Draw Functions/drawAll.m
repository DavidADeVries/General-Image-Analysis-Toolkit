function [ handles ] = drawAll(currentFile, handles, hObject)
% [ handles ] = drawAll(currentFile, handles, hObject )
%
% ** REQUIRED BY GIANT **
%
% Completely redraws the currentFile's image and anything else drawn on top
% of it

if isempty(currentFile)
    cla(handles.imageAxes);
else
    % these lines are an example.
    % it is recommend the drawing into multiple functions, and then call
    % them from here.
    % EX:
    % drawImage(currentFile, handles);
    % drawAnalysisLines(currentFile, handles, hObject);
    % etc..
    
    axes(handles.imageAxes);
    
    imshow(handles.currentImage,[]);
    
    handles = emptyDisplayHandles(handles);
end


end


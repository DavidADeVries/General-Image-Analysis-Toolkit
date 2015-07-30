function [ handles ] = emptyDisplayHandles(handles)
%[ handles ] = emptyDisplayHandles( handles )
%
% ** REQUIRED BY GIANT **
%
% sets all display object handles to be empty
% useful when an imshow clears everything, but you still have the handles
% for objects lying around

% EX:

handles.pointHandles1 = impoint.empty;
handles.pointHandles2 = impoint.empty;


end


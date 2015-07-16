function [ ] = giantClosePatient(hObject, handles)
%[ ] = giantClosePatient(hObject, handles)
% for any module from GIANT, this function will close the current patient

[closeCancelled, handles] = closePatient(hObject, handles);

if ~closeCancelled
    %push up changes
    guidata(hObject, handles); 
end


end


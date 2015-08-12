function [] = giantCloseRequestFcn(hObject, handles)
% when GUI is attempted to be closed, the function is triggered
% it allows for the close action to switched off using the constant
% "ALLOW_CLOSE", which can be useful for released applications

if Constants.ALLOW_CLOSE
    if isequal(get(hObject, 'waitstatus'), 'waiting')
        % The GUI is still in UIWAIT, us UIRESUME
        uiresume(hObject);
    else
        % The GUI is no longer waiting, just close it
        delete(hObject);
    end
end

end


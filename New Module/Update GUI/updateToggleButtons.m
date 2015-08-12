function [] = updateToggleButtons(handles)
% [] = updateToggleButtons(handles)
%
% ** REQUIRED BY GIANT **
%
% when switching images, the buttons need to be
% correctly depressed or not to begin with
% starts off with first disabling all the toggles (disableAllToggles), and
% then adds in new ones.
% use 'updateGiantToggleButtons(handles)' to set all the GIANT supplied
% buttons correctly

% EX:

disableAllToggles(handles); % disable all buttons

updateGiantToggleButtons(handles); % get GIANT buttons right

currentFile = getCurrentFile(handles);

if ~isempty(currentFile) %add in file operations for module
    
    % everything below here is completely arbitrary. Please replace!!
    set(handles.button1, 'Enable', 'on');
    
    set(handles.toggle1, 'Enable', 'on');
    
    if currentFile.field1 == 0
        set(handles.toggle1, 'State', 'on');
    end
        
    %menu options
    
    set(handles.menuOption1, 'Enable', 'on');
    
    set(handles.menuToggleOption1, 'Enable', 'on');
    
    if currentFile.field1 == 0;
        set(handles.menuToggleOption1, 'Checked', 'on');
    end
    
end

end
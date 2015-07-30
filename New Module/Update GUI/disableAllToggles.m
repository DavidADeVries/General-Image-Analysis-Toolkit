function [] = disableAllToggles(handles)
% [] = disableAllToggles(handles)
%
% ** REQUIRED BY GIANT **
%
% disables all buttons, menu options, and drop down boxes
% used 'disableAllGiantToggleButtons(handles)' to take care of all the UI
% elements from GIANT

% EX:

disableAllGiantToggleButtons(handles); % disable all UI elements from GIANT

%toolbar options

set(handles.button1, 'Enable', 'off');

set(handles.toggle1, 'Enable', 'off');
set(handles.toggle1, 'State', 'off');

set(handles.generalAccept, 'Visible', 'off');
set(handles.generalDecline, 'Visible', 'off');

%menu options

set(handles.menuOption1, 'Enable', 'off');

set(handles.menuToggleOption1, 'Enable', 'off');
set(handles.menuToggleOption1, 'Checked', 'off');

end


function [  ] = giantCloseAllPatients( hObject, handles )
%[  ] = giantCloseAllPatients( hObject, handles )
% for any module from GIANT, this function will close all the patients
%
% Required functions:
%   updateGui(currentFile, handles)
%   emptyPatient()
%   emptyFile()
%   drawAll(currentFile, handles, hObject)
%
% Required constants:

closeCancelled = false;

i = 1;

numPatients = handles.numPatients;

while i<=numPatients && ~closeCancelled %if user selects cancel at any point, the close all stops where it is
    [closeCancelled, handles] = closePatient(hObject, handles); %simply closes the current patient for however many patients there are
    
    i = i+1;
end
        
%push up changes
guidata(hObject, handles);

end


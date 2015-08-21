function varargout = GIANT_BASE(varargin)

% add needed librarys

addpath(genpath('.')); %add all subfolders in the current directory

addpath(genpath(strcat(Constants.GIANT_PATH, 'GIANT Code')));

% GIANT_BASE MATLAB code for GIANT_BASE.fig
%      GIANT_BASE, by itself, creates a new GIANT_BASE or raises the existing
%      singleton*.
%
%      H = GIANT_BASE returns the handle to a new GIANT_BASE or the handle to
%      the existing singleton*.
%
%      GIANT_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GIANT_BASE.M with the given input arguments.
%
%      GIANT_BASE('Property','Value',...) creates a new GIANT_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GIANT_BASE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GIANT_BASE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GIANT_BASE

% Last Modified by GUIDE v2.5 20-Aug-2015 11:08:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GIANT_BASE_OpeningFcn, ...
    'gui_OutputFcn',  @GIANT_BASE_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GIANT_BASE is made visible.
function GIANT_BASE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GIANT_BASE (see VARARGIN)

% Choose default command line output for GIANT_BASE
giantOpeningFcn(hObject, handles);

% UIWAIT makes GIANT_BASE wait for user response (see UIRESUME)
% uiwait(handles.mainPanel);


% --- Outputs from this function are returned to the command line.
function varargout = GIANT_BASE_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close mainPanel.
function mainPanel_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to mainPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
%delete(hObject);

giantCloseRequestFcn(hObject, handles);

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function mainPanel_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to mainPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantWindowButtonUpFcn(hObject, handles);



% % % % % % % % % % % % % % % %
% % GIANT BASE UI FUNCTIONS % %
% % % % % % % % % % % % % % % %



% % FILE FUNCTIONS % %

% ONLY FUNCTION IN MENU
% --------------------------------------------------------------------
function menuSavePatientAs_Callback(hObject, eventdata, handles)
% hObject    handle to menuSavePatientAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantSavePatientAs(hObject, handles);

% --------------------------------------------------------------------
function open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuopen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantOpen(hObject, handles);

% --------------------------------------------------------------------
function savePatient_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to savePatient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantSavePatient(hObject, handles);

% --------------------------------------------------------------------
function saveAll_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to saveAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantSaveAll(hObject, handles);

% --------------------------------------------------------------------
function exportPatient_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to exportPatient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantExportPatient(hObject, handles);

% --------------------------------------------------------------------
function exportAllPatients_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuExportPatient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantExportAllPatients(hObject, handles);

% --------------------------------------------------------------------
function exportAsImage_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to exportAsImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantExportAsImage(hObject, handles);


% % EDIT FUNCTIONS % %


% --------------------------------------------------------------------
function undo_ClickedCallback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantUndo(hObject, handles);

% --------------------------------------------------------------------
function redo_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to redo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantRedo(hObject, handles);


% % PATIENT MANAGEMENT FUNCTIONS % %


% --------------------------------------------------------------------
function importPatientDirectory_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to importPatientDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantImportPatientDirectory(hObject, handles);

% --------------------------------------------------------------------
function addPatient_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to addPatient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantAddPatient(hObject, handles);

% --------------------------------------------------------------------
function addStudy_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuAddStudy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantAddStudy(hObject, handles);

% --------------------------------------------------------------------
function addSeries_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to addSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantAddSeries(hObject, handles);

% --------------------------------------------------------------------
function addFile_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to addFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantAddFile(hObject, handles);

% --------------------------------------------------------------------
function closePatient_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to closeAllPatients (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantClosePatient(hObject, handles);

% --------------------------------------------------------------------
function closeAllPatients_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to closeAllPatients (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantCloseAllPatients(hObject, handles);

% --------------------------------------------------------------------
function removeStudy_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to removeStudy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantRemoveStudy(hObject, handles);

% --------------------------------------------------------------------
function removeSeries_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to removeSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantRemoveSeries(hObject, handles);

% --------------------------------------------------------------------
function removeFile_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to removeFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantRemoveFile(hObject, handles);

% --------------------------------------------------------------------
function previousSeries_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to previousSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantPreviousSeries(hObject, handles);

% --------------------------------------------------------------------
function nextSeries_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to nextSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantNextSeries(hObject, handles);

% --------------------------------------------------------------------
function earlierImage_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to earlierImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantEarlierImage(hObject, handles);

% --------------------------------------------------------------------
function laterImage_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to laterImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantLaterImage(hObject, handles);

% --------------------------------------------------------------------
function earliestImage_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to earliestImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantEarliestImage(hObject, handles);

% --------------------------------------------------------------------
function latestImage_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to latestImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantLatestImage(hObject, handles);

% --------------------------------------------------------------------
function resetImage_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to resetImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

giantResetImage(hObject, handles);


% % DROP-DOWN SELECTORS % %


% --- Executes on selection change in patientSelector.
function patientSelector_Callback(hObject, eventdata, handles)
% hObject    handle to patientSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns patientSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from patientSelector

giantPatientSelector(hObject, handles);

% --- Executes during object creation, after setting all properties.
function patientSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to patientSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in studySelector.
function studySelector_Callback(hObject, eventdata, handles)
% hObject    handle to studySelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns studySelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from studySelector

giantStudySelector(hObject, handles);

% --- Executes during object creation, after setting all properties.
function studySelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to studySelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in seriesSelector.
function seriesSelector_Callback(hObject, eventdata, handles)
% hObject    handle to seriesSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns seriesSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from seriesSelector

giantSeriesSelector(hObject, handles);

% --- Executes during object creation, after setting all properties.
function seriesSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seriesSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

                    % % % % % % % % % % % % % % % % %
                    % % MODULE SPECIFIC FUNCTIONS % %
                    % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 



% % % % % % % % % % % % %
% % ACTION CALLBACKS  % %
% % % % % % % % % % % % %


% --------------------------------------------------------------------
function generalAccept_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to generalAccept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

func = get(handles.generalAccept, 'UserData');

switch func
    otherwise
        warning('Invalid UserData setting for generalAccept');
end



% --------------------------------------------------------------------
function generalDecline_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to generalDecline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

func = get(handles.generalAccept, 'UserData');

switch func
    otherwise
        warning('Invalid UserData setting for generalDecline');
end



% % % % % % % % % % % % %
% % TOGGLE CALLBACKS  % %
% % % % % % % % % % % % %






% % % % % % % % % % % %
% % MENU CALLBACKS  % %
% % % % % % % % % % % %




% these simply call their clickable toolbar counterparts



% MENU FILE CALLBACKS



% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menuOpen_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

open_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuSavePatient_Callback(hObject, eventdata, handles)
% hObject    handle to menuSavePatient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

savePatient_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuSaveAll_Callback(hObject, eventdata, handles)
% hObject    handle to menuSaveAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveAll_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuExportPatient_Callback(hObject, eventdata, handles)
% hObject    handle to menuExportPatient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

exportPatient_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuExportAllPatients_Callback(hObject, eventdata, handles)
% hObject    handle to menuExportAllPatients (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

exportAllPatients_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuExportAsImage_Callback(hObject, eventdata, handles)
% hObject    handle to menuExportAsImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

exportAsImage_ClickedCallback(hObject, eventdata, handles);



% MENU PATIENT MANAGMENT CALLBACKS



% --------------------------------------------------------------------
function menuPatientManagement_Callback(hObject, eventdata, handles)
% hObject    handle to menuPatientManagement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menuImportPatientDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to menuImportPatientDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

importPatientDirectory_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuAddPatient_Callback(hObject, eventdata, handles)
% hObject    handle to menuAddPatient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addPatient_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuAddStudy_Callback(hObject, eventdata, handles)
% hObject    handle to menuAddStudy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addStudy_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuAddSeries_Callback(hObject, eventdata, handles)
% hObject    handle to menuAddSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addSeries_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuAddFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuAddFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addFile_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuClosePatient_Callback(hObject, eventdata, handles)
% hObject    handle to menuClosePatient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closePatient_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuCloseAllPatients_Callback(hObject, eventdata, handles)
% hObject    handle to menuCloseAllPatients (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closeAllPatients_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuRemoveStudy_Callback(hObject, eventdata, handles)
% hObject    handle to menuRemoveStudy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

removeStudy_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuRemoveSeries_Callback(hObject, eventdata, handles)
% hObject    handle to menuRemoveSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

removeSeries_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuRemoveFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

removeFile_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuPreviousSeries_Callback(hObject, eventdata, handles)
% hObject    handle to menuPreviousSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

previousSeries_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuNextSeries_Callback(hObject, eventdata, handles)
% hObject    handle to menuNextSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nextSeries_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuEarlierImage_Callback(hObject, eventdata, handles)
% hObject    handle to menuEarlierImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

earlierImage_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuLaterImage_Callback(hObject, eventdata, handles)
% hObject    handle to menuLaterImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

laterImage_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuEarliestImage_Callback(hObject, eventdata, handles)
% hObject    handle to menuEarliestImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

earliestImage_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuLatestImage_Callback(hObject, eventdata, handles)
% hObject    handle to menuLatestImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

latestImage_ClickedCallback(hObject, eventdata, handles);



% MENU EDIT CALLBACKS



% --------------------------------------------------------------------
function menuEdit_Callback(hObject, eventdata, handles)
% hObject    handle to menuEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menuUndo_Callback(hObject, eventdata, handles)
% hObject    handle to menuUndo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

undo_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuRedo_Callback(hObject, eventdata, handles)
% hObject    handle to menuRedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

redo_ClickedCallback(hObject, eventdata, handles);



% MENU TOOLS CALLBACKS



% --------------------------------------------------------------------
function menuTools_Callback(hObject, eventdata, handles)
% hObject    handle to menuTools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menuResetImage_Callback(hObject, eventdata, handles)
% hObject    handle to menuResetImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

resetImage_ClickedCallback(hObject, eventdata, handles);



% MENU VIEW (TOGGLE) CALLBACKS



% --------------------------------------------------------------------
function menuView_Callback(hObject, eventdata, handles)
% hObject    handle to menuView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function varargout = OGDM_EnterData(varargin)
% OGDM_ENTERDATA MATLAB code for OGDM_EnterData.fig
%  8/2/13 copied from V2 for V3
%      OGDM_ENTERDATA, by itself, creates a new OGDM_ENTERDATA or raises the existing
%      singleton*.
%
%      H = OGDM_ENTERDATA returns the handle to a new OGDM_ENTERDATA or the handle to
%      the existing singleton*.
%
%      OGDM_ENTERDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OGDM_ENTERDATA.M with the given input arguments.
%
%      OGDM_ENTERDATA('Property','Value',...) creates a new OGDM_ENTERDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OGDM_EnterData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OGDM_EnterData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OGDM_EnterData

% Last Modified by GUIDE v2.5 30-Apr-2012 14:12:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OGDM_EnterData_OpeningFcn, ...
                   'gui_OutputFcn',  @OGDM_EnterData_OutputFcn, ...
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


% --- Executes just before OGDM_EnterData is made visible.
function OGDM_EnterData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OGDM_EnterData (see VARARGIN)

% Choose default command line output for OGDM_EnterData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OGDM_EnterData wait for user response (see UIRESUME)
% uiwait(handles.OGDM_EnterData);

% Set the number of rows to display based on nSims
hMainGUI = getappdata(0,'hMainGUI');
nSims = getappdata(hMainGUI, 'nSims');
sFishID_tmp = cell(nSims,1);
%sFishID_tmp{1,1} = 'ID 1';
nVtgConc_tmp = cell(nSims,1);
for iCell = 1:nSims
    sID = strcat('ID ', num2str(iCell));
    sFishID_tmp{iCell,1} = sID;
end    %for iCell
DataTableSize = cat(2, sFishID_tmp, nVtgConc_tmp);
%colfmt = {'char','numeric'};  %9/25/12 KHW
hEnterDataTable = findobj('Tag', 'uiEnterDataTable');
set (hEnterDataTable, 'Data', DataTableSize);



% --- Outputs from this function are returned to the command line.
function varargout = OGDM_EnterData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in uiEnterData_Done.
function uiEnterData_Done_Callback(hObject, eventdata, handles)
% hObject    handle to uiEnterData_Done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%hMainGUI = getappdata(0, 'hMainGUI');
%fhReturnToInputGUI = getappdata(hMainGUI, 'fhReturnToInputGUI');

% KHWS open a dialog box for user to double check entered data

% Get handle to OGDM_MainGUI - 5/2/12 delete line below?? handle hMainGUI above
%hOGDM_MainGUI = findobj ('Tag', 'OGDM_MainGUI');

%Create a dialog box to display the entered data for user to check
  hVerifyDataDlg = dialog('WindowStyle', 'modal',...
    'Name', 'Confirm Data Entered',...
    'Color', [1 0.95 0.87]);

  hsDataOK = uicontrol('Style', 'text',...
    'String', 'Check data, then click OK to save or Return to re-enter data',...
    'FontSize', 14,...               % KHW 12/24/15 reduced from 16 for PC
    'Position', [20 350 500 50],...
    'BackgroundColor', [1 0.95 0.87]);

% Modify appearance of push button to look like GUIDE buttons - khw 5/1/12
  huiOK = uicontrol ('Tag', 'OKbutton',...
    'String', ' OK',...
    'FontSize', 16,...
    'Position', [150 40 100 25],...
    'BackgroundColor', [0.76 0.87 0.76],...
    'TooltipString', 'Click here to accept data',...
    'Callback', {@OKbutton_Callback});

% Modify appearance of push button to look like GUIDE buttons - khw 5/1/12
  huiReturn = uicontrol ('Tag', 'uiReturn',...
    'String', ' Return',...
    'FontSize', 16,...
    'Position', [350 40 100 25],...
    'BackgroundColor', [0.93 0.84 0.84],...
    'TooltipString', 'Click here to return to data entry table',...
    'Callback', 'close(gcbf)');

%Get the handle of the table where data was entered
  hEnteredData = findobj('Tag', 'uiEnterDataTable');
%dat = rand(2)
%disp('in uiEnterData_Done_Callback')
  dat = get(hEnteredData, 'Data');  % get(handle, "PropertyName')

cnames = {'Fish ID', 'Vtg Conc (nmol/uL)'};
hEnteredDataTable = uitable('Position', [175 75 220 300],...
    'ColumnName', cnames,...
    'FontSize', 14,...
    'BackgroundColor', [1 1 1],...
    'Data', dat);


function OKbutton_Callback(source, eventdata)

% Get handle to OGDM_MainGUI
hMainGUI = getappdata(0, 'hMainGUI');
%hInputGUI = getappdata(hMainGUI, 'hInputGUI');

% Get the handle of the table where data was entered
hEnteredData = findobj('Tag', 'uiEnterDataTable');
dat = get(hEnteredData, 'Data');
% dat is a cell array of values; convert to matrix khw 5/8/12; done 5/25/12
%disp('in OGDM_EnterData; converting cell array to matrix')
vecVtgConcToSim = cell2mat(dat(:,2));   %9/25/12

 % Store FishIDs as strings; allow ID = alphanumeric
sFishID = dat(:,1); 
%disp('in OGDM_EnterData - OK button')
%disp(matVtgConcToSim)
%disp(sFishID)    %KHW 9/25/12

setappdata(hMainGUI, 'vecVtgConcToSim', vecVtgConcToSim);
setappdata(hMainGUI, 'sFishID', sFishID);

% KHW 5/25/12 can delete debugging statements below
%disp('in OGDM_EnterData')
%matVtgConcToSim = getappdata(hMainGUI, 'matVtgConcToSim')

% Make OGDM_inputGUI the current figure
figure(hMainGUI);

% Close the figure whose uicontrol called this fcn
close(gcbf);
close('OGDM_EnterData');


% --- Executes on button press in uiEnterData_Reset.
function uiEnterData_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to uiEnterData_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGUI = getappdata(0,'hMainGUI');
nSims = getappdata(hMainGUI, 'nSims');
tablesize = cell(nSims,2);
hEnterDataTable = findobj('Tag', 'uiEnterDataTable');
set (hEnterDataTable, 'Data', tablesize);



% --- Executes on button press in uiEnterData_Exit.
function uiEnterData_Exit_Callback(hObject, eventdata, handles)
% hObject    handle to uiEnterData_Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiwait(warndlg('Pressing OK will exit the OGDM', 'Confirm Quit','modal'));
hMainGUI = getappdata(0, 'hMainGUI');
close(hMainGUI);
close(gcbf);

function varargout = OGDM_welcome(varargin)
% Oocyte Growth Dynamics Model m-file for OGDM_welcome.fig
%  12/24/15 cleaned up for distribution
%  8/2/13 copied from V2 for V3
%    Oocyte Growth Dynamics Model
%    Version 3.0, 2014
%    Coded for Matlab by Karen H. Watanabe, August 2011
%      based on Li et al. (2011), Canadian Journal of Fisheries and
%      Aquatic Sciences.
%      April 2012 - version 2.0
%    Contatct information:
%      Karen H. Watanabe, Ph.D.
%      School of Public Health
%      Oregon Health & Science University
%      3181 SW Sam Jackson Park Road
%      Portland, OR 97239
%      Ph. 503.346.3433    Email: watanabk@ohsu.edu
%    
% OGDM_WELCOME MATLAB code for OGDM_welcome.fig
%      OGDM_WELCOME, by itself, creates a new OGDM_WELCOME or raises the existing
%      singleton*.
%
%      H = OGDM_WELCOME returns the handle to a new OGDM_WELCOME or the handle to
%      the existing singleton*.
%
%      OGDM_WELCOME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OGDM_WELCOME.M with the given input arguments.
%
%      OGDM_WELCOME('Property','Value',...) creates a new OGDM_WELCOME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OGDM_welcome_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OGDM_welcome_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OGDM_welcome

% Last Modified by GUIDE v2.5 04-Oct-2012 11:15:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OGDM_welcome_OpeningFcn, ...
                   'gui_OutputFcn',  @OGDM_welcome_OutputFcn, ...
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


% --- Executes just before OGDM_welcome is made visible.
function OGDM_welcome_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OGDM_welcome (see VARARGIN)

% Choose default command line output for OGDM_welcome
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OGDM_welcome wait for user response (see UIRESUME)
% uiwait(handles.OGDM_welcome);
gui_welcome_table = [1 0 75 0
2 0 0 200
3 150 0 0
4 0 0 0
5 0 95 0
6 0 0 0
7 123 0 0
8 0 0 0
9 20 0 165
10 117 85 0];
hTable1 = findobj('Tag', 'uitable1');
set (hTable1, 'Data', gui_welcome_table);

% setappdata(0  , 'hWelcomeGUI'    , gcf);


% --- Outputs from this function are returned to the command line.
function varargout = OGDM_welcome_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in uiWelcomeContinue.
function uiWelcomeContinue_Callback(~, ~, ~)
% hObject    handle to uiWelcomeContinue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OGDM_MainGUI;

% KHWS 4/26/12: Make OGDM_WelcomeGUI the current figure
hWelcomeGUI = gcbf;
% Close hWelcomeGUI
close(hWelcomeGUI);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over uiWelcomeContinue.


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over uiWelcomeContinue.
function uiWelcomeContinue_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uiWelcomeContinue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in uiCheckEULA.
function uiCheckEULA_Callback(hObject, eventdata, handles)
% hObject    handle to uiCheckEULA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uiCheckEULA



% --- Executes on button press in uiWelcomeEULA.
function uiWelcomeEULA_Callback(hObject, eventdata, handles)
% hObject    handle to uiWelcomeEULA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OGDM_EULA;


% --- Executes on button press in uiWelcomeGUI_exit.
function uiWelcomeGUI_exit_Callback(hObject, eventdata, handles)
% hObject    handle to uiWelcomeGUI_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  uiwait(warndlg('Pressing OK will exit the OGDM', 'Confirm Quit','modal'));
    close(gcbf);

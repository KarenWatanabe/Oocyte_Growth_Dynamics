function varargout = OGDM_EULA(varargin)
% Oocyte Growth Dynamics Model m-file for OGDM_EULA.fig
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
% OGDM_EULA MATLAB code for OGDM_EULA.fig
%      OGDM_EULA, by itself, creates a new OGDM_EULA or raises the existing
%      singleton*.
%
%      H = OGDM_EULA returns the handle to a new OGDM_EULA or the handle to
%      the existing singleton*.
%
%      OGDM_EULA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OGDM_EULA.M with the given input arguments.
%
%      OGDM_EULA('Property','Value',...) creates a new OGDM_EULA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OGDM_EULA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OGDM_EULA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OGDM_EULA

% Last Modified by GUIDE v2.5 30-Apr-2012 13:34:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OGDM_EULA_OpeningFcn, ...
                   'gui_OutputFcn',  @OGDM_EULA_OutputFcn, ...
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


% --- Executes just before OGDM_EULA is made visible.
function OGDM_EULA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OGDM_EULA (see VARARGIN)

% Choose default command line output for OGDM_EULA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OGDM_EULA wait for user response (see UIRESUME)
% uiwait(handles.OGDM_EULA);


% --- Outputs from this function are returned to the command line.
function varargout = OGDM_EULA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function uiMainContinue_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uiMainContinue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in uiCheckEULA.
function uiCheckEULA_Callback(hObject, eventdata, handles)
% hObject    handle to uiCheckEULA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uiCheckEULA


% --- Executes on button press in uiEULA_accept.
function uiEULA_accept_Callback(hObject, eventdata, handles)
% hObject    handle to uiEULA_accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Return to OGDM_WelcomeGUI and close OGDM_EULA
% Get handle to OGDM_WelcomeGUI
% khws 4/26/12
  hfigure = gcbf;
  hOGDM_welcomeGUI = findobj ('Tag', 'OGDM_welcomeGUI');
  figure(hOGDM_welcomeGUI);
  close (hfigure);
  

% --- Executes on button press in uiEULA_exit.
function uiEULA_exit_Callback(hObject, eventdata, handles)
% hObject    handle to uiEULA_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Create a msgbox with 'yes' or 'no' buttons
  uiwait(warndlg('Pressing OK will exit the OGDM', 'Confirm Quit','modal'));
    hOGDM_welcomeGUI = findobj ('Tag', 'OGDM_welcomeGUI');
    close(hOGDM_welcomeGUI);
    close(gcbf);

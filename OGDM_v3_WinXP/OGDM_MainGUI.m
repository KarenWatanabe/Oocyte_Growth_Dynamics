function varargout = OGDM_MainGUI(varargin)
% 8/2/13 copied from V2 for V3
% OGDM_MAINGUI MATLAB code for ogdm_maingui.fig
%      OGDM_MAINGUI, by itself, creates a new OGDM_MAINGUI or raises the existing
%      singleton*.
%
%      H = OGDM_MAINGUI returns the handle to a new OGDM_MAINGUI or the handle to
%      the existing singleton*.
%
%      OGDM_MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OGDM_MAINGUI.M with the given input arguments.
%
%      OGDM_MAINGUI('Property','Value',...) creates a new OGDM_MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OGDM_MainGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OGDM_MainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ogdm_maingui

% Last Modified by GUIDE v2.5 30-Apr-2012 14:15:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OGDM_MainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @OGDM_MainGUI_OutputFcn, ...
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


% --- Executes just before ogdm_maingui is made visible.
function OGDM_MainGUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ogdm_maingui (see VARARGIN)

% Choose default command line output for ogdm_maingui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

setappdata(0  , 'hMainGUI'    , gcf);
% UIWAIT makes ogdm_maingui wait for user response (see UIRESUME)
% uiwait(handles.ogdm_maingui);
% khw 4/26/12 hMainGUI = getappdata (0, 'hMainGUI');
% khw 4/26/12 setappdata(hMainGUI, 'hInputGUI', gcf);
%setappdata(hMainGUI, 'fhReturnToInputGUI', @ReturnToInputGUI);


% --- Outputs from this function are returned to the command line.
function varargout = OGDM_MainGUI_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function uiNSims_Callback(hObject, ~, ~)
% hObject    handle to uiNSims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uiNSims as text
%        str2double(get(hObject,'String')) returns contents of uiNSims as a double
hMainGUI = getappdata(0,   'hMainGUI');
nSims = str2double(get(hObject, 'string'));
 if isnan(nSims)
     errordlg('You must enter an integer', 'Re-enter Data', 'replace')
     return
 end
 
 setappdata(hMainGUI, 'nSims', nSims);


% --- Executes during object creation, after setting all properties.
function uiNSims_CreateFcn(hObject, ~, ~)
% hObject    handle to uiNSims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function uiNSimLength_Callback(hObject, ~, ~)
% hObject    handle to uiNSimLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uiNSimLength as text
%        str2double(get(hObject,'String')) returns contents of uiNSimLength as a double
hMainGUI = getappdata(0,   'hMainGUI');
nSimLength = str2double(get(hObject, 'string'));
 if isnan(nSimLength)
     errordlg('You must enter an integer', 'Re-enter Data', 'replace')
     return
 end
 
 setappdata(hMainGUI, 'nSimLength', nSimLength);

% --- Executes during object creation, after setting all properties.
function uiNSimLength_CreateFcn(hObject, ~, ~)
% hObject    handle to uiNSimLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in uiUploadData.
function uiUploadData_Callback(~, ~, ~)
% hObject    handle to uiUploadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
hMainGUI = getappdata(0, 'hMainGUI');
nSims = getappdata(hMainGUI, 'nSims');
% Allow user to search a directory for text files
[sFileName, sPathName, FilterIndex] = uigetfile('*.txt', 'Select a Text File to Open');

%Assign FileName and PathName to hMainGUI so that it's accessible to other GUI fcns
setappdata(hMainGUI, 'PathName', sPathName);
setappdata(hMainGUI, 'FileName', sFileName);

%Import data from text file (Required format: header line (fishID\tVtg Conc
%(nmol/uL) followed by data.
%Read all data for now; restrict # of simulations to nsims

%matVtgConc_tmp = importdata(sFileName);
finput = fopen(sFileName);


% 9/25/12 use textscan to put Fish IDs into a cell array and plasma vtg
% conc into a numeric vector?

% Read nSims lines from sFileName, excluding the first line of col headers
% textscan will create matVtgConc_tmp as a 1x2 cell array
%  matVtgConc_tmp{1} = {'FishID1'; 'FishID2'; 'FishID3'; etc}
%  matVtgConc_tmp{2} = [0.01; 0.13; 0.02; etc]
matVtgConc_tmp = textscan(finput,'%s %f32', nSims, 'HeaderLines', 1); 
fclose(finput);

%khws 5/4/12 - setappdata(hMainGUI, 'matVtgConc', matVtgConc_tmp);
%  matVtgConc.textdata contains header line text
%  matVtgConc.data contains data

%Create a dialog box to display the entered data for user to check
hVerifyDataDlg = dialog('WindowStyle', 'modal',...
    'Name', 'Confirm Data Entered',...
    'Color', [1 0.95 0.87]);

hsDataOK = uicontrol('Style', 'text',...
    'String', 'Check data, then click OK to store data or return to data entry',...
    'FontSize', 16,...
    'Position', [20 350 500 50],...
    'BackgroundColor', [1 0.95 0.87]);

% Modify appearance of push button to look like GUIDE buttons - khw 5/1/12
% OK button should make Run model button active; or open separate Run model
% dialog box w/ 'Run model' push button
huiOK = uicontrol ('Tag', 'OKbutton',...
    'String', ' OK',...
    'FontSize', 16,...
    'Position', [150 40 100 25],...
    'BackgroundColor', [0.76 0.87 0.76],...
    'TooltipString', 'Click here to accept data',...
    'Callback', 'close(gcbf)');

% Modify appearance of push button to look like GUIDE buttons - khw 5/1/12
% khw 5/8/12 Reload button should return to mainGUI; Run Model button
% inactive
huiReload = uicontrol ('Tag', 'uiReloadButton',...
    'String', ' Reload',...
    'FontSize', 16,...
    'Position', [350 40 100 25],...
    'BackgroundColor', [0.93 0.84 0.84],...
    'TooltipString', 'Click here to return to select a different data file',...
    'Callback', {@ReloadButton_Callback});
% khw 5/4/12 - ReloadButton_Callback function to clear matrix of Vtg Conc?

% Display data from imported text file
% **** before displaying imported data, limit number of sims to nsims ***

%disp ('in OGDM_MainGUI - uiUploadData_Callback')

% Next two lines work when importing data with importdata function
%matVtgConcToSim = matVtgConc_tmp.data(1:nSims,1:2);
%vecVtgConcToSim = matVtgConc_tmp.data(1:nSims,2);

% Store FishIDs as strings; allow ID = alphanumeric
%sFishID = matVtgConc_tmp.data(1:nSims,1); 
sFishID = matVtgConc_tmp{1};
vecVtgConcToSim = matVtgConc_tmp{2};  
matVtgConcToSim = matVtgConc_tmp;

setappdata(hMainGUI, 'matVtgConcToSim', matVtgConcToSim);
setappdata(hMainGUI, 'vecVtgConcToSim', vecVtgConcToSim);
setappdata(hMainGUI, 'sFishID', sFishID);

% Create a cell array that can be display in uitable
% THIS DOESN'T WORK
%for iCell = 1:nSims
%    sFishID_tmp {iCell,1} = sFishID{iCell}
%end    %for iCell
%tabledata = cat(2, sFishID_tmp, vecVtgConcToSim)

for i = 1:nSims
tabledata{i,1} = sFishID{i};
tabledata{i,2} = vecVtgConcToSim(i);
end


cnames = {'Fish ID', 'Vtg Conc (nmol/uL)'};
hEnteredDataTable = uitable('Position', [175 75 220 300],...
    'ColumnFormat', {'char', 'numeric'},...
    'ColumnName', cnames,...
    'FontSize', 14,...
    'BackgroundColor', [1 1 1],...
    'Data', tabledata);

%clear matVtgConc_tmp;  khw 5/8/12 not needed; automatically cleared when
%fcn ends?

% *****KHW 8/13/12 - delete this section?? ******
%  OKbutton Callback not needed for huiOK - use close(gcbf)

%function OKbutton_Callback(source, eventdata)
% hMainGUI = getappdata(0, 'hMainGUI');
% matVtgConc = getappdata(hMainGUI, 'matVtgConc');
% nSims = getappdata(hMainGUI, 'nSims');
 %  modify setappdata command for nsims specified by user
% matVtgConcToSim = matVtgConc.data(1:nSims,1:2);
% setappdata(hMainGUI, 'matVtgConcToSim', matVtgConcToSim);
 
% Make OGDM_inputGUI the current figure
%figure(hMainGUI);

% Close the figure whose uicontrol called this fcn
%close(gcbf);


function ReloadButton_Callback(source, eventdata)
hMainGUI = getappdata(0, 'hMainGUI');
%remove data that was uploaded previously; appdata (rmappdata) and workspace data
%(clear)
%matVtgConcToSim = getappdata(hMainGUI, 'matVtgConcToSim')
if isappdata(hMainGUI, 'matVtgConcToSim')
    %disp('matVtgConcToSim is appdata')
    rmappdata(hMainGUI, 'matVtgConcToSim');  % this works 5/8/12
end
close(gcbf);



% --- Executes on button press in uiEnterData.
function uiEnterData_Callback(~, ~, ~)
% hObject    handle to uiEnterData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OGDM_EnterData;


% --- Executes on button press in uiRunModel.
function uiRunModel_Callback(~, ~, ~)
% hObject    handle to uiRunModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global INPUT RESULTS

% KHW 8/22/13 - moved INPUT structure definition here
% KHW 6/2/12 - define INPUT structure in MainGUI.m? YES!! (8/15/12)

INPUT = struct ('VtgAbsRate', 1.0,...   % 1/hr, assumed
    'OvaryVtgConc', 0.1,...         % nmol/uL - is this needed/used???
    'OogoniaVol', 5.2e-07,...       % uL - calculated from Leino et al. (2005)
    'OocyteToVtgMass', 3.0,...      %
    'SpawnVol', 0.52,...            % uL
    'c_ova_vtg_Unexposed', 0.1,...  % nmol/uL, pre-exposure conc
    'c_ova_vtg_ExpoEnd', 0.1,...    % nmol/uL, post-exposure conc
    'InitGroupSize', 0,...          % ??
    't_sim__RecruitTime', 0,...     % recruit time (hr) for one clutch
    'n_ooc__Generated', 0,...       % number of oocytes in one clutch
    'RecruitTime', [],...           % vec of oogonia recruitment times (hr)
    'nOocGenerated', [],...         % vec of clutch sizes
    't_sim__Start', 0,...           % simulation start time (hrs)
    't_sim__End', 3000,...          % default end time in hrs (=125 days)
    't_sim__ExpoStart', 1944,...    % 7/3/14 time (hr) plasma vtg changes to exposed vtg conc
    't_sim__PrintInt', 24);         % print interval time (hrs)


hMainGUI = getappdata(0, 'hMainGUI');
vecVtgConcToSim = getappdata(hMainGUI, 'vecVtgConcToSim');
nSims = getappdata (hMainGUI, 'nSims');
nSimLength = getappdata(hMainGUI,'nSimLength');     %khw 6/12/14
sFishID = getappdata(hMainGUI, 'sFishID');
disp('Running oocyte growth dynamics model V3')
%disp(sFishID)
%iscellstr(sFishID{1})
%isnumeric(sFishID{1})
%disp(vecVtgConcToSim)       %7/7/14 made into comment
%isnumeric(vecVtgConcToSim)

%disp(matVtgConcToSim)  %KHW 5/30/12
%msgbox('Sorry OGDM code is under construction','Code not yet available', 'modal')

arr_AllResults(nSims) = struct('TotEggSpawned', 0,...
    'TotSimEggSpawned', 0,...  %7/16/14 KHW
    'nSpawns', 0,...
    'nSpawnsSim', 0,...        % 7/19/14 KHW
    'SpawnTimes',[],...
    'ClutchSize', [],...
    'SpawnInt',[],...
    'tGrowth', []);

arr_ClutchSizeSummary = zeros(nSimLength+81,nSims+1);  %6/12/14 KHW

% Set

% Check for existing output files (OGDM_OocMassVol.txt and ResultsSummary)
%    and delete
if exist('OGDM_OocMassVol.csv', 'file') == 2
    delete ('OGDM_OocMassVol.csv');
end    %if exist

if exist('OGDM_ResultsSummary_1.csv', 'file') == 2
    delete('OGDM_ResultsSummary_*.csv');
end    % if exist

% 10/1/13 added code to print SpawningSummary.txt output (from V2a)
if exist('OGDM_SpawningSummary.txt', 'file') == 2
    delete ('OGDM_SpawningSummary.txt');
end    %if exist

% 6/12/14 khw code to print clutch sizes for each fish simulated
if exist('OGDM_ClutchSizeSummary.txt', 'file') == 2
    delete ('OGDM_ClutchSizeSummary.txt');
end    %if exist


fid2 = fopen ('OGDM_SpawningSummary.txt', 'w');
fprintf(fid2, 'Simulation#\t');
fprintf(fid2, '# Spawns\t');
fprintf(fid2, 'Total Eggs Spawned\t');
fprintf(fid2, 'Eggs Spawned in %5i days\t', nSimLength);
fprintf(fid2, '# Spawns in %5i days\n', nSimLength);

for nSimCount = 1:nSims     % nSims fish to be simulated (multiple clutches per fish)
    % 8/15/12 move INPUT structure definition to *_MainGUI.m, then
    % assign plasma vtg conc from user input
    INPUT.c_ova_vtg_ExpoEnd = vecVtgConcToSim(nSimCount);
    
    arr_AllResults(nSimCount) = OGDM_RunModel; % KHW 8/13/12
    
    %fprintf('in _MainGUI - nSimCount = %3i\n', nSimCount)
    %disp(arr_AllResults(nSimCount).TotEggSpawned)
    %disp(arr_AllResults(nSimCount).nSpawns)
    %disp(arr_AllResults(nSimCount).SpawnTimes)
    %disp(arr_AllResults(nSimCount).ClutchSize)
    %disp(arr_AllResults(nSimCount).SpawnInt)
    %disp(arr_AllResults(nSimCount).tGrowth)

    % Print results to comma delimited text files

    % Convert nSimCount to a character for string concatenation
    % for each fish simulated print summary results
    % KHW 8/22/13 changed output file extension to *.csv
    sSimCount = num2str(nSimCount);
    sResultsSummary = strcat('OGDM_ResultsSummary_',sSimCount, '.csv');
    fid1 = fopen (sResultsSummary, 'w');
  
    %disp(sfishID)
    fprintf(fid1, 'Fish simulation: # %-4i, ', nSimCount);
    fprintf(fid1, 'Fish ID: %-12s, ', sFishID{nSimCount});
    fprintf(fid1, 'Plasma Vtg Conc simulated (nmol/uL) =, %8.2g\n',...
        vecVtgConcToSim(nSimCount));  %9/11/14 KHW added ","
    %fprintf(fid1, 'Fish simulation # = %4i\tFish ID %-10s\n', nSimCount, sfishID(nSimCount));
    fprintf(fid1, 'Total number of eggs spawned =,%-7.1f,', arr_AllResults(nSimCount).TotEggSpawned);
    fprintf(fid1, 'Total eggs spawned in %5i days =, %-7.1f\n',...
        nSimLength, arr_AllResults(nSimCount).TotSimEggSpawned);
    fprintf(fid1, 'Total number of spawns =, %-4.1f,', arr_AllResults(nSimCount).nSpawns);
    fprintf(fid1, 'Spawns in %5i days =, %-4.1f\n\n', nSimLength,...
        arr_AllResults(nSimCount).nSpawnsSim);
    % print column headers
    fprintf(fid1,'Recruit Time (d), Spawn Time (d), Growth Time (d), ');
    fprintf(fid1, 'Spawn Interval (d), Batch size, Clutch Size\n');
  
    %7/16/14 modify output times to be reported in days (t=0 is start of
    %user-specified simulation, negative times are pre-exposure start-up
    %vecSpawnDay = zeros(length(arr_AllResults(nSimCount).SpawnTimes));
    
    for nSpawns = 1:length(arr_AllResults(nSimCount).SpawnTimes) 
    % assign spawn times (d) to a vector only if spawning occurred
    if arr_AllResults(nSimCount).SpawnTimes(nSpawns) ~= 0
      SpawnDay = round((arr_AllResults(nSimCount).SpawnTimes(nSpawns)-1944)/24);
    else
      SpawnDay = 0;
    end     % if arr_AllResults
    
      fprintf(fid1, '%-8.1f, %-8.1f, %-7.1f, %-7.1f, %-5i, %-5i\n',...
        round((INPUT.RecruitTime(nSpawns)-1944)/24),...
        SpawnDay,...
        round(arr_AllResults(nSimCount).tGrowth(nSpawns)/24),...
        round(arr_AllResults(nSimCount).SpawnInt(nSpawns)/24),...
        INPUT.nOocGenerated(nSpawns),...
        arr_AllResults(nSimCount).ClutchSize(nSpawns));
    end    %for nSpawns
    
    % 7/16/14 remove from OGDM_ResultsSummary output file
    %fprintf(fid1, '\nOocyte Growth Rates for Batch of Oocytes\n');
    %fprintf(fid1, 'Time (hr), Oocyte Vol (uL)\n');
    
    %for nTimes = 1:length(RESULTS.tspan)
      %fprintf(fid1, '%-8.1f, ', RESULTS.tspan(nTimes));
      
      %for nClutch = 1:length(INPUT.nOocGenerated)  
        %fprintf(fid1, '%-8.2g, ', RESULTS.v_ooc__OocyteVol(nTimes, nClutch));
      %end    %for nClutch
      
      %fprintf(fid1, '\n');
    %end    %for nTimes 
    % 7/16/14 end of lines removed from ResultsSummary output file
  
    %for jGroup = 1:arr_AllResults(nSims).nSpawns  %print results for multiple fish
      %sGroupCount = num2str(jGroup);
      %sGrowthVTime = strcat('OGDM_GrowthVTime_', sSimCount,'_', sGroupCount, '.txt');
      %fid2 = fopen (sGrowthVTime);
    %end  %for jGroup
    
    fclose(fid1);
    
    % print SpawningSummary output file: sim#, total # spawns, total eggs spawned
    fprintf(fid2, '%-4i\t%-4.1f\t%-7.1f\t%-7.1f\t%-4.1f\n',...
      nSimCount, arr_AllResults(nSimCount).nSpawns,...
      arr_AllResults(nSimCount).TotEggSpawned,...
      arr_AllResults(nSimCount).TotSimEggSpawned,...
      arr_AllResults(nSimCount).nSpawnsSim);        %KHW 7/23/14
  
end    % for nSimCount

% 6/12/14 khw
% Print column headers in OGDM_ClutchSizeSummary.txt
fid3 = fopen('OGDM_ClutchSizeSummary.txt','w');
fprintf(fid3,'Time (d)\t');
for nSimCount = 1:nSims
    %sFish = sFishID{nSimCount};
    fprintf(fid3,'%-12s\t',sFishID{nSimCount});
end  %for nSimCount
fprintf(fid3,'\n');

% Add simulation day to first column of ClutchSizeSummary.txt
% 7/16/14 KHW - t<0 is pre-exposure (81 days prior to start of experiment
arr_ClutchSizeSummary(:,1) = transpose(-80:nSimLength);  %7/16/14 KHW

% Add clutch sizes for output to ClutchSizeSummary.txt
for nSimCount = 1:nSims
    SpawnDay = 0;
    for nSpawn = 1:length(arr_AllResults(nSimCount).SpawnTimes)
        if arr_AllResults(nSimCount).SpawnTimes(nSpawn) ~= 0
          % 7/17/14 sum all clutches spawned on the same day  
          SpawnDay = arr_AllResults(nSimCount).SpawnTimes(nSpawn)/24;
          arr_ClutchSizeSummary(round(SpawnDay),nSimCount+1) =...
              arr_ClutchSizeSummary(round(SpawnDay),nSimCount+1)+...
              arr_AllResults(nSimCount).ClutchSize(nSpawn);
        end  %end if
    end  % for nSpawn
end  %for nSimCount

% Print OGDM_ClutchSizeSummary.txt
dlmwrite('OGDM_ClutchSizeSummary.txt', arr_ClutchSizeSummary, '-append','delimiter','\t');

fprintf ('OGDM Simulations done\n');  %KHW 9/11/14

fclose(fid2);
fclose(fid3);   %6/12/14 KHW


% --- Executes on button press in uiMainGUI_Exit.
function uiMainGUI_Exit_Callback(hObject, eventdata, handles)
% hObject    handle to uiMainGUI_Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% *** Create a msgbox with 'yes' or 'no' buttons ***
uiwait(warndlg('Pressing OK will exit the OGDM', 'Confirm Quit','modal'));
hMainGUI = getappdata(0, 'hMainGUI');
child_hMainGUI = allchild(hMainGUI);  % khws 4/30/12 is this really needed?
close(hMainGUI);

% --- Executes when user attempts to close ogdm_maingui.
function OGDM_MainGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to ogdm_maingui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);

%function ReturnToInputGUI
% Get handle of parent figure whose uicontrol is calling this fcn
%hFigure = gcf;

% Get handle to ogdm_maingui
%hMainGUI = getappdata(0, 'hMainGUI');
%hInputGUI = getappdata(hMainGUI, 'hInputGUI')

% Make ogdm_maingui the current figure
%figure(hInputGUI);

%Close the figure whose uicontrol called this fcn
%close(hFigure);

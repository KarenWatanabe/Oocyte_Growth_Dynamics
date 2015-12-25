function Output = OGDM_RunModel()
% 12/24/15 cleaned up for distribution
% 8/2/13 Copied from V2 for V3

global INPUT RESULTS

RESULTS = struct('n_sim__GroupCount', 0,... % total # groups simulate
    'n_ooc__Inside', 0,...          % num oocytes inside ovary (not spawned)
    'n_ooc__GroupsInside', 0,...    % num groups inside ovary (not spawned)
    'n_ooc__TotGroupSpawned', 0,... % total number of batches spawned
    'n_ooc__GroupSpawnedSim', 0,... % groups spawned in user-specified simulation period
    'n_ooc__TotEggSpawned', 0,...   % total number of eggs spawned
    'n_ooc__TotSimEggSpawned', 0,...% total eggs spawned during user-specified simulation period 7/16/14
    'n_ooc__EggSpawned', [],...     % vec clutch sizes (# oocytes/clutch)
    't_ooc__EggSpawned', [],...     % vec spawn times (hr)
    't_sim__SpawnInt',[],...        % vec - time interval (hrs) between spawns
    't_ooc__Growth',[],...          % vec - growth time for spawned clutches (KHW 8/22/13)
    'm_ooc_vtg_AbsAmt', [],...      % vec oocyte mass (fmol?) based on vtg absorbed (y(1)?)
    'v_ooc__OocyteVol', [],...      % vec oocyte volume (uL) at specified output times (y(2)?)    
    't_sim__OutputTimes', [],...    % vec stores tout from ODE45 command
    'tspan',[]);                    % vec of output times

Output = struct('TotEggSpawned', 0,...  % RESULTS.n_ooc_TotEggSpawned
    'TotSimEggSpawned', 0,...           % RESULTS.n_ooc__TotSimEggSpawned 7/16/14
    'nSpawns', 0,...                    % unique number of spawns
    'nSpawnsSim', 0,...                 % spawns during user-specified sim period 7/19/14
    'SpawnTimes', [],...                % .t_ooc_EggSpawned
    'ClutchSize', [],...                % .n_ooc__EggSpawned
    'SpawnInt', [],...                  % .t_sim__SpawnInt
    'tGrowth', []);                     % oocyte growth time (hr)

% fprintf('in OGDM_RunModel; GroupCount = %2i\n', RESULTS.n_sim__GroupCount)

hMainGUI = getappdata(0, 'hMainGUI');

nSimLength = getappdata(hMainGUI, 'nSimLength');  % days
INPUT.t_sim__End = nSimLength*24 + 1944;    % hrs, 7/3/14 added pre-exposure sim time

% values below from Li et al. (2011); KHW checked 9/20/12
mu_SI = 1.21;    % parameters from fitting FHM spawning interval data
sigma_SI = 0.57; 
LB_SI = 1.0;
UB_SI = 25.0;

mu_CS = 4.11;    % parameters from fitting FHM clutch size data
sigma_CS = 0.96;
LB_CS = 1;
UB_CS = 317;


% .RecruitTime = T0 (2160 hr) + TruncLogNormal() used in Li et al. 2011
%INPUT.RecruitTime = [2232 2352 2424 2496 2688];
%INPUT.RecruitTime = [0 127 199 271 463];    % format as a column vector

% Create vector of oocyte recruitment times (hrs) <= INPUT.t_sim_End

% Sample nSimLength values from the FHM spawning interval (days) distribution
%7/3/14 - added 81 to sample number for added pre-expo sim time(1944 h)
vec_SI = TruncLogNRnd(nSimLength+81, mu_SI, sigma_SI, LB_SI, UB_SI);
%disp ('Vector of spawn intervals (days)');
%disp(vec_SI);

% Create a vector of recruitment times (days) that are <= nSimLength + 81
% 7/3/14
%RecruitDay = zeros(nSimLength+81);
RecruitDay(1) = vec_SI(1);
for i = 2:nSimLength+81    % check recruitment times and save i for  
    RecruitDay(i) = RecruitDay(i-1) + vec_SI(i);
end    % for i

% truncate vector of recruitment days at largest value < nSimLength +81
% 7/3/14
RecruitDay = RecruitDay(RecruitDay < nSimLength+81);

% Multiply vector of recruitment days by 24 hrs/day and round values
INPUT.RecruitTime = round(RecruitDay*24);
%disp('Recruit Times (hr)');
%disp(INPUT.RecruitTime);

INPUT.nOocGenerated = round(TruncLogNRnd(length(INPUT.RecruitTime), mu_CS, sigma_CS, LB_CS, UB_CS));
%disp('Vector of batch sizes');
%disp(INPUT.nOocGenerated);

% Dimension RESULTS arrays
RESULTS.n_ooc__EggSpawned = zeros(length(INPUT.RecruitTime),1);
RESULTS.t_ooc__EggSpawned = zeros(length(INPUT.RecruitTime),1);
RESULTS.t_ooc__Growth = zeros(length(INPUT.RecruitTime),1);
RESULTS.t_sim__SpawnInt = zeros(length(INPUT.RecruitTime),1);

RESULTS.tspan = INPUT.t_sim__Start:INPUT.t_sim__PrintInt:INPUT.t_sim__End;
RESULTS.m_ooc_vtg_AbsAmt = zeros(length(RESULTS.tspan),length(INPUT.nOocGenerated));
RESULTS.v_ooc__OocyteVol = zeros(length(RESULTS.tspan),length(INPUT.nOocGenerated));
%RESULTS.t_ooc__OocyteVol = zeros(length(RESULTS.tspan),1); %8/15 DEL?=tspan
RESULTS.t_sim__OutputTimes = zeros(length(RESULTS.tspan),1); % stores tout (=tspan)

Output.SpawnTimes = zeros(length(INPUT.RecruitTime));
Output.ClutchSize = zeros(length(INPUT.RecruitTime));
Output.SpawnInt = zeros(length(INPUT.RecruitTime));
Output.tGrowth = zeros(length(INPUT.RecruitTime));

y0 = [0; INPUT.OogoniaVol];

for jCount = 1:length(INPUT.RecruitTime)    % simulates multiple batches
%for jCount = 1:1  %KHW 8/16/12
  INPUT.n_ooc__Generated = INPUT.nOocGenerated(jCount);
  INPUT.t_sim__RecruitTime = INPUT.RecruitTime(jCount);
  
  OGDMoptions = odeset('OutputFcn', @OGDM_OutputFcn,...
      'RelTol', 1e-3, 'AbsTol', 1e-10);  %7/7/14 decrease AbsTol
  [tout yout] = ode45(@OGDM_ODE, RESULTS.tspan, y0, OGDMoptions);
  
  % Concatenate zeroes to end of yout to match # rows in RESULTS???
  
  
  % FIX dimension mismatch since integration stops when oocytes spawn 8/31/12
  for mCount = 1:length(tout)
      
   RESULTS.m_ooc_vtg_AbsAmt(mCount,jCount) = yout(mCount,1); %starts at t=0?
   RESULTS.v_ooc__OocyteVol(mCount,jCount) = yout(mCount,2); %starts at t=0?
   %RESULTS.t_sim__OutputTimes = tout;    % starts at t=0
   %RESULTS.t_ooc__OocyteVol = tout;
  
  end % for mCount
  
  % Save tout and yout in one array for writing to Excel (see above)
  % ***Modify  for multiple simulations - don't overwrite text file ***
  % 8/16/12 Use Output structure to pass results to OGDM_RunModel -
  %  print all results at the same time
  ToutYout = cat(2, tout, yout);
  %xlswrite('OGDM_ODE_out', ToutYout);
  
  %KHW 8/22/13 changed OGDM_OocMassVol.txt to *.csv
  dlmwrite('OGDM_OocMassVol.csv', ToutYout, '-append');
  
  % Calculate spawn intervals
  if jCount == 1        % KHW 6/2/12 - guarantee only positive values???
      RESULTS.t_sim__SpawnInt(1) =...
        RESULTS.t_ooc__EggSpawned(1) - INPUT.RecruitTime(1);
  else
      RESULTS.t_sim__SpawnInt(jCount) =...
        RESULTS.t_ooc__EggSpawned(jCount) - RESULTS.t_ooc__EggSpawned(jCount-1);
  end  % if jCount==1
  
  %fprintf('in _RunModel - jCount = %4i\n', jCount)
end  % for jCount

% KHW 8/22/13 Calculate time for clutch to reach spawning size
RESULTS.t_ooc__Growth = RESULTS.t_ooc__EggSpawned - transpose(INPUT.RecruitTime);
  
Output.TotEggSpawned = RESULTS.n_ooc__TotEggSpawned;
Output.TotSimEggSpawned = RESULTS.n_ooc__TotSimEggSpawned;      %7/16/14 KHW
%Output.nSpawns = RESULTS.n_ooc__TotGroupSpawned;
Output.SpawnTimes = RESULTS.t_ooc__EggSpawned;
Output.ClutchSize = RESULTS.n_ooc__EggSpawned;

% 7/19/14 KHW - In case multiple batches are spawned on the same day,
%  count unique spawning days
tPrevSpawn = 0;    %7/19/14 initialize to -1 hr
for nSpawns=1:length(RESULTS.t_ooc__EggSpawned)
    if tPrevSpawn ~= RESULTS.t_ooc__EggSpawned(nSpawns) &&...
            RESULTS.n_ooc__EggSpawned(nSpawns) ~= 0 %spawn on new day
        Output.nSpawns = Output.nSpawns + 1;
        tPrevSpawn = RESULTS.t_ooc__EggSpawned(nSpawns);
        if RESULTS.t_ooc__EggSpawned(nSpawns) > INPUT.t_sim__ExpoStart
            Output.nSpawnsSim = Output.nSpawnsSim + 1;
        end     %if RESULTS
    end     %if tPrevSpawn
    
    % 7/19/14 KHW debug
    %fprintf ('in RunModel.m: tPrevSpawn = %-7.1f\n', tPrevSpawn);
    %fprintf ('RESULTS.tSpawn = %7.1f\n',RESULTS.t_ooc__EggSpawned(nSpawns))
    %fprintf ('Output.nSpawns = %7.1f; Output.nSpawnsSim = %7.1f\n',...
    %    Output.nSpawns, Output.nSpawnsSim)
    
end     % for nSpawns
        
% KHW 8/22/13 Replace negative values with zeros for output
Output.SpawnInt = RESULTS.t_sim__SpawnInt .* (RESULTS.t_sim__SpawnInt>0);
Output.tGrowth = RESULTS.t_ooc__Growth .* (RESULTS.t_ooc__Growth>0);
  
end  % function OGDM_RunModel


function yp = OGDM_ODE(t, y)
% Oocyte Growth Dynamics Model equations for numerical integration

global INPUT RESULTS

yp = zeros(length(y),1);

%fprintf ('in yp, INPUT.c_ova_vtg_ExpoEnd = %6.2f\n', INPUT.c_ova_vtg_ExpoEnd)

n_ooc__InitGroupSize = 0;
n_ooc__EggSpawned = 0;

    if t <= INPUT.t_sim__ExpoStart    % use to change plasma vtg conc
    %if t <= 4104 % 4104 hr (=5 mos); use variable time (t_sim__ExpoStart)?
      c_ova_vtg_TissueConc = INPUT.c_ova_vtg_Unexposed;
    else
      c_ova_vtg_TissueConc = INPUT.c_ova_vtg_ExpoEnd;
    end

    if t >= INPUT.t_sim__RecruitTime
        RESULTS.n_ooc__Inside = INPUT.n_ooc__Generated;
      else
        RESULTS.n_ooc__Inside = 0;
    end

% Differential equations to compute mass of VTG absorbed by oocytes
    if RESULTS.n_ooc__Inside == 0
      yp(1) = 0;
      yp(2) = 0;
      
    else
     %fprintf('1. before yp*; t = %-8.2f\ty1 = %-8.2g\ty2 = %-8.2g\n',...
     %   t, y(1), y(2))
    
     yp(1) = INPUT.VtgAbsRate*c_ova_vtg_TissueConc*y(2);
     yp(2) = INPUT.OocyteToVtgMass*0.156*yp(1);
      
    end
    
  end  %function OGDM_ODE
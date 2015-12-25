function status = OGDM_OutputFcn(t, y, flag)
% 8/2/13 Copied from V2 for V3
% 8/30/12 KHW Function checks whether oocytes are large enough to spawn
% Halts numerical integration when oocytes reach spawning volume

% Use odeset to call a fcn after every integration step
  % options = odeset('OutputFcn', @testODE_out_vec);
  % results = ode15s(@testOGDM_ODE, tspan, 0, options)
  
  global INPUT RESULTS
  persistent iCount n_ooc__EggSpawned jGroup
  
  % iCount tracks the number of times OutputFcn called
  % n_ooc__EggSpawned = number of oocytes spawned  = # oocytes recruited
  % Output is a structure array storing results of interest - DELETE THIS?
  % jGroup = the total number of oocyte groups simulated (=
  %   RESULTS.n_sim__GroupCount)
  
  % clear OGDM_OutputFcn to clear persistent variables otherwise they
  % remain in memory - 8/30/12 Matlab Product Help
  
  status = 0;
  
  switch flag
    case 'init'   % initialize variables
      %fprintf('in OGDM_OutputFcn - init\n')
      
      if RESULTS.n_sim__GroupCount == 0
        jGroup = 1;    % initialize oocyte group counter
      %  RESULTS.n_sim__GroupCount = 1;
      end
      
      n_ooc__EggSpawned = 0;
      RESULTS.n_ooc__GroupsInside = 1;
      iCount = 1;    % output element counter
      
      %fprintf ('OGDM_OutputFcn-init; Mass = %-8.2g\tVol = %-8.2g\n',...
      %    y(1), y(2))
           
    case 'done'     % clean-up/re-initialize variables
        
      %fprintf ('OGDM_OutputFcn-done; jGroup = %3i\tiCount = %3i\n', jGroup, iCount)
      %fprintf('simulation complete - %4i oocyte group(s) simulated\n', jGroup)
      % 7/19/14 KHW fprintf('%4i output elements\n', iCount+1)
      
      %debug - KHW 2/23/13
      %fprintf('Total eggs spawned - %5i\n', RESULTS.n_ooc__TotEggSpawned);
      %fprintf('Total spawns - %5i\n', RESULTS.n_ooc__TotGroupSpawned);
      %fprintf('Clutch sizes - %4i\n', RESULTS.n_ooc__EggSpawned);
      
      RESULTS.n_sim__GroupCount = RESULTS.n_sim__GroupCount +1;
      jGroup = jGroup + 1;  %8/31/12 use n_sim__GroupCount instead of jGroup?
      
      clear iCount n_ooc__EggSpawned;
        
    otherwise
      %fprintf('1-in OGDM_OutputFcn - otherwise\tiCount=%5i\n', iCount)
      % 8/9/12 fprintf ('t = %-8.2f\n', t)
      % 8/9/12 fprintf ('Ooc mass = %-8.2g\tOoc Vol = %-8.2g\n', y(1), y(2))
            
      if length(t) == 1
        %fprintf ('t = %-8.2f\tOoc mass= %-8.2g\tOoc Vol= %-8.2g\n',...
        %      t, y(1), y(2))
          
        % Determine whether oocytes in a group are ready to spawn
        % if n_ooc__EggSpawned == 0  % Check if oocytes are ready to spawn
          if y(2) >= INPUT.SpawnVol % ooctyes ready to spawn
          
            %fprintf('2a-OGDM_OutputFcn - otherwise\tSpawn Vol = %6.2f\n', y(2))
            n_ooc__EggSpawned = RESULTS.n_ooc__Inside;
            RESULTS.n_ooc__Inside = 0;
            RESULTS.n_ooc__TotGroupSpawned = RESULTS.n_ooc__TotGroupSpawned + 1;  
            RESULTS.n_ooc__TotEggSpawned= RESULTS.n_ooc__TotEggSpawned +...
              n_ooc__EggSpawned;
            RESULTS.n_ooc__EggSpawned(jGroup) = n_ooc__EggSpawned;
            RESULTS.t_ooc__EggSpawned(jGroup) = t;
            
            % 7/16/14 KHW calc total eggs spawned for user-specified sim period (nSimLength)
            if t > INPUT.t_sim__ExpoStart
                RESULTS.n_ooc__TotSimEggSpawned = RESULTS.n_ooc__TotSimEggSpawned +...
                  n_ooc__EggSpawned;
                RESULTS.n_ooc__GroupSpawnedSim = RESULTS.n_ooc__GroupSpawnedSim + 1;
              end     %if t
            
            %fprintf('OGDM_OutputFcn - EggSpawned = %-4i\tSpawnTime = %-8.2f\n',...
            %  RESULTS.n_ooc__EggSpawned(jGroup), RESULTS.t_ooc__EggSpawned(jGroup));
          
            status = 1;   % stop integration; oocytes spawned
            
          else   % oocytes not large enough
            %n_ooc__EggSpawned = 0;
            iCount = iCount + 1;
            
            %fprintf('3a-OGDM_OutputFcn - otherwise\tiCount = %5i\n', iCount);
            
          end  % end if y(2) 
          
        %end  % end if n_ooc__EggSpawned
      
      else  % t is a vector of times
          for kCount = 1:length(t)
            
          %fprintf ('t = %-8.2f\tOoc mass= %-8.2g\tOoc Vol= %-8.2g\n',...
          %  t(kCount),y(1,kCount), y(2,kCount))
        
          % Determine whether oocytes in a group are ready to spawn
          
            if y(2,kCount) < INPUT.SpawnVol %increment iCount
                iCount = iCount +1;
              
            elseif (kCount > 1 && y(2,kCount-1) >= INPUT.SpawnVol) % spawned at previous time
                %do nothing
                
            else % this is the first time that oocytes are large enough to spawn
                
              %fprintf('2b-OGDM_OutputFcn-otherwise\tSpawn Vol = %-8.2g\n',...
              %  y(2,kCount))
              
              n_ooc__EggSpawned = RESULTS.n_ooc__Inside;
              RESULTS.n_ooc__Inside = 0;
              RESULTS.n_ooc__TotGroupSpawned = RESULTS.n_ooc__TotGroupSpawned + 1;
          
              RESULTS.n_ooc__TotEggSpawned= RESULTS.n_ooc__TotEggSpawned +...
                n_ooc__EggSpawned;
      
              RESULTS.n_ooc__EggSpawned(jGroup) = n_ooc__EggSpawned;
              RESULTS.t_ooc__EggSpawned(jGroup) = t(kCount);
              
              % 7/16/14 KHW calc total eggs spawned for user-specified sim period (nSimLength)
              if t(kCount)> INPUT.t_sim__ExpoStart
                RESULTS.n_ooc__TotSimEggSpawned = RESULTS.n_ooc__TotSimEggSpawned +...
                  n_ooc__EggSpawned;
                RESULTS.n_ooc__GroupSpawnedSim = RESULTS.n_ooc__GroupSpawnedSim + 1;
              end     %if t(kCount)
            
              %fprintf('OGDM_OutputFcn - EggSpawned = %-4i\tSpawnTime = %-8.2f\n',...
              %  RESULTS.n_ooc__EggSpawned(jGroup), RESULTS.t_ooc__EggSpawned(jGroup));
            
              %debug - KHW 2/25/13
              %fprintf('kCount = %4i\tn_ooc__EggSpawned = %5i\n', kCount,...
              %  n_ooc__EggSpawned);
          
              status = 1;   % stop integration; oocytes spawned
              
              %fprintf('3b-OGDM_OutputFcn-otherwise\tiCount = %5i\n', iCount);
          
            end  % end if y
          end   % end for kCount
      end   % if length(t) == 1 
  end  % end switch 
  
end % function OGDM_output


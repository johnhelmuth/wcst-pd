
% [ERN_PERF_HC, PSP_PERF_HC] = runCorrelateERN_PSP_PERF (10,{'epsilon.eps_str','epsilon.eps_sma','reward.mem_feat','reward.w_neg'},{linspace(0.4,0.7,4),linspace(0.4,0.7,4),linspace(0.0,0.2,4),linspace(0.0,0.2,4)});

function [ERN_PERF, PSP_PERF] = runCorrelateERN_PSP_PERF (run_per_points,param_names,combarray)

% Run different random parameters with PSP values
% 

ERN_PERF = struct();
PSP_PERF = struct();

% produced array combinations
len_space = 4;
%combarray = {linspace(0.05,0.2,len_space),linspace(0.3,0.5,len_space),linspace(0.5,0.7,len_space),linspace(0.5,0.8,len_space)};
combarray_t = combarray;
[combarray_t{:}] = ndgrid(combarray{:});
all_combinations = cell2mat(cellfun(@(m)m(:),combarray_t,'uni',0));

% Runs baseline condition (HC) to compare the values of attenuation to.
fprintf('Simulating baseline conditions\n');
subj_sim_wcst_HC = runWCSTvar_Set(run_per_points);
fprintf('Baseline condition completed\n');

for ii = 1:length(all_combinations)
    
 param_PD = param_names;
 
 subj_sim_wcst_PD = runWCSTvar_Set(run_per_points,param_PD,num2cell(all_combinations(ii,:)));
 
 PSPsignal = struct;
 ERNsignal = struct;
 [PSPsignal] = simulatePSP(subj_sim_wcst_HC,subj_sim_wcst_PD);
 [ERNsignal] = simulateERN(subj_sim_wcst_HC,subj_sim_wcst_PD);
 
 if length(PSPsignal.shift) <= 1 % Unsuccessful, usually because there are no shifts
  fprintf('PSP: Unsuccesful trial. No shift trial present. Next one\n');
  continue;
 end
 
 try    
  PSP_PERF(ii).eps_str = all_combinations(1);
  PSP_PERF(ii).eps_sma = all_combinations(2);
  PSP_PERF(ii).w_rv = all_combinations(3);

  PSP_PERF(ii).AttenuationValue = PSPsignal.AttenuationValue;
  PSP_PERF(ii).TE = mean([subj_sim_wcst_PD.TE_H]) - mean([subj_sim_wcst_HC.TE_H]);
  PSP_PERF(ii).PE = mean([subj_sim_wcst_PD.PE_L]) - mean([subj_sim_wcst_HC.PE_L]);
  PSP_PERF(ii).SL = mean([subj_sim_wcst_PD.SL_L]) - mean([subj_sim_wcst_HC.SL_L]);
  PSP_PERF(ii).IE = mean([subj_sim_wcst_PD.IE_L]) - mean([subj_sim_wcst_HC.IE_L]);
 
  ERN_PERF(ii).eps_str = all_combinations(1);
  ERN_PERF(ii).eps_sma = all_combinations(2);
  ERN_PERF(ii).w_rv = all_combinations(3);
 
  ERN_PERF(ii).AttenuationValue = ERNsignal.AttenuationValue;
  ERN_PERF(ii).TE = mean([subj_sim_wcst_PD.TE_H]) - mean([subj_sim_wcst_HC.TE_H]);
  ERN_PERF(ii).PE = mean([subj_sim_wcst_PD.PE_L]) - mean([subj_sim_wcst_HC.PE_L]);
  ERN_PERF(ii).SL = mean([subj_sim_wcst_PD.SL_L]) - mean([subj_sim_wcst_HC.SL_L]);
  ERN_PERF(ii).IE = mean([subj_sim_wcst_PD.IE_L]) - mean([subj_sim_wcst_HC.IE_L]);
 
 catch
  disp('one trial aborted');    
 end
 fprintf('%i trial completed... \n', ii)

end
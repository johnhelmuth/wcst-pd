%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the WSCT changing three parameters
% and saving them in a n_str x n_pfc x trials matrix
% in a structure called TwoVarTableT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
TwoVarTable = struct;

out_var = input('Output variable name: ', 's');

% Name of the manipulated variables

first_var_str = input('First var parameter: ', 's');
first_var_name = input('First var name: ', 's');
second_var_str = input('Second var parameter: ', 's');
second_var_name = input('Second var name: ', 's');

% Range
range_first_var(1) = input('Left boundary - First var: '); 
range_first_var(2) = input('Right boundary - First var: ');
division_var(1) = input('Number of trials across space - First var: ');

range_second_var(1) = input('Left boundary - Second var: '); 
range_second_var(2) = input('Right boundary - Second var: ');
division_var(2) = input('Number of trials across space - Second var: ');

first_var_v = linspace(range_first_var(1),range_first_var(2),division_var(1)); %e4 or e5 ? 
second_var_v = linspace(range_second_var(1),range_second_var(2),division_var(2)); 

% Total trials
totalTrials = input('Total number of trials: '); 

fprintf('Beginning time: %s\n', datestr(now,'HH:MM'));

runTrialx = 1;
numTrialsx = length(first_var_v)*length(second_var_v);

TwoVarTable.TE_H = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.PE_H = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.SL_H = nan(length(first_var_v),length(second_var_v),totalTrials);

TwoVarTable.PE_L = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.SL_L = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.IE_L = nan(length(first_var_v),length(second_var_v),totalTrials);

TwoVarTable.RT = nan(length(first_var_v),length(second_var_v),totalTrials);

TwoVarTable.ERNatt = nan(length(first_var_v),length(second_var_v),totalTrials);
TwoVarTable.PSPatt = nan(length(first_var_v),length(second_var_v),totalTrials);

for first_var_c = 1:length(first_var_v)
 for second_var_c = 1:length(second_var_v)
  
  fprintf('%1.0f of %1.0f\n', runTrialx, numTrialsx);
  subj_sim_wcst = runWCSTvar_Set(totalTrials,{first_var_str,second_var_str},{first_var_v(first_var_c),second_var_v(second_var_c)});   
  fprintf('completed\n');
  
  TwoVarTable.TE_H(first_var_c,second_var_c,:) = [subj_sim_wcst.TE_H];
  TwoVarTable.PE_H(first_var_c,second_var_c,:) = [subj_sim_wcst.PE_H];
  TwoVarTable.SL_H(first_var_c,second_var_c,:) = [subj_sim_wcst.SL_H];
 
  TwoVarTable.PE_L(first_var_c,second_var_c,:) = [subj_sim_wcst.PE_L];
  TwoVarTable.SL_L(first_var_c,second_var_c,:) = [subj_sim_wcst.SL_L];
  TwoVarTable.IE_L(first_var_c,second_var_c,:) = [subj_sim_wcst.IE_L];

  TwoVarTable.RT(first_var_c,second_var_c,:) = [subj_sim_wcst.medRT];
 
  TwoVarTable.ERNatt(first_var_c,second_var_c,:) = [subj_sim_wcst.ERNatt];
  TwoVarTable.PSPatt(first_var_c,second_var_c,:) = [subj_sim_wcst.PSPatt];
  
  TwoVarTable.GPi_SMAcoeff(first_var_c,second_var_c,:) = [subj_sim_wcst.GPi_SMAcoeff];
  
  runTrialx = runTrialx + 1;
 
 end
end

eval([out_var,' = TwoVarTable;']);
eval([first_var_name,' = first_var_v;']);
eval([second_var_name,' = second_var_v;']);

eval(['save TwoVarTables.mat ', out_var, ' -append'])
eval(['save TwoVarTables.mat ', first_var_name, ' -append']);
eval(['save TwoVarTables.mat ', second_var_name, ' -append']);
fprintf('\nEnding time: %s\n', datestr(now,'HH:MM'))


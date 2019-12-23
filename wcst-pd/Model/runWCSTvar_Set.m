%% Run WCST simulation in multiple subjects
% The optional argument changes the specified variable to the 
% requested one
% subj_sim_wcst = runWCSTvar_Set(5,{'extPFC'},{0.8});
% subj_sim_wcst = runWCSTvar_Set(5,{'weights.w_STIM_PRES','weights.w_RULE'},{0.7,0.6});

function subj_sim_wcst = runWCSTvar_Set(subjects_tot,varargin)
%% Define number of trials
if nargin == 0
   subjects_tot = 2; % set the total number of counter.trial_nums
end 

if nargin > 1
   par_noise = unifrnd(1,1,1,length(varargin{2})); 
end

%% Print initial time
fprintf('Simulating WCST\n');
fprintf('Beginning time: %s\n', datestr(now,'HH:MM:SS'));
    
% Parameter noise (10%)

for subject_num = 1:subjects_tot

 fprintf('Subject %1.0f out of %1.0f...\n ',subject_num, subjects_tot);
 
 %% Initialise, run one trial and register variables
 initialiseWCST;
 
 if nargin > 1
 
  var_string = varargin{1};
  var_value = cell2mat(varargin{2}).*par_noise;
 
  % Applies the values to the variables
  for vars_num = 1:length(var_value)
   eval(strcat( var_string{vars_num}, '=', num2str(var_value(vars_num)) ,';'));
   fprintf(' %s is set to %1.2f \n ', var_string{vars_num}, var_value(vars_num));
  end
  
 end
 
 create_stimuli;    % just in case the modified parameter is perc_ambig
  
 runWCST;        % Run one subject

 subj_sim_wcst(subject_num).TE_H = sum(performances.TE_H);
 subj_sim_wcst(subject_num).CC_H = sum(performances.CC);
 subj_sim_wcst(subject_num).PE_H = sum(performances.PE_H);
 subj_sim_wcst(subject_num).SL_H = sum(performances.SL_H);
 
 subj_sim_wcst(subject_num).PE_L = sum(performances.PE_L);
 subj_sim_wcst(subject_num).PE_L_v = performances.PE_L;
 subj_sim_wcst(subject_num).SL_L = sum(performances.SL_L);
 subj_sim_wcst(subject_num).SL_L_v = performances.SL_L;
 
 subj_sim_wcst(subject_num).IE_L = sum(performances.IE_L);
  
 subj_sim_wcst(subject_num).RT = (performances.RT);
 subj_sim_wcst(subject_num).medRT = median(performances.RT);
 
 subj_sim_wcst(subject_num).TE_H_P = sum(performances.TE_H)/counter.trial_num;
 subj_sim_wcst(subject_num).CC_H_P = sum(performances.CC)/floor(lstim/changeAfterCorrect);
 subj_sim_wcst(subject_num).PE_L_P = sum(performances.PE_L)/counter.trial_num;
 subj_sim_wcst(subject_num).SL_L_P = sum(performances.SL_L)/counter.trial_num;
 subj_sim_wcst(subject_num).IE_L_P = sum(performances.IE_L)/counter.trial_num;
 
 subj_sim_wcst(subject_num).shift_idx = performances.shift_idx;
 subj_sim_wcst(subject_num).trials = (counter.trial_num);
 subj_sim_wcst(subject_num).counter = counter;

 subj_sim_wcst(subject_num).GPi_SMAcoeff = max(sma.GPi_SMAcoeff);
 % Inner variables
 
 subj_sim_wcst(subject_num).innervars.alpha_sma_diff = innervars.alpha_sma_diff;
 subj_sim_wcst(subject_num).innervars.prod_sma = innervars.prod_sma;
 subj_sim_wcst(subject_num).innervars.prod_pfc = innervars.prod_pfc;
 subj_sim_wcst(subject_num).innervars.prod_smapfc = innervars.prod_smapfc;
 subj_sim_wcst(subject_num).innervars.prod_sma_diff = innervars.prod_sma_diff;
 subj_sim_wcst(subject_num).innervars.prod_sma_log_diff = innervars.prod_sma_log_diff;
 subj_sim_wcst(subject_num).innervars.absmax_diff = innervars.absmax_diff;
 subj_sim_wcst(subject_num).innervars.absmax_exp_diff = innervars.absmax_exp_diff;
 subj_sim_wcst(subject_num).innervars.var_pfc_diff = innervars.var_pfc_diff;
 subj_sim_wcst(subject_num).innervars.absmax_diff_pfc = innervars.absmax_diff_pfc;
 
 %load('subj_sim_wcst.mat', 'subj_sim_wcst_baseline')
 
 %%{
 try
  [ERNsignal] = simulateERN(subj_sim_wcst(subject_num),subj_sim_wcst_baseline);   
  subj_sim_wcst(subject_num).ERNatt = ERNsignal.AttenuationValue;
 catch
  subj_sim_wcst(subject_num).ERNatt = NaN;
 end
 %%}
 %%{
 try
  [PSPsignal] = simulatePSP(subj_sim_wcst(subject_num),subj_sim_wcst_baseline);
  subj_sim_wcst(subject_num).PSPatt = PSPsignal.AttenuationValue;
 catch
  subj_sim_wcst(subject_num).PSPatt = NaN;     
 end
 %%}
 
 fprintf('completed\n');


end

%% Print results and saves

 fprintf('\n Simulation WCST completed\n');
 fprintf('Ending time: %s\n', datestr(now,'HH:MM:SS'));
 
 %{
 fprintf('\n'); 
 fprintf('Total Errors in %1.0f subjects: (M = %1.1f, SD = %1.1f) \n', subjects_tot, mean([subj_sim_WCST.TE]), std([subj_sim_WCST.TE]));
 fprintf('\n');
 %}
 
end


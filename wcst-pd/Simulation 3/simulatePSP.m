% simulatePSP produces two or more sets of data, by averaging internal variables
% in the cognitive model before or after a specific event
% These represent the difference between first and first cue shift.
%
% usage: PSPsignal = simulatePSP(subj_sim_wcst_HC,subj_sim_wcst_PD)

function PSPsignal = simulatePSP(varargin)
 
interval = 10;
PSPsignal = struct;
    
for nn = 1:nargin   %across groups
    
%subplot(nargin,1,nn);

% Plot set 1: waves
for part = 1:length(varargin{nn}) % across participants
 n_tr_1 = 1;
 n_tr_2 = 1;
 
 episode = varargin{nn}(part).counter.tt_trial_num;  
 
 for trial = [varargin{nn}(part).shift_idx varargin{nn}(part).shift_idx+1]  %across trials
      if trial < length(episode)
        % shift and repeat cue
        if ismember(trial,varargin{nn}(part).shift_idx)
         PSPsignal.shift{nn}(:,n_tr_1,part) = varargin{nn}(part).innervars.absmax_diff_pfc(episode(trial)-interval:episode(trial)+interval);
         n_tr_1 = n_tr_1 + 1;
        elseif ismember(trial,varargin{nn}(part).shift_idx + 1)
         PSPsignal.first_cue{nn}(:,n_tr_2,part) = varargin{nn}(part).innervars.absmax_diff_pfc(episode(trial)-interval:episode(trial)+interval);
         n_tr_2 = n_tr_2 + 1;
        end
      end   
end
end

if isempty([varargin{nn}(part).shift_idx]) % there are no shift trials because subject didn't complete one category or shifted at the last trial
    return;
end

if isempty([varargin{nn}(part).shift_idx]) % there are no shift trials because subject didn't complete one category or shifted at the last trial
    return;
end

% Cleaning signal
PSPsignal.shift{nn}(isinf(PSPsignal.shift{nn})) = NaN;
PSPsignal.shift{nn}(PSPsignal.shift{nn} == 0) = NaN;
PSPsignal.first_cue{nn}(isinf(PSPsignal.first_cue{nn})) = NaN;
PSPsignal.first_cue{nn}(PSPsignal.first_cue{nn} == 0) = NaN;

% Compute correct, incorrect, and difference signal for all (HC and PD)
PSPsignal.PSPshift{nn} = nanmean(nanmean(PSPsignal.shift{nn},2),3);
PSPsignal.PSPfirst_cue{nn} = nanmean(nanmean(PSPsignal.first_cue{nn},2),3);

% The actual signal PSP is the difference between the two
PSPsignal.PSP{nn} = (nanmax(PSPsignal.PSPshift{nn}) - nanmax(PSPsignal.PSPfirst_cue{nn}));

% but in order to calculate normalisation constant and in order to 
% to show the plot
% I concatenate the signal

PSPsignal.PSPlink{nn} = [PSPsignal.PSPshift{nn}; PSPsignal.PSPfirst_cue{nn}];

end

% Calculate PSPsignal max Attenuation between the two signals
PSPsignal.Attenuation = abs(PSPsignal.PSP{1}) - abs(PSPsignal.PSP{2});
PSPsignal.AttenuationValue = nanmax(PSPsignal.Attenuation);

end

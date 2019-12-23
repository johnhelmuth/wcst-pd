% simulateERN produces two or more sets of data, by averaging internal variables
% in the cognitive model before or after a specific event
%
% usage: ERNsignal = simulateERN(subj_sim_wcst_HC,subj_sim_wcst_PD)

function ERNsignal = simulateERN(varargin)

interval = 10;
ERNsignal = struct;

for nn = 1:nargin   %a across groups
    
% Plot set 1: waves
% Initialise
ERNsignal.corr{nn} = [];
ERNsignal.incorr{nn} = [];
corr_trials = 0;
incorr_trials = 0;
 
for part = 1:length(varargin{nn}) % across participants
    
 episode = varargin{nn}(part).counter.tt_trial_num;  % the correct/incorrect one is the previous one
 episode = episode(episode ~= 0);
 if isempty(episode)
     break;
 end
 
for trial = 2:length(episode)-1   %across trials
        
        if varargin{nn}(part).counter.correct_counter_vector(trial-1) == 1  
         ERNsignal.corr{nn}(:,trial,part) = -varargin{nn}(part).innervars.absmax_diff(episode(trial)-interval:episode(trial)+interval);
         ERNsignal.incorr{nn}(:,trial,part) = nan(1,21);
         corr_trials = corr_trials + 1;
        else
         ERNsignal.incorr{nn}(:,trial,part) = -varargin{nn}(part).innervars.absmax_diff(episode(trial)-interval:episode(trial)+interval);
         ERNsignal.corr{nn}(:,trial,part) = nan(1,21);
         incorr_trials = incorr_trials + 1;
        end
   
end
end

if isempty(ERNsignal.corr{nn})
    ERNsignal = nan;
 return
end

% Cleaning signal
ERNsignal.corr{nn}(isinf(ERNsignal.corr{nn})) = NaN;
ERNsignal.corr{nn}(ERNsignal.corr{nn} == 0) = NaN;
ERNsignal.incorr{nn}(isinf(ERNsignal.incorr{nn})) = NaN;
ERNsignal.incorr{nn}(ERNsignal.incorr{nn} == 0) = NaN;

% Compute correct, incorrect, and difference signal for all (HC and PD)
ERNsignal.ERNcorr{nn} = nanmean(nanmean(ERNsignal.corr{nn},2),3);
ERNsignal.ERNincorr{nn} = nanmean(nanmean(ERNsignal.incorr{nn},2),3);

% Weighted Mean of ERN in correct trials and incorrect trials
ERNsignal.ERN{nn} = (ERNsignal.ERNincorr{nn}*incorr_trials - ERNsignal.ERNcorr{nn}*corr_trials)/(corr_trials+incorr_trials);

end

% Calculate ERNsignal max Attenuation between the two signals
Att1 = abs(ERNsignal.ERN{1}) - abs(ERNsignal.ERN{2});
ERNsignal.AttenuationValue = nanmax(Att1);

end


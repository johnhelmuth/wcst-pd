% Make sure the model code is on the path:
addpath('../Model/');

% Script to generate data for the HC and four PD groups, with 100 subjects per group
% Run this (or load the saved data) before doing any analyses
% Note that this will take a few hours to run

subjects = 100;

% HC patients:
subj_hc = runWCSTvar_Set(subjects,{'epsilon.eps_str', 'epsilon.eps_sma'},{0.4, 0.5});

% PD patients:
subj_pd1 = runWCSTvar_Set(subjects,{'epsilon.eps_str', 'epsilon.eps_sma'},{0.1, 0.5});
subj_pd2 = runWCSTvar_Set(subjects,{'epsilon.eps_str', 'epsilon.eps_sma', 'reward.w_neg', 'reward.mem_feat'},{0.1, 0.5, 0.65, 0.0});
subj_pd3 = runWCSTvar_Set(subjects,{'epsilon.eps_str', 'epsilon.eps_sma', 'reward.w_neg', 'reward.mem_feat'},{0.1, 0.5, 0.0, 0.60});
subj_pd4 = runWCSTvar_Set(subjects,{'epsilon.eps_str', 'epsilon.eps_sma', 'reward.w_neg', 'reward.mem_feat'},{0.1, 0.5, 0.65, 0.60});
% subj_pd4 = runWCSTvar_Set(subjects,{'epsilon.eps_str', 'epsilon.eps_sma'},{0.1, 0.3});

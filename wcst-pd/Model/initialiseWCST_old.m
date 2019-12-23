%% Declare variables

%% Load cards deck
perc_ambig = 0.0;   % percentage of ambiguity
card_numbers = 64; 
create_stimuli;
%load('stimuli.mat', 'stimuli_standard');   % Always the same stimuli (reduced variability)
lstim = length(stimuli);

%% Initialise Generic Variables 

f_sampl = 1; % sample frequency: 1
timeLength = round(lstim*2e4/64,2,'significant');
timeSteps = round(timeLength/f_sampl) + 1;
 
extPFC = 0.759038370162450; %controls the external to the cog schema:
extNoise = 0.207218665765842; % controls external (uniform noise), to PFC and to SMA

decay_constant = 0.6; %0.6 to 1 is smoother

pfc.actPFC = zeros(lstim+1,3); 
sma.actSMA = zeros(lstim+1,4);

ctx_noise = 0.110833549541056;  % noise added to alpha_sma and beta_pfc after controls

pfc.pred_act = zeros(lstim+1,3);
pfc.entropyPFC = zeros(lstim+1,3);

reward.reward_value = zeros(lstim+1,3);
reward.TDV = zeros(lstim+1,3);
reward.w_pos = 0.00;    
reward.w_neg = 0.00;
reward.mem_feat = 0.00;

epsilon.eps_str = 0.389904229940760; % learning rate for STRIATUM 
epsilon.eps_sma = 0.189312196916869; % learning rate for PFC 

var_dynamic = 4e2;
thr_dynamic = 4e3; 

threshold.static = 0.5;

%% Initialise Basal Ganglia and Schema (premotor/parietal) variables
  
pfc.schema_names = {'Cognitive Schema: Sort by Colour','Cognitive Schema: Sort by Number','Cognitive Schema: Sort by Shape'};
sma.schema_names = {'Motor Schema: Put down on pile 1','Motor Schema: Put down on pile 2','Motor Schema: Put down on pile 3','Motor Schema: Put down on pile 4'};

% Saturation functions

satfnc.alpha_sma_val = 8;
satfnc.alpha_sma = satfnc.alpha_sma_val*(ones(1,4));
satfnc.alpha_pfc = 8.143339078971103; %8

satfnc.alpha_stn = 8;
satfnc.alpha_gpi = 8;
satfnc.alpha_gpe = 8; 
satfnc.alpha_thal = 8; 

satfnc.alpha_str_pfc = 8.5; 
satfnc.alpha_str_sma = 8.5; 

satfnc.beta_thal = 0.45; 

satfnc.beta_sma_val = 0.40;
satfnc.beta_sma = satfnc.beta_sma_val*(ones(1,4)); 
satfnc.beta_pfc_val = 0.50;
satfnc.beta_pfc = satfnc.beta_pfc_val*(ones(1,3)); 

satfnc.beta_str_pfc = [0.45 0.50 0.55];
satfnc.beta_str_pfc = satfnc.beta_str_pfc(randperm(3));

satfnc.beta_stn_pfc = 0.30*(ones(1,3)); 
satfnc.beta_gpe_pfc = 0.25*(ones(1,3)); 
satfnc.beta_gpi_pfc = 0.25*(ones(1,3)); 

satfnc.beta_str_sma = 0.50*(ones(1,4));  

satfnc.beta_stn_sma = 0.30*(ones(1,4));  % 0.3
satfnc.beta_gpe_sma = 0.25*(ones(1,4));  % 0.2
satfnc.beta_gpi_sma = 0.25*(ones(1,4));  % 0.2

sma.u_ST1_SMA = zeros(4,timeSteps);
sma.u_ST2_SMA = zeros(4,timeSteps);
sma.u_STN_SMA = zeros(4,timeSteps);
sma.u_GPe_SMA = zeros(4,timeSteps);
sma.u_GPi_SMA = zeros(4,timeSteps);
sma.u_THAL_SMA = zeros(4,timeSteps);

pfc.u_ST1_PFC = zeros(3,timeSteps);
pfc.u_ST2_PFC = zeros(3,timeSteps);
pfc.u_STN_PFC = zeros(3,timeSteps);
pfc.u_GPe_PFC = zeros(3,timeSteps);
pfc.u_GPi_PFC = zeros(3,timeSteps);
pfc.u_THAL_PFC = zeros(3,timeSteps);

sma.u_SMA = zeros(4,timeSteps);
pfc.u_PFC = zeros(3,timeSteps);

sma.a_ST1_SMA = zeros(4,timeSteps);
sma.a_ST2_SMA = zeros(4,timeSteps);
sma.a_STN_SMA = zeros(4,timeSteps);
sma.a_GPe_SMA = zeros(4,timeSteps);
sma.a_GPi_SMA = zeros(4,timeSteps);
sma.a_THAL_SMA = zeros(4,timeSteps);

pfc.a_ST1_PFC = zeros(3,timeSteps);
pfc.a_ST2_PFC = zeros(3,timeSteps);
pfc.a_STN_PFC = zeros(3,timeSteps);
pfc.a_GPe_PFC = zeros(3,timeSteps);
pfc.a_GPi_PFC = zeros(3,timeSteps);
pfc.a_THAL_PFC = zeros(3,timeSteps);

sma.a_SMA = zeros(4,timeSteps);
pfc.a_PFC = zeros(3,timeSteps);

sma.o_ST1_SMA = zeros(4,timeSteps);
sma.o_ST2_SMA = zeros(4,timeSteps);
sma.o_STN_SMA = zeros(4,timeSteps);
sma.o_GPe_SMA = zeros(4,timeSteps);
sma.o_GPi_SMA = zeros(4,timeSteps);
sma.o_THAL_SMA = zeros(4,timeSteps);
sma.o_THAL_SMA = zeros(4,timeSteps);

pfc.o_ST1_PFC = zeros(3,timeSteps);
pfc.o_ST2_PFC = zeros(3,timeSteps);
pfc.o_STN_PFC = zeros(3,timeSteps);
pfc.o_GPe_PFC = zeros(3,timeSteps);
pfc.o_GPi_PFC = zeros(3,timeSteps);
pfc.o_THAL_PFC = zeros(3,timeSteps);

sma.o_SMA = zeros(4,timeSteps);
pfc.o_PFC = zeros(3,timeSteps);

sma.w_SMA = zeros(4,timeSteps);
pfc.w_PFC = zeros(3,timeSteps);

bg.W_STN = 1.2;  
bg.W_ST1_GPi = -1; %-1
bg.W_ST2_GPe = -1; %-1
bg.W_STN_GPe = 0.9;  %0.9
bg.W_STN_GPi = 0.9;  %0.9
bg.W_GPe_GPi = -0.3; %-0.3

weights.w_STIM_PRES = 0.495313930107175; 
             % this parameter is essential for
             % the excitation of motor schemas
             % from the environment (w_STIM_PRES)
weights.w_STIM_BASE = 0.192040343875913; %0.20  (w_STIM_BASE)

weights.w_RULE_PRES = 0.440584241073398;   % this parameter is essential
             % for the communication between cognitive
             % schemas (rules) an motor schemas
             % decrease ups TE and NPE
             % w_RULE_PRES
             % When this is 0.3 and stim_pres is 0.5 make ~5/7 SL errors
             
weights.w_RULE_BASE = 0.00; % LEAKING OF OTHER RULES AFTER SELECTION. 
                            % UNUSED

weights.w_RULE_BASED = zeros(4,3); % TO-FROM parent to child schemas

weights.w_RULE_SELF = +0.00;    %SELF-EXCITATION OR DECAY

%% Initialise External Matrix (EXT)
sma.o_EXT_SMA = zeros(4, timeSteps);

counter.tt_trial_num = zeros(1,lstim);
category = ['c' 's' 'n' 'c' 's' 'n' 'c' 's' 'n' 'c' 's' 'n' 'c' 's' 'n' 'c' 's' 'n' 'c' 's']; % Colour - Form - Number - Colour - Form - Number
category = repmat(category,1,lstim);

counter.chosen_pile = zeros(1,lstim); 
counter.feature_trial = cell(1,lstim); 

% cnfo : c if it matches the colour, cn if it matches the number etc.

changeAfterCorrect = 5;  %it's the criterion

performances.CC = 1;
performances.CCTrial = zeros(1,lstim);

% Errors in Heaton (apart from Set Loss Errors which is in Stuss, after
% 3 responses)

performances.PR_H = zeros(1,lstim); % Pers. Responses (Heaton)
performances.TFC_H = NaN; % counter.trial_num to first category (Heaton)
performances.LTL_H = NaN;  % Learning to Learn (Heaton)
performances.TE_H = zeros(1,lstim);
performances.PE_H = zeros(1,lstim); % Pers. Errors 
performances.NPE_H = zeros(1,lstim); % Non perseverative Errors
performances.SL_H = zeros(1,lstim); % Set loss

% Errors in Lange, Seer, & Koop, 2016
% All these errors are mutually exclusive
% and exhaustive
performances.PE_L = zeros(1,lstim); % Pers. Errors 
performances.IE_L = zeros(1,lstim); % Integr. Errors (Lange)
performances.SL_L = zeros(1,lstim); % Set loss
performances.OE_L = zeros(1,lstim); % All the others

% Counters
counter.correct_counter = 0;
counter.correct_counter_vector = zeros(1,lstim);
counter.trial_num = 0;
counter.trial_num_time = 0;
counter.trial_num_timePFC = 0;
counter.trial_num_time_tot = zeros(1,lstim);
counter.area_sma = 0;
counter.area_pfc = 0;

SMAdrift = zeros(4,4);
counter.tt_trial_num = zeros(1,lstim);
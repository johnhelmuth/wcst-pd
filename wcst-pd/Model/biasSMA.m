% biasSMA

if ismember(counter.trial_num_time, 1:10) %almost immediately after stimulus is shown

 sma.actSMA(counter.trial_num,:) = sma.o_EXT_SMA(:,tt-1)';
 %sma.entropySMA(counter.trial_num,:) = calculate_entropy(sma.actSMA(counter.trial_num,:));
 
 sma.smaNoise = unifrnd(0,+ctx_noise,4,1);
 
 % Online learning
 satfnc.alpha_sma = ones(1,4)*prod(1 + epsilon.eps_sma + sma.actSMA(counter.trial_num,:));
 
 % Apply noise to learning (discrete) in STR_PFC
 satfnc.alpha_sma = satfnc.alpha_sma.*(1 + sma.smaNoise');
 
 % Register value (for output display)
 satfnc.alpha_sma_hist(:,counter.trial_num) = satfnc.alpha_sma';
 
end


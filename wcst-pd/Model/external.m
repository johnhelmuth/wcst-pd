% External excitation to the SMA schemas
% are due to the environmental trigger

%weights.w_STIM_PRES  = 0.6  + envNoise*randn;  %0.5
             % this parameter is essential for
             % the excitation of motor schemas
             % from the environment
     
% basic excitation for all the motor schemas
sma.o_EXT_SMA(:,tt) = weights.w_STIM_BASE + unifrnd(-extNoise,extNoise);

switch stimuli(counter.trial_num).colour
   
    case 1
        sma.o_EXT_SMA(1,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 2
        sma.o_EXT_SMA(2,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 3 
        sma.o_EXT_SMA(3,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 4
        sma.o_EXT_SMA(4,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
        
end

switch stimuli(counter.trial_num).itemnum 
   
    case 1
        sma.o_EXT_SMA(1,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 2
        sma.o_EXT_SMA(2,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 3
        sma.o_EXT_SMA(3,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 4
        sma.o_EXT_SMA(4,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
        
end


switch stimuli(counter.trial_num).shape
   
    case 1 
        sma.o_EXT_SMA(1,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 2
        sma.o_EXT_SMA(2,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 3
        sma.o_EXT_SMA(3,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 4
        sma.o_EXT_SMA(4,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
        
end

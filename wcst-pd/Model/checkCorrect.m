% Initialise threshold

threshold.dynamic = normrnd(thr_dynamic,var_dynamic);

%% Check if the card is correct

counter.sma_value = [sma.o_SMA(1,tt) sma.o_SMA(2,tt) sma.o_SMA(3,tt) sma.o_SMA(4,tt)]; % Values of motor schemas
counter.area_sma = counter.area_sma + counter.sma_value*counter.trial_num_time; % Area below motor schemas
counter.trial_num_time_tot(counter.trial_num) = counter.trial_num_time;

% Race model: Are under the curve && minimum amount 
if any(counter.area_sma > threshold.dynamic) && any(counter.sma_value > threshold.static)
    
    counter.trial_num_time = 0; % Reset Counter (this calls for update counter.trial_num)
    counter.trial_num_timePFC = 0; % Reset Counter for PFC too
   
    sma.indexSMA = find(counter.sma_value == max(counter.sma_value));
    sma.indexSMA = sma.indexSMA(1);
    sma.indexSMAv(counter.trial_num) = sma.indexSMA;
    counter.chosen_pile(counter.trial_num) = sma.indexSMA; % register chosen pile (1,2,3,4)
    counter.tt_trial_num(counter.trial_num) = tt; 
    sma.o_SMA(:,tt:timeSteps) = 0;
    
    counter.area_sma = [0 0 0 0]; % Reset Counter(SMA)
    counter.area_pfc = [0 0 0]; % Reset Counter(PFC)
    
    chosenCard(counter.trial_num) = sma.indexSMA;
    
    if stimuli(counter.trial_num).colour == cardsTable(sma.indexSMA).colour
       counter.feature_trial(counter.trial_num) = strcat(counter.feature_trial(counter.trial_num),'c');   
    end
    
    if stimuli(counter.trial_num).itemnum == cardsTable(sma.indexSMA).itemnum
       counter.feature_trial(counter.trial_num) = strcat(counter.feature_trial(counter.trial_num),'n');
    end
       
    if stimuli(counter.trial_num).shape == cardsTable(sma.indexSMA).shape
       counter.feature_trial(counter.trial_num) = strcat(counter.feature_trial(counter.trial_num),'s');
    end
    
    if isequal(counter.feature_trial(counter.trial_num), {[]})
        counter.feature_trial(counter.trial_num) = strcat(counter.feature_trial(counter.trial_num),'x');
    end
    
    %% Now check if the answer is correct  
   
    commonFeature = strfind(counter.feature_trial(counter.trial_num),category(performances.CC));

    if ~isempty(commonFeature{1})
        
        counter.correct_counter_vector(counter.trial_num) = 1;
        % increment consecutive correct responses
        counter.correct_counter = counter.correct_counter + 1; 
        
             
    else
        
        counter.correct_counter_vector(counter.trial_num) = 0;   %redundant
        % reset consecutive correct responses
        counter.correct_counter = 0; 
       
    end


%% Bias the pFC in order to maximise reward.reward_value.reward.reward_value_value (correct answers)

%biasPFC;

%% Change the rule if there are too many correct answers in a row

if performances.CC < ceil(lstim/changeAfterCorrect) && counter.trial_num >= changeAfterCorrect 
    if counter.correct_counter == changeAfterCorrect    
        
         counter.correct_counter = 0; % reset consecutive counter
         performances.CC = performances.CC + 1; % increment one category
         
    end
end

end


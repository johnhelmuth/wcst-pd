
%% Update counter.trial_num
if (counter.trial_num_time == 0) && counter.trial_num <= lstim
    
    counter.trial_num = counter.trial_num + 1;
    performances.CCTrial(counter.trial_num) = performances.CC;
    %counter.tt_trial_num(counter.trial_num) = tt;
        
end
  
counter.correct_prop = sum(counter.correct_counter_vector)/counter.trial_num;

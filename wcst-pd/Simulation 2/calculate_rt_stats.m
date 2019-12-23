function [rt_post_pos, rt_post_neg] = calculate_rt_stats(subject_data, num_subjects)

% We want to analyse the simulated RT as a function of the feedback on the
% previous trial...

% Feedback on trial j (i.e., whether trial j was correct of not) for
% subject k in the control group is stored as:
% subject_data(k).counter.correct_counter_vector(j)
% RT in cycles for that trial is stored as 
% subject_data(k).counter.trial_num_time_tot(j)
% (Also available as subject_data(k).RT(j))

% Initialise counters:
mean_rt_post_pos(1:num_subjects) = 0;
mean_rt_post_neg(1:num_subjects) = 0;
count_pos(1:num_subjects) = 0;
count_neg(1:num_subjects) = 0;

for s = 1:num_subjects
    for j = 2:64
        if (subject_data(s).counter.correct_counter_vector(j-1)) 
            mean_rt_post_pos(s) = mean_rt_post_pos(s) + subject_data(s).counter.trial_num_time_tot(j);
            count_pos(s) = count_pos(s) + 1;
        else
            mean_rt_post_neg(s) = mean_rt_post_neg(s) + subject_data(s).counter.trial_num_time_tot(j);
            count_neg(s) = count_neg(s) + 1;
        end
    end
    mean_rt_post_pos(s) = mean_rt_post_pos(s) / count_pos(s);
    mean_rt_post_neg(s) = mean_rt_post_neg(s) / count_neg(s);
end

rt_post_pos = mean_rt_post_pos;
rt_post_neg = mean_rt_post_neg;

end
function write_feedback_effect(group, hc_rt_pos, hc_rt_neg, pd_rt_pos, pd_rt_neg)
%UNTITLED3 Summary of this function goes here

hc_data = hc_rt_neg - hc_rt_pos;
pd_data = pd_rt_neg - pd_rt_pos;

[~, p, ~, stats] = ttest2(hc_data, pd_data);

fprintf('%s: %7.2f %7.2f; ', group, mean(pd_rt_pos), mean(pd_rt_neg));
fprintf('t(%d) = %6.3f, p = %6.4f\n', stats.df, abs(stats.tstat), p);

end


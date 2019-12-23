function write_table3_line(label, hc_data, pd1_data, pd2_data, pd3_data, pd4_data)

%[~, p1, ~, stats1] = ttest2(hc_data, pd1_data);
%[~, p2, ~, stats2] = ttest2(hc_data, pd2_data);
%[~, p3, ~, stats3] = ttest2(hc_data, pd3_data);
%[~, p4, ~, stats4] = ttest2(hc_data, pd4_data);

%t_pd1 = abs(stats1.tstat);
%t_pd2 = abs(stats2.tstat);
%t_pd3 = abs(stats3.tstat);
%t_pd4 = abs(stats4.tstat);

fprintf('%-30s & %4.2f & (%4.2f) & %4.2f & (%4.2f) & %4.2f & (%4.2f) & %4.2f & (%4.2f) \\\\ \n', label, ... 
            mean(pd1_data), std(pd1_data), ...
            mean(pd2_data), std(pd2_data), ...
            mean(pd3_data), std(pd3_data), ...
            mean(pd4_data), std(pd4_data));

end
% This assumes that we have group data from HC and 4 PD groups:
load('raw_data_four_pd_groups.mat')

% subj_hc; subj_pd1 .. subj_pd4

% Calculate mean DVs for Heaton and Lange scoring:
hc_cor_h(1:subjects) = 0;
hc_cat_h(1:subjects) = 0;
hc_pe_h(1:subjects) = 0;
hc_sl_h(1:subjects) = 0;
hc_ie_l(1:subjects) = 0;
hc_sl_l(1:subjects) = 0;
hc_medRT(1:subjects) = 0;

pd1_cor_h(1:subjects) = 0;
pd1_cat_h(1:subjects) = 0;
pd1_pe_h(1:subjects) = 0;
pd1_sl_h(1:subjects) = 0;
pd1_ie_l(1:subjects) = 0;
pd1_sl_l(1:subjects) = 0;
pd1_medRT(1:subjects) = 0;

pd2_cor_h(1:subjects) = 0;
pd2_cat_h(1:subjects) = 0;
pd2_pe_h(1:subjects) = 0;
pd2_sl_h(1:subjects) = 0;
pd2_ie_l(1:subjects) = 0;
pd2_sl_l(1:subjects) = 0;
pd2_medRT(1:subjects) = 0;

pd3_cor_h(1:subjects) = 0;
pd3_cat_h(1:subjects) = 0;
pd3_pe_h(1:subjects) = 0;
pd3_sl_h(1:subjects) = 0;
pd3_ie_l(1:subjects) = 0;
pd3_sl_l(1:subjects) = 0;
pd3_medRT(1:subjects) = 0;

pd4_cor_h(1:subjects) = 0;
pd4_cat_h(1:subjects) = 0;
pd4_pe_h(1:subjects) = 0;
pd4_sl_h(1:subjects) = 0;
pd4_ie_l(1:subjects) = 0;
pd4_sl_l(1:subjects) = 0;
pd4_medRT(1:subjects) = 0;

for i = 1:subjects
    hc_cor_h(i) = 64-subj_hc(i).TE_H;
    hc_cat_h(i) = subj_hc(i).CC_H;
    hc_pe_h(i) = subj_hc(i).PE_H;
    hc_sl_h(i) = subj_hc(i).SL_H;
    hc_ie_l(i) = subj_hc(i).IE_L;
    hc_sl_l(i) = subj_hc(i).SL_L;
    pd1_cor_h(i) = 64-subj_pd1(i).TE_H;
    pd1_cat_h(i) = subj_pd1(i).CC_H;
    pd1_pe_h(i) = subj_pd1(i).PE_H;
    pd1_sl_h(i) = subj_pd1(i).SL_H;
    pd1_ie_l(i) = subj_pd1(i).IE_L;
    pd1_sl_l(i) = subj_pd1(i).SL_L;
    pd2_cor_h(i) = 64-subj_pd2(i).TE_H;
    pd2_cat_h(i) = subj_pd2(i).CC_H;
    pd2_pe_h(i) = subj_pd2(i).PE_H;
    pd2_sl_h(i) = subj_pd2(i).SL_H;
    pd2_ie_l(i) = subj_pd2(i).IE_L;
    pd2_sl_l(i) = subj_pd2(i).SL_L;
    pd3_cor_h(i) = 64-subj_pd3(i).TE_H;
    pd3_cat_h(i) = subj_pd3(i).CC_H;
    pd3_pe_h(i) = subj_pd3(i).PE_H;
    pd3_sl_h(i) = subj_pd3(i).SL_H;
    pd3_ie_l(i) = subj_pd3(i).IE_L;
    pd3_sl_l(i) = subj_pd3(i).SL_L;
    pd4_cor_h(i) = 64-subj_pd4(i).TE_H;
    pd4_cat_h(i) = subj_pd4(i).CC_H;
    pd4_pe_h(i) = subj_pd4(i).PE_H;
    pd4_sl_h(i) = subj_pd4(i).SL_H;
    pd4_ie_l(i) = subj_pd4(i).IE_L;
    pd4_sl_l(i) = subj_pd4(i).SL_L;
    hc_medRT(i) = subj_hc(i).medRT;
    pd1_medRT(i) = subj_pd1(i).medRT;
    pd2_medRT(i) = subj_pd2(i).medRT;
    pd3_medRT(i) = subj_pd3(i).medRT;
    pd4_medRT(i) = subj_pd4(i).medRT;
end

% Now calculate RT as a function of feedback on the previous trial:
[hc_rt_pos, hc_rt_neg] = calculate_rt_stats(subj_hc, subjects);
[pd1_rt_pos, pd1_rt_neg] = calculate_rt_stats(subj_pd1, subjects);
[pd2_rt_pos, pd2_rt_neg] = calculate_rt_stats(subj_pd2, subjects);
[pd3_rt_pos, pd3_rt_neg] = calculate_rt_stats(subj_pd3, subjects);
[pd4_rt_pos, pd4_rt_neg] = calculate_rt_stats(subj_pd4, subjects);

fprintf('Note: These results are based on %d simulated subjects in each group\n', subjects);

%% This is the data for table 2
fprintf('Measure           & Value      \\\\ \\hline \n');
write_table2_line('Card correctly sorted', hc_cor_h);
write_table2_line('Categories achieved', hc_cat_h);
write_table2_line('Perseverative Errors', hc_pe_h);
write_table2_line('Set Loss errors', hc_sl_h);
write_table2_line('Integration Errors', hc_ie_l);
write_table2_line('RT (post positive feedback, in cycles)', hc_rt_pos);
write_table2_line('RT (post negative feedback, in cycles)', hc_rt_neg);
fprintf('\n\n');

%% This is the data for table 3
fprintf('Measure               & \multicolumn{2}{c}{PD$_1$} & \multicolumn{2}{c}{PD$_2$} & \multicolumn{2}{c}{PD$_3$} & \multicolumn{2}{c}{PD$_4$} \\\\ \\hline \n');
write_table3_line('Card correctly sorted', hc_cor_h, pd1_cor_h, pd2_cor_h, pd3_cor_h, pd4_cor_h);
write_table3_line('Categories achieved', hc_cat_h, pd1_cat_h, pd2_cat_h, pd3_cat_h, pd4_cat_h);
write_table3_line('Perseverative Errors', hc_pe_h, pd1_pe_h, pd2_pe_h, pd3_pe_h, pd4_pe_h);
write_table3_line('Set Loss errors', hc_sl_h, pd1_sl_h, pd2_sl_h, pd3_sl_h, pd4_sl_h);
write_table3_line('Integration Errors', hc_ie_l, pd1_ie_l, pd2_ie_l, pd3_ie_l, pd4_ie_l);
%write_table3_line('Median RT', hc_medRT, pd1_medRT, pd2_medRT, pd3_medRT, pd4_medRT);
write_table3_line('RT (post positive feedback, in cycles)', hc_rt_pos, pd1_rt_pos, pd2_rt_pos, pd3_rt_pos, pd4_rt_pos);
write_table3_line('RT (post negative feedback, in cycles)', hc_rt_neg, pd1_rt_neg, pd2_rt_neg, pd3_rt_neg, pd4_rt_neg);
fprintf('\n\n');

% Compare the effect of feedback to that in HC (this is effectively the
% interaction between group and feedback, which in the real data is not
% significant)
write_feedback_effect('PD1', hc_rt_pos, hc_rt_neg, pd1_rt_pos, pd1_rt_neg);
write_feedback_effect('PD2', hc_rt_pos, hc_rt_neg, pd2_rt_pos, pd2_rt_neg);
write_feedback_effect('PD3', hc_rt_pos, hc_rt_neg, pd3_rt_pos, pd3_rt_neg);
write_feedback_effect('PD4', hc_rt_pos, hc_rt_neg, pd4_rt_pos, pd4_rt_neg);
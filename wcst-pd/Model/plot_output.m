%% Plot action schemas (parietal/premotor) activation values

%fig = figure;
%tabgp = uitabgroup(fig); % Creates a tab group in the figure
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
%% Tab 1: Cognitive schemas (PFC)
%tab1 = uitab(tabgp,'Title','Cognitive schemas (PFC)');
%axs = axes('Parent',tab1); %Assigns the tab to the parent window
%axs.XTick = cumsum(decCounterTot);
figure;

nn = 1; 
%min_alpha_pfc = min(min((satfnc.alpha_pfc_hist)));
%max_alpha_pfc = max(max((satfnc.alpha_pfc_hist)));
min_alpha_sma = min(min((satfnc.alpha_sma_hist)));
max_alpha_sma = max(max((satfnc.alpha_sma_hist)));
counter.tt_trial_num = counter.tt_trial_num(counter.tt_trial_num~=0);

for sb = 1:3
    
     ax(sb) = subplot(3,1,nn);
     hold on;
     %grid on;
     plot(1:size(pfc.o_PFC,2), pfc.o_PFC(sb,:), 'k','LineWidth', 2.5);
     %plot(counter.tt_trial_num, (satfnc.alpha_pfc_hist(sb,:)-min_alpha_pfc)/(max_alpha_pfc-min_alpha_pfc), 'g.-', 'LineWidth', 2);
     plot(counter.tt_trial_num, satfnc.beta_str_pfc_hist(sb,:), 'r--', 'LineWidth', 3);
     
    % title(['\beta_{str}=', num2str(beta_str_pfc(sb),2), subTitleSchemaPFC(sb)], 'FontSize', 10);
    % Plot vertical lines each decMakInt timesteps (trial)
   
    % %{
    hold on;
    for idx = counter.tt_trial_num
        plot([idx idx], [-2 2], 'Color', 'k', 'LineStyle', '-.', 'LineWidth', 0.8);       
    end
    
    for idx = counter.tt_actpfc
        plot([idx idx], [-2 2], 'Color', 'b', 'LineStyle', ':', 'LineWidth', 0.8);       
    end
    %for 
    
    ylim([-0.1 1.1]);
    nn = nn + 1;
    
end

%%{
%% Tab 1: Motor schemas (SMA to M1)
%tab2 = uitab(tabgp,'Title','Motor schemas (SMA to M1)');
%axes('Parent',tab2); %Assigns the tab to the parent window
figure;
nn = 1; 
for sb = 1:4
    
    ax(sb+3) = subplot(4,1,nn);
    hold on;
    grid;
    plot(1:size(sma.o_SMA,2), sma.o_SMA(sb,:), 'LineWidth', 3);
    plot(1:size(sma.o_EXT_SMA,2), sma.o_EXT_SMA(sb,:), 'r--');
    plot(1:size(sma.w_SMA,2), sma.w_SMA(sb,:), 'c.-', 'LineWidth', 1.5);
    plot(counter.tt_trial_num, (satfnc.alpha_sma_hist(sb,:) - min_alpha_sma)/(max_alpha_sma - min_alpha_sma), 'g.-', 'LineWidth', 2);
   
    %title(['\beta_{str}=', num2str(beta_str_sma(sb),2), subTitleSchemaSMA(sb)], 'FontSize', 10);
    
    % Plot vertical lines each 200 timesteps (trial)
  
    hold on;
    for idx = counter.tt_trial_num
        plot([idx idx], [-2 2], 'Color', 'k', 'LineStyle', '-.', 'LineWidth', 0.8);       
    end
    
    for idx = counter.tt_actpfc
        plot([idx idx], [-2 2], 'Color', 'b', 'LineStyle', ':', 'LineWidth', 0.8);       
    end
    
    ylim([-0.1 1.1]); 
    nn = nn + 1;
    
end

linkaxes([ax(1),ax(2),ax(3),ax(4),ax(5),ax(6),ax(7)],'xy')
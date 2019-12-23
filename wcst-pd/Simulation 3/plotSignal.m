% plot ERN and PSP signals

function plotSignal(PSPsignal, ERNsignal)
    
    % ERN
    interval = 10;
    % Calculate values for normalisation (nanmin-nanmax)
    nanmin_signal = nanmin(nanmin(ERNsignal.ERN{:}));
    nanmax_signal = nanmax(nanmax(ERNsignal.ERN{:}));

    for nn = 1:2 

    ERNsignal.ERN{nn} = (ERNsignal.ERN{nn} - nanmin_signal)/(nanmax_signal - nanmin_signal);
    ERNsignal.ERN{nn} = smoothdata(ERNsignal.ERN{nn},'gaussian',2);

    hold on;

    pl(nn) = plot(1:2*interval+1,ERNsignal.ERN{nn},'LineWidth',1.2);    

    end

    xticks([1:1:2*interval+1]);
    xticklabels([-interval:1:interval]);
    legend([pl(1), pl(2)],{'HC','PD'});
    hold off;
    grid on;
    l1 = line([nanmedian(1:2*interval+1) nanmedian(1:2*interval+1)],[-0.1 1.1]);
    set(l1, 'LineStyle', '-.');
    set(l1,'HandleVisibility','off');
    
    figure;
    
    % PSP
    
    % Calculate values for normalisation (nanmin-nanmax)
    nanmin_signal = nanmin(nanmin(PSPsignal.PSPlink{:}));
    nanmax_signal = nanmax(nanmax(PSPsignal.PSPlink{:}));

    for nn = 1:nargin 

    PSPsignal.PSPlink{nn} = (PSPsignal.PSPlink{nn} - nanmin_signal)/(nanmax_signal - nanmin_signal);
    PSPsignal.PSPlink{nn} = smoothdata(PSPsignal.PSPlink{nn},'gaussian',3);

    hold on;

    pl(nn) = plot(1:4*interval+2,PSPsignal.PSPlink{nn},'LineWidth',1.2);   

    end

    xticks([1:4*interval+2]);
    x_ticks_labels = [-interval:1:interval, -interval:1:interval];
    xticklabels(x_ticks_labels);
    legend([pl(1), pl(2)],{'HC','PD'});
    hold off;
    grid on;
    line_posts = find(x_ticks_labels == 0);
    l1 = line([line_posts(1) line_posts(1)],[-0.2 1.2]);
    l2 = line([line_posts(2) line_posts(2)],[-0.2 1.2]);
    set(l1, 'LineStyle', '-.');
    set(l2, 'LineStyle', '-.');
    set(l1,'HandleVisibility','off');
    set(l2,'HandleVisibility','off');
    
end
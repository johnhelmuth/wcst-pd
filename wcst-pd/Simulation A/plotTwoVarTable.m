
%plotTwoVarTable('mean',{'\epsilon_{str}','\epsilon_{sma}'},{eps_str,eps_sma},{'TE','PE','SL','IE'},{Epsstr_Epssma.TE_H, Epsstr_Epssma.PE_L, Epsstr_Epssma.SL_L, Epsstr_Epssma.IE_L},{});

function plotTwoVarTable(modality,paramNames,paramList,varNames,varList,refLines)

subPlotDim = [ceil(sqrt(length(varList))),floor(sqrt(length(varList)))]; 
if length(varNames) ~= length(varList)
 error('The list of names and the list of variables must have the same number of elements');
end
if strcmp(modality, 'mean_prop')
 Xprop = input('How many stimuli (cards) each run? ');
end
pl = zeros(1,size(paramList{2},2));
cols = {'sr-','sb-','sg-','sm-','sk-'};
cols_ref = {'k--','r--','b--','m--'};

for nn = 1:length(varNames)  % number of plots
 figure; 
for cc = 1:size(paramList{2},2) % number of lines in each plot
  %subplot(subPlotDim(1),subPlotDim(2),nn);
  hold on;
  switch modality
   case 'mean'
    hold on;
    Xvar = trimmean(varList{nn},10,'round',3);
    XvarSE = nanstd(varList{nn},1,3)/sqrt(size(varList{nn},3));
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
   case 'mean_prop'
    hold on;
    Xvar = trimmean(varList{nn},10,'round',3)/Xprop;
    XvarSE = nanstd(varList{nn}/Xprop,1,3)/sqrt(size(varList{nn},3));
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
    ylim([-0.1 1.1]);
    xlim([min(paramList{1}(:)), max(paramList{1}(:))]);
   case 'mean_norm'
    hold on;
    Xmax = max(varList{nn}(:));
    Xvar = trimmean(varList{nn},10,'round',3)/Xmax;
    XvarSE = nanstd(varList{nn}/Xmax,1,3)/sqrt(size(varList{nn},3));
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
    ylim([-0.1 1.1]);
    xlim([min(paramList{1}(:))*0.9, max(paramList{1}(:))*1.1]);
   case 'mean_minmax'
    hold on;
    Xmax = nanmax(varList{nn}(:));
    Xmin = nanmin(varList{nn}(:));
    Xvar = (trimmean(varList{nn},10,'round',3) - Xmin) / (Xmax - Xmin);
    XvarSE = nanstd((varList{nn}-Xmin)/(Xmax-Xmin),1,3)/sqrt(size(varList{nn},3));
    pl(cc) = plot(paramList{1}, Xvar(:,cc),cols{cc});
    pl(cc) = errorbar(paramList{1}, Xvar(:,cc),XvarSE(:,cc),cols{cc});
    ylim([-0.1 1.1]);
    xlim([min(paramList{1}(:))*0.9, max(paramList{1}(:))*1.1]);
     
   case 'median'
    Xvar = median(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),'s-');
   case 'mode'
    Xvar = mode(varList{nn},3);
    pl(cc) = plot(paramList{1}, Xvar(:,cc),'s-');
  end
    legendText{cc} = [paramNames{2},' = ', num2str(paramList{2}(cc))]; 
 end
 
 xlabel(paramNames{1});
 title(varNames{nn});
 legend(pl, legendText);
 %xlim([0 0.5]);
 % plot reference lines
 if ~isempty(refLines)
  ref_line = [min(paramList{1}):0.01:max(paramList{1})];
  for rr = 1:length(refLines{nn})
    plot(ref_line,refLines{nn}(rr)*ones(1,length(ref_line)),cols_ref{rr});
  end
 end
 hold off; 
end


end
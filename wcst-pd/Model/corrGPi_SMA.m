
% calculate correlations for sma.o_GPi_SMA
% and sma.o_SMA.
% This should tell whether a greate schema inhibition
% effectively correspond to an attenuated schema activation
% a t+1 moment later
% This should be influenced by control but not to a large extent
% (in other words selection still has to happen irrespective
% of external control)

o_SMAval = sma.o_SMA;
o_GPi_SMAval = sma.o_GPi_SMA;
o_SMAval(o_SMAval == 0) = NaN;
shift_time = randi([1,10]);
o_SMAval = horzcat(nan(4,shift_time), o_SMAval(:,1:end-shift_time)); % t+1 shift
o_GPi_SMAval(o_GPi_SMAval == 0) = NaN;

for ss = 1:4
 o_SMArank(ss,:) = tiedrank(o_SMAval(ss,:));
 o_GPi_SMArank(ss,:) = tiedrank(o_GPi_SMAval(ss,:));
end

for ss = 1:4
 corrm = corrcoef(o_SMArank(ss,:)', o_GPi_SMArank(ss,:)','Rows','complete');
 sma.GPi_SMAcoeff(ss) = corrm(1,2);
end

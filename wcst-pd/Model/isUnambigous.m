function isUn = isUnambigous(feature_trial_input,trial_num,nn)
% checks that the last nn trial_nums of
% the vector input are unambigous
isUn = 0;
  
if sum(~cellfun(@isempty, feature_trial_input)) > nn   
                
                lastNNFeatTrials = cellstr(feature_trial_input(trial_num-nn:trial_num-1));
                for ii = 1:nn
                
                    lastNNFeatTrialsLength(ii) = length(lastNNFeatTrials{ii});
                
                end
                if any(lastNNFeatTrialsLength == 1) % unumbigous responses
                    
                    isUn = 1;
                
                end
end
            
end
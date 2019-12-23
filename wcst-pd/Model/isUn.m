function isUn_out = isUn(isUn_in)

% checks if there is
% at least a row vector 
% in the matrix isUn_in
% that does not have a
% repetition in the number
% eg.
% 2           2           4  rep
% 4           4           2  rep
% 3           3           3  rep
% 2           1           1  rep
% 1           2           3  NONrep

isUn_out = 0;
repCounter = zeros(size(isUn_in,1),1);

for ii = 1:size(isUn_in,1)
    
    if length(unique(isUn_in(ii,:))) < length(isUn_in(ii,:))
        repCounter(ii) = 1;
    end
end

if any(repCounter == 0)
    isUn_out = 1;
end

end 


function cost = cost_bts(var_inputs,var_targets)
num_bts = 10000;
z_bts = nan(length(var_inputs),num_bts);

for ii = 1:length(var_inputs)
    n_min(ii) = min(length([var_inputs{ii}]),length([var_targets{ii}]));
    for cc = 1:num_bts
        rs1 = randsample(var_inputs{ii},n_min(ii),true);
        rs2 = randsample(var_targets{ii},n_min(ii),true);
        z_bts(ii,cc) = abs(nanmean(rs1) - nanmean(rs2))/nanstd(var_targets{ii});
    end
end

cost = mean(z_bts(:));

end
for ss = [1 2 3 4]
    %% STRIATUM D1
    sma.u_ST1_SMA(ss,tt) = sma.o_SMA(ss,tt);
    sma.a_ST1_SMA(ss,tt) = (decay_constant)*sma.a_ST1_SMA(ss,tt-1) + (1-decay_constant)*sma.u_ST1_SMA(ss,tt); 
    sma.o_ST1_SMA(ss,tt) = sigmf(sma.a_ST1_SMA(ss,tt), [satfnc.alpha_str_sma satfnc.beta_str_sma(ss)]);
    
end
for ss = [1 2 3 4]
    %% STRIATUM D2
    sma.u_ST2_SMA(ss,tt) = sma.o_SMA(ss,tt);
    sma.a_ST2_SMA(ss,tt) = (decay_constant)*sma.a_ST2_SMA(ss,tt-1) + (1-decay_constant)*sma.u_ST2_SMA(ss,tt); 
    sma.o_ST2_SMA(ss,tt) = sigmf(sma.a_ST2_SMA(ss,tt), [satfnc.alpha_str_sma satfnc.beta_str_sma(ss)]);
 
end 
for ss = [1 2 3 4]
    %% STN
    sma.u_STN_SMA(ss,tt) = sma.o_SMA(ss,tt).* bg.W_STN + sma.o_GPe_SMA(ss,tt-1) .* bg.W_GPe_GPi;
    sma.a_STN_SMA(ss,tt) = (decay_constant)*sma.a_STN_SMA(ss,tt-1) + (1-decay_constant)*sma.u_STN_SMA(ss,tt); 
    sma.o_STN_SMA(ss,tt) = sigmf(sma.a_STN_SMA(ss,tt), [satfnc.alpha_stn satfnc.beta_stn_sma(ss)]);
  
end
for ss = [1 2 3 4]
    %% GPe 
    sma.u_GPe_SMA(ss,tt)  = (sum(sma.o_STN_SMA(:,tt)) .* bg.W_STN_GPe) + (sma.o_ST2_SMA(ss,tt) .* bg.W_ST2_GPe);
    sma.a_GPe_SMA(ss,tt) = (decay_constant)*sma.a_GPe_SMA(ss,tt-1) + (1-decay_constant)*sma.u_GPe_SMA(ss,tt); 
    sma.o_GPe_SMA(ss,tt) = sigmf(sma.a_GPe_SMA(ss,tt), [satfnc.alpha_gpe satfnc.beta_gpe_sma(ss)]);
  
end
for ss = [1 2 3 4]
    %% GPi
    sma.u_GPi_SMA(ss,tt) = (sum(sma.o_STN_SMA(:,tt)) .* bg.W_STN_GPi) + (sma.o_GPe_SMA(ss,tt-1) .* bg.W_GPe_GPi) + (sma.o_ST1_SMA(ss,tt-1) .* bg.W_ST1_GPi);
    sma.a_GPi_SMA(ss,tt) = (decay_constant)*sma.a_GPi_SMA(ss,tt-1) + (1-decay_constant)*sma.u_GPi_SMA(ss,tt); 
    sma.o_GPi_SMA(ss,tt) = sigmf(sma.a_GPi_SMA(ss,tt), [satfnc.alpha_gpi satfnc.beta_gpi_sma(ss)]);

end
%% Output
    
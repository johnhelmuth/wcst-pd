for ss = [1 2 3]
    %% STRIATUM D1
    pfc.u_ST1_PFC(ss,tt) = pfc.o_PFC(ss,tt);
    pfc.a_ST1_PFC(ss,tt) = (decay_constant)*pfc.a_ST1_PFC(ss,tt-1) + (1-decay_constant)*pfc.u_ST1_PFC(ss,tt); 
    pfc.o_ST1_PFC(ss,tt) = sigmf(pfc.a_ST1_PFC(ss,tt), [satfnc.alpha_str_pfc satfnc.beta_str_pfc(ss)]);
    
end
for ss = [1 2 3]
    %% STRIATUM D2
    pfc.u_ST2_PFC(ss,tt) = pfc.o_PFC(ss,tt);
    pfc.a_ST2_PFC(ss,tt) = (decay_constant)*pfc.a_ST2_PFC(ss,tt-1) + (1-decay_constant)*pfc.u_ST2_PFC(ss,tt); 
    pfc.o_ST2_PFC(ss,tt) = sigmf(pfc.a_ST2_PFC(ss,tt), [satfnc.alpha_str_pfc satfnc.beta_str_pfc(ss)]);
  
end
for ss = [1 2 3] 
    %% STN
    pfc.u_STN_PFC(ss,tt) = pfc.o_PFC(ss,tt).* bg.W_STN + pfc.o_GPe_PFC(ss,tt-1) .* bg.W_GPe_GPi;
    pfc.a_STN_PFC(ss,tt) = (decay_constant)*pfc.a_STN_PFC(ss,tt-1) + (1-decay_constant)*pfc.u_STN_PFC(ss,tt); 
    pfc.o_STN_PFC(ss,tt) = sigmf(pfc.a_STN_PFC(ss,tt), [satfnc.alpha_stn satfnc.beta_stn_pfc(ss)]);
  
end
for ss = [1 2 3]
    %% GPe 
    pfc.u_GPe_PFC(ss,tt)  = (sum(pfc.o_STN_PFC(:,tt)) .* bg.W_STN_GPe) + (pfc.o_ST2_PFC(ss,tt) .* bg.W_ST2_GPe);
    pfc.a_GPe_PFC(ss,tt) = (decay_constant)*pfc.a_GPe_PFC(ss,tt-1) + (1-decay_constant)*pfc.u_GPe_PFC(ss,tt); 
    pfc.o_GPe_PFC(ss,tt) = sigmf(pfc.a_GPe_PFC(ss,tt), [satfnc.alpha_gpe satfnc.beta_gpe_pfc(ss)]);
  
end
for ss = [1 2 3]
    %% GPi
    pfc.u_GPi_PFC(ss,tt) = (sum(pfc.o_STN_PFC(:,tt)) .* bg.W_STN_GPi) + (pfc.o_GPe_PFC(ss,tt-1) .* bg.W_GPe_GPi) + (pfc.o_ST1_PFC(ss,tt-1) .* bg.W_ST1_GPi);
    pfc.a_GPi_PFC(ss,tt) = (decay_constant)*pfc.a_GPi_PFC(ss,tt-1) + (1-decay_constant)*pfc.u_GPi_PFC(ss,tt); 
    pfc.o_GPi_PFC(ss,tt) = sigmf(pfc.a_GPi_PFC(ss,tt), [satfnc.alpha_gpi satfnc.beta_gpi_pfc(ss)]);

end
%% Output
    
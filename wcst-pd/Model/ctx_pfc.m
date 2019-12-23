for ss = [1 2 3]
    
pfc.u_PFC(ss,tt) = o_EXT_PFC(ss,tt) + pfc.o_THAL_PFC(ss,tt) + weights.w_RULE_SELF; 
pfc.a_PFC(ss,tt) = (decay_constant)*pfc.a_PFC(ss,tt-1) + (1-decay_constant)*pfc.u_PFC(ss,tt-1); 
pfc.o_PFC(ss,tt) = sigmf(pfc.a_PFC(ss,tt), [satfnc.alpha_pfc satfnc.beta_pfc(ss)]);

end
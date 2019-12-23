for ss = [1 2 3 4]

sma.w_SMA(ss,tt) = weights.w_RULE_BASED(ss,:)*pfc.o_PFC(:,tt-1); %application of rules

sma.u_SMA(ss,tt) = sma.w_SMA(ss,tt) + sma.o_EXT_SMA(ss,tt) + sma.o_THAL_SMA(ss,tt) + weights.w_RULE_SELF; 
sma.a_SMA(ss,tt) = (decay_constant)*sma.a_SMA(ss,tt-1) + (1-decay_constant)*sma.u_SMA(ss,tt-1); 
sma.o_SMA(ss,tt) = sigmf(sma.a_SMA(ss,tt), [satfnc.alpha_sma(ss) satfnc.beta_sma(ss)]);

end
for ss = [1 2 3 4]
    
sma.u_THAL_SMA(ss,tt) = ((sma.o_GPi_SMA(ss,tt))); 
sma.a_THAL_SMA(ss,tt) = (decay_constant)*sma.a_THAL_SMA(ss,tt - 1) + (1 - decay_constant)*sma.u_THAL_SMA(ss,tt - 1); 
sma.o_THAL_SMA(ss,tt) = -sigmf(sma.a_THAL_SMA(ss,tt), [satfnc.alpha_thal satfnc.beta_thal]);

end

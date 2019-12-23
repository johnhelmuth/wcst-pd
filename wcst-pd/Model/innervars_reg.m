% Internal variables
 
 innervars.alpha_sma(tt) = median(satfnc.alpha_sma);
 innervars.alpha_sma_diff(tt) = innervars.alpha_sma(tt) - innervars.alpha_sma(tt-1);
 innervars.prod_sma(tt) = prod( sma.o_SMA(:,tt) );
 innervars.prod_pfc(tt) = prod( pfc.o_PFC(:,tt) );
 innervars.prod_smapfc(tt) = prod( sma.o_SMA(:,tt).*sma.w_SMA(:,tt) );
 innervars.prod_sma_log_diff(tt) = prod((log( abs(sma.o_SMA(:,tt) - sma.o_SMA(:,tt-1)) )));
 
 % this amplifies the difference but retains the sign of the gradient
 innervars.prod_sma_diff(tt) = prod(( 2.^((sma.o_SMA(:,tt)) - 2.^(sma.o_SMA(:,tt-1))) ));

 innervars.absmax_diff(tt) = absmax((sma.o_SMA(:,tt)) - (sma.o_SMA(:,tt-1)));
 innervars.absmax_diff_pfc(tt) = absmax((pfc.o_PFC(:,tt)) - (pfc.o_PFC(:,tt-1)));

 innervars.absmax_exp_diff(tt) = absmax(2.^(sma.o_SMA(:,tt)) - 2.^(sma.o_SMA(:,tt-1)));

 innervars.var_pfc_diff(tt) = var( pfc.o_PFC(:,tt) - pfc.o_PFC(:,tt-1));
 
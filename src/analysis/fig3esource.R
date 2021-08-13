#--------Libraries------------
library(dplyr)
library(ggplot2)

data_fig3e = function(timing){

timing_m <- timing %>% group_by(subjid, te, actual) %>% summarise_at(vars("reported"), mean) 
timing_sd <- timing %>% group_by(subjid, te, actual) %>% summarise_at(vars("reported"), sd) 
timing_sdm = timing_m
timing_sdm$sd = timing_sd$reported
timing_sdm$sdm = timing_sd$reported / timing_m$reported
return(timing_sdm)
}

#-----
fig3e = function(timing){
  timing_sdm = data_fig3e(timing)
  bte <- ggplot(timing_sdm[timing_sdm$te==1,], aes(x = factor(actual), y = sdm, group = actual)) + 
    geom_boxplot(color = 'blue', outlier.shape=8,
                 outlier.size=.5) +
    labs(x = 'Actual Time', y = 'Reported Time SD / M') +
    ylim(0, 0.6) +
    theme(text = element_text(size=15)) +
    theme_bw()
  #ggsave(paste0('../../fig/','Fig3e_te.pdf'),plot=bte, units = 'cm', width=3, height =7) 
  btp <- ggplot(timing_sdm[timing_sdm$te==0,], aes(x = factor(actual), y = sdm, group = actual)) + 
    geom_boxplot(color = 'red', outlier.shape=8,
                 outlier.size=.5) +
    labs(x = 'Actual Time', y = 'Reported Time SD / M') +
    ylim(0, 0.6) +
    theme(text = element_text(size=15)) +
    theme_bw()
  #ggsave(paste0('../../figs/','Fig3e_tp.pdf'),plot=btp, units = 'cm', width=3, height =7) 
  return(list(bte, btp))
}
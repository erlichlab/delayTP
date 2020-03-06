# Setup -----------
library(magrittr)
library(dplyr)
library(forcats)
library(tidyr)
library(modelr)
library(tidybayes)
library(ggplot2)
library(ggstance)
library(ggridges)
library(cowplot)
library(rstan)
library(brms)
library(latex2exp)
library(data.table)
theme_set(theme_tidybayes() +  background_grid())
bino = function(x){
  out = binom.test(sum(x), length(x))
  df = data.frame(y = mean(x), ymin=out$conf.int[1], ymax=out$conf.int[2])
  return(df)
}

plot_subject_h = function(sind,fits,these_trials){
  sr = nv_r2 %>% filter(subjid==subjids[sind], treat=='S') %>% select(r2) %>% as.double()
  lr = nv_r2 %>% filter(subjid==subjids[sind], treat=='L') %>% select(r2) %>% as.double()
  fitstr1 = sprintf('log(k)\\[SV,LV\\]=\\[$%.1f, %.1f$\\]',
                    fits$K_S[sind], fits$K_L[sind])
  
  fitstr2= sprintf('$\\tau$\\[SV,LV\\]=\\[$%.1f, %.1f$\\]',
                   exp(fits$noise_S[sind]),exp(fits$noise_L[sind]))
  
  fitstr3 =  sprintf('$r^2$\\[SV,LV\\]=\\[$%0.2f,%0.2f$\\]', sr, lr)
  p=df.subj %>%  
    ggplot(aes(x = rewmag, y = .value, color = ordered(delay), fill = ordered(delay))) + 
    facet_grid(treat~delay, labeller = labeller(.multi_line = FALSE)) +
    stat_lineribbon(aes(y = .value), .width = c(.99, .80, .50), alpha = 1/4, size = 0.1) + 
    stat_summary(size = .05, fun.data = bino, data = these_trials %>% mutate(.value=choice)) +
    labs(y='P(Chose Later)', x='Reward Magnitude', color='Delay') + #, title=TeX(fitstr1), subtitle = TeX(fitstr2)) +
    guides(fill='none', color='none') +
    scale_y_continuous(breaks=c(0,0.5,1)) +
    scale_x_continuous(breaks = c(0,5,10)) +
    theme( # plot.subtitle = element_text(hjust=0, size=8,margin=margin(1,1,1,1)), plot.title = element_text(hjust=0, size=8,margin=margin(1,1,1,1)),
      plot.margin = margin(30,1,1,1),
      text = element_text(size=7),
      strip.text = element_text(color = "black", 
                                margin = margin(1, 1, 1, 1))
    )
  q = ggdraw(p) +
    draw_label(TeX(fitstr1), x = 0.05,y = 0.98, hjust = 0, vjust = 1,size=6) +
    draw_label(TeX(fitstr2), x = 0.05,y = 0.94, hjust = 0, vjust = 1,size=6) +
    draw_label(TeX(fitstr3), x = 0.05,y = 0.90, hjust = 0, vjust = 1,size=6)
  
  #ggsave(paste0('../../figs/subj_figs/','naive_f_',sind,'.pdf'),plot=q, units = 'in', width=2.5, height =2.5)
  return(q)
}

#-----
# Data ==========
# selected subjects
subjids <- c(49)
fig2c = function(naive_trials,newgr,nv_r2){
  fits = newgr %>% filter(subjid == 49)
  these_trials = naive_trials %>% filter(subjid == 49)
  these_trials$treat = factor(these_trials$treat, levels=c('S','L'), labels=c('SV','LV'))
  p = plot_subject_h(1,fits,these_trials)
  return(p)
}
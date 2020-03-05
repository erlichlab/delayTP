# TP_posterior

# Setup -------

library(bayesplot)
library(brms)
#library(ggthemes)
library(ggplot2)

plot_each = function(x, xl){
  p = mcmc_areas(x, prob=.8, prob_outer = 0.9999, point_est = 'mean') +  
    vline_at(x, colMeans, size=.1, color='gray') +
    theme(text = element_text(family = 'sans')) +
    scale_y_discrete(expand = expand_scale(add = c(.5,1.2))) + 
    xlab(xl)
  return(p)
}
# noise in naive model is parameterized as exp(noise) - 
# so to compare between previous paper need to exp()
plot_fit_n = function(logk, noise){
  pn = plot_each(noise, 'noise') + scale_x_continuous(limits=c(-0.7,0.3), breaks = c(-0.6,-0.2,0.2),labels = c('-0.6','-0.2','0.2'))
  #pn = plot_each(exp(noise), 'noise') + scale_x_continuous(limits=c(0.4,1.2), breaks = c(0.5,0.8,1.1),labels = c('0.5','0.8','1.1'))
  pk = plot_each(logk, 'log(k)') + scale_x_continuous(limits=c(-7,-1), breaks = c(-6,-4,-2),labels = c('-6','-4','-2'))
  pg = bayesplot_grid(pk,pn, grid_args = c(ncol=2))
  return(pg)
}

fig2b = function(posterior){
  pg = plot_fit_n(posterior$logk, posterior$noise)
  #ggsave('../../figs/fig2b.pdf',
  #       units = 'in', width = 3, height = 3, scale = 1, plot = pg)
  return(pg)
}

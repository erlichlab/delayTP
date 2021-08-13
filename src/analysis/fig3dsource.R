#--------Libraries------------
library(dplyr)
library(ggplot2)
library(data.table)
library(latex2exp)
library(lme4)
library(reshape2)

data_fig3d = function(timing){

wdf =  copy(timing) %>% group_by(subjid, actual, te) %>% 
  dplyr::summarize(task_time_mean = mean(reported),
                   wssd=sd(reported+rnorm(length(reported))))  %>%  
  mutate(task=ifelse(te==1,'Te','Tp'))  %>%
  rename(`Actual Time`= actual)

wdf = wdf %>% group_by(`Actual Time`,task) %>% mutate(outlier = wssd > 3*mean(wssd))
unique(wdf$subjid)
wdfX = wdf %>% filter(outlier==FALSE)
unique(wdfX$subjid)
head(wdfX %>% arrange(subjid, `Actual Time`))
return(wdf)
}

#-----
fig3d = function(timing){
  wdf = data_fig3d(timing)
  p = ggplot(wdf , aes(x=wssd, group =`Actual Time`, color=factor(`Actual Time`)))
  p1 = p + geom_density(bw=.8) + facet_wrap(.~ task) + xlim(c(0,15)) + xlab(TeX("Within-subject $\\sigma$")) + labs(color='Actual Time') + theme_bw()
  m_within = lm(wssd ~ `Actual Time`*task, data = wdf %>% filter(outlier==FALSE))
  m_re = lmer(wssd ~ `Actual Time`*task + (task|subjid), data = wdf, REML=FALSE)
  #ggsave(paste0('../../figs/','Fig3d.pdf'),plot=p1, units = 'cm', width=10, height =6) 
  return(p1)
  
}
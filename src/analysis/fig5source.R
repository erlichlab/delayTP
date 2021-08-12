# Drop variable from regression - analysis of TP for new and followup separately
library(data.table)
require(lme4)
require(ggplot2)
require(latex2exp)
require(brms)
require(car)
require(lmtest)
require(GGally)
require(cowplot)
library(stargazer)

library(dplyr)

plot_it2 = function(dropmod, labs){
  dropmod$name = rownames(dropmod)
  dropmod$`p<0.005` = dropmod$`Pr(>Chi)`<0.05/4
  dropmod$`deltaAIC` = dropmod$AIC - dropmod$AIC[1]
  dropmod = subset(dropmod, name!="<none>", drop=TRUE)
  dropmod$name <- factor(dropmod$name, levels = dropmod$name)
  p = ggplot(data=dropmod, aes(x=name, y=deltaAIC, fill=`p<0.005`)) + 
    geom_bar(stat="identity", size=0.1, position = position_dodge(width = 0.1), color='black') +
    scale_fill_manual(values=c("#999999","#111111")) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0.5)) +
    xlab('Dropped variable') + ylab(TeX('$\\Delta$AIC')) +
    scale_x_discrete(breaks=dropmod$name,
                     labels=setNames(c(unlist(labs)),dropmod$name))
  return(p)
}

fig5 = function(tpdata){
  tpdata1 = subset(tpdata,MTpRatio<2); # define the group without the outlier
  modSF = lm(K_S ~ K_L + ICSe + ICSp + ICSErr, data=tpdata1)
  modLF = lm(K_L ~ K_S + ICSe + ICSp + ICSErr, data=tpdata1)
  
  dropSF = as.data.frame(drop1(modSF, test = 'Chisq'))
  dropLF = as.data.frame(drop1(modLF, test = 'Chisq'))
  dropSF.labels = lapply(list("K_{LV}","ICSe","ICSp","ICSErr"), TeX)
  dropLF.labels = lapply(list("K_{SV}","ICSe","ICSp","ICSErr"), TeX)
  
  p1 = plot_it2(dropSF, dropSF.labels) + ggtitle(TeX('$K_{SV}$')) + theme(legend.position="none")
  p2 = plot_it2(dropLF, dropLF.labels) + ggtitle(TeX('$K_{LV}$')) + theme(legend.position="none")
  
  p12 = plot_grid(p1,p2, align="v", ncol=3)
  return(p12)
}
table2S = function(tpdata){
  tpdata1 = subset(tpdata,MTpRatio<2); # define the group without the outlier
  modSF = lm(K_S ~ K_L + ICSe + ICSp + ICSErr, data=tpdata1)
  modSF1 = lm(K_S ~ K_L, data=tpdata1)
  modSF2 = lm(K_S ~ K_L + ICSe, data=tpdata1)

  #tS <- stargazer(modSF, modSF1, title="K_S Regression Results", align=TRUE, dep.var.labels=c("Log(k_{SV})"), covariate.labels=c("Log(k_{LV})","ICSe","ICSp","ICSErr"), no.space=TRUE)
  tS <- stargazer(modSF, modSF1, modSF2, title="K_S Regression Results", align=TRUE, dep.var.labels=c("Log(k_{SV})"), covariate.labels=c("Log(k_{LV})","ICSe","ICSp","ICSErr"), no.space=TRUE)
  return(tS)
}
table2L = function(tpdata){
  tpdata1 = subset(tpdata,MTpRatio<2); # define the group without the outlier
  modLF = lm(K_L ~ K_S + ICSe + ICSp + ICSErr, data=tpdata1)
  modLF1 = lm(K_L ~ K_S, data=tpdata1)
  
  tL <- stargazer(modLF, modLF1, title="K_L Regression Results", align=TRUE, dep.var.labels=c("Log(k_{LV})"), covariate.labels=c("Log(k_{SV})","ICSe","ICSp","ICSErr"), no.space=TRUE)
  return(tL)
}

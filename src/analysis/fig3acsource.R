library(ggplot2)
library(data.table)
# selected subjects
subjids <- c(43, 6, 13)
# power and linear fits for the individual timing
plot_subject_tep = function(sind,tetp,tptp,subj_te,subj_tp){
  te = tetp %>% filter(subjid == subjids[sind])
  tp = tptp %>% filter(subjid == subjids[sind])
  a <-subj_te$a[subj_te$subjid == subjids[sind]]
  b <-subj_te$b[subj_te$subjid == subjids[sind]]
  al <-subj_te$al[subj_te$subjid == subjids[sind]]
  a1 <-subj_tp$a[subj_tp$subjid == subjids[sind]]
  b1 <-subj_tp$b[subj_tp$subjid == subjids[sind]]
  al1 <-subj_tp$al[subj_tp$subjid == subjids[sind]]
  #abc = 'abc'
  fun.tep <- function(x) a*x^b
  fun.tpp <- function(x) a1*x^b1
  p <- ggplot(te,aes(x = actual, y = reported, group = actual)) + 
    geom_point(color="lightskyblue2") +
    stat_summary(fun.y=mean, geom="point", shape="\U2014", size=4, colour="dodgerblue4") +
    stat_function(fun = fun.tep, color="blue", size = 0.1) +
    geom_abline(intercept = 0, slope = 1, color="black", size = 0.3, linetype = "dotted") +
    geom_abline(intercept = 0, slope = al, color="blue", size = 0.1, linetype = "dashed") +
    geom_point(data=tp, color = "rosybrown2") +
    stat_summary(data=tp, fun.y=mean, geom="point", shape="\U2014", size=4, colour="rosybrown") +
    stat_function(fun = fun.tpp, color="red", size = 0.1) +
    geom_abline(intercept = 0, slope = al1, color="red", size = 0.1, linetype = "dashed") +
    ylim(0,90) + #125
    labs(y='Reported Time', x='Actual Time') +
    theme(text = element_text(size=20)) #15
  #ggsave(paste0('../../figs/','Fig3',substr(abc, sind, sind),'.pdf'),plot=p, units = 'in', width=4, height =3) #width=3, height =4
  return(p)
}

#-----
fig3ac = function(tetp,tptp,subj_te,subj_tp){
  for (x in seq(1,length(subjids))){
    assign(paste("p", x, sep = ""), plot_subject_tep(x,tetp,tptp,subj_te,subj_tp))
  }
  return(list(p1, p2, p3))
}
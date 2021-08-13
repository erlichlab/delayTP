function fig4ab_lc()
load('../../data/delaytp.mat');
%define the group without the outlier
all_delaytp = [followup;new];
all_delaytp1 = all_delaytp;
all_delaytp1(all_delaytp1.MTpRatio>2,:)=[];
% 1. Joint group log(K_S) against everything else
threecorrelationplots(all_delaytp1.SV,all_delaytp1.ICSe,all_delaytp1.ICSp,all_delaytp1.ICSErr,'log(k_{SV})','ICSe','ICSp','ICSErr');
saveas(gcf,'../../figs/fig4abc_l.pdf');
% 2. Joint group log(K_L) against everything else
threecorrelationplots(all_delaytp1.LV,all_delaytp1.ICSe,all_delaytp1.ICSp,all_delaytp1.ICSErr,'log(k_{LV})','ICSe','ICSp','ICSErr');
saveas(gcf,'../../figs/fig4abc_c.pdf');
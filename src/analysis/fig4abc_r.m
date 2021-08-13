function fig4abc_r()
load('../../data/delaytp.mat');
%define the group without the outlier
all_delaytp = [followup;new];
all_delaytp1 = all_delaytp;
all_delaytp1(all_delaytp1.MTpRatio>2,:)=[];
% ICSe
distributionplots(all_delaytp1.ICSe(all_delaytp1.LV>all_delaytp1.SV),all_delaytp1.ICSe(all_delaytp1.LV<all_delaytp1.SV),nan,'K_{LV}>K_{SV}','K_{SV}>K_{LV}',nan);
saveas(gcf,'../../figs/fig4a_r.pdf')
% ICSp
distributionplots(all_delaytp1.ICSp(all_delaytp1.LV>all_delaytp1.SV),all_delaytp1.ICSp(all_delaytp1.LV<all_delaytp1.SV),nan,'K_{LV}>K_{SV}','K_{SV}>K_{LV}',nan);
saveas(gcf,'../../figs/fig4b_r.pdf')
% ICSErr
% Uncomment options for Fig 4c in function distributionplots.m
distributionplots(all_delaytp1.ICSErr(all_delaytp1.LV>all_delaytp1.SV),all_delaytp1.ICSErr(all_delaytp1.LV<all_delaytp1.SV),nan,'K_{LV}>K_{SV}','K_{SV}>K_{LV}',nan);
saveas(gcf,'../../figs/fig4c_r.pdf')
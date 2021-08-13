function fig3fh()
load('../../data/delaytp.mat');
%define the group without the outlier
all_delaytp = [followup;new];
all_delaytp1 = all_delaytp;
all_delaytp1(all_delaytp1.MTpRatio>2,:)=[];
correlationplot(all_delaytp1.ICSe,all_delaytp1.ICSp,'ICSe','ICSp');
saveas(gcf,'../../figs/fig3f.pdf')
correlationplot(all_delaytp1.ICSp,all_delaytp1.ICSErr,'ICSp','ICSError');
saveas(gcf,'../../figs/fig3g.pdf')
correlationplot(all_delaytp1.ICSErr,all_delaytp1.ICSe,'ICSError','ICSe');
saveas(gcf,'../../figs/fig3h.pdf')
% Insets
distributionplots(all_delaytp1.ICSe,nan,nan,'ICSe',nan,nan);
saveas(gcf,'../../figs/fig3f_ins.pdf')
distributionplots(all_delaytp1.ICSp,nan,nan,'ICSp',nan,nan);
saveas(gcf,'../../figs/fig3g_ins.pdf')
% Uncomment options for Fig 3h inset in function distributionplots.m
distributionplots(all_delaytp1.ICSErr,nan,nan,'ICSError',nan,nan);
saveas(gcf,'../../figs/fig3h_ins.pdf')
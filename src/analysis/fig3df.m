function fig3df()
load('~/repos/delaytp/data/delaytp.mat');
%define the group without the outlier
followup1 = followup; 
followup1(followup1.MTpRatio>2,:)=[]; 
distributionplots(followup1.ICSe,new.ICSe,nan,'ICSe \nfollow-up','ICSe \nnew',nan);
saveas(gcf,'~/repos/delaytp/figs/fig3d.pdf')
distributionplots(followup1.ICSp,new.ICSp,nan,'ICSp \nfollow-up','ICSp \nnew',nan);
saveas(gcf,'~/repos/delaytp/figs/fig3e.pdf')
% Uncomment options for Fig 3f in function distributionplots.m
distributionplots(followup1.ICSErr,new.ICSErr,nan,'ICSError \nfollow-up','ICSError \nnew',nan);
saveas(gcf,'~/repos/delaytp/figs/fig3f.pdf')
function fig4cf()
load('../../data/delaytp.mat');
%define the group without the outlier
followup1 = followup; 
followup1(followup1.MTpRatio>2,:)=[]; 
% follow-up
distributionplots(followup1.ICSe(followup1.LV>followup1.SV),followup1.ICSe(followup1.LV<followup1.SV),nan,'K_{LV}>K_{SV}','K_{SV}>K_{LV}',nan);
saveas(gcf,'../../figs/fig4c.pdf')
% new
distributionplots(new.ICSe(new.LV>new.SV),new.ICSe(new.LV<new.SV),nan,'K_{LV}>K_{SV}','K_{SV}>K_{LV}',nan);
saveas(gcf,'../../figs/fig4f.pdf')
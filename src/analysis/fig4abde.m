function fig4abde()
load('../../data/delaytp.mat');
%define the group without the outlier
followup1 = followup; 
followup1(followup1.MTpRatio>2,:)=[]; 
% 1. follow-up group log(K_S) against everything else
threecorrelationplots(followup1.SV,followup1.ICSe,followup1.ICSp,followup1.ICSErr,'log(k_{SV})','ICSe','ICSp','ICSErr');
saveas(gcf,'../../figs/fig4a.pdf');
% 2. follow-up group log(K_L) against everything else
threecorrelationplots(followup1.LV,followup1.ICSe,followup1.ICSp,followup1.ICSErr,'log(k_{LV})','ICSe','ICSp','ICSErr');
saveas(gcf,'../../figs/fig4b.pdf');
% 3. new group log(K_S) against everything else
threecorrelationplots(new.SV,new.ICSe,new.ICSp,new.ICSErr,'log(k_{SV})','ICSe','ICSp','ICSErr');
saveas(gcf,'../../figs/fig4d.pdf');
% 4. new group log(K_L) against everything else
threecorrelationplots(new.LV,new.ICSe,new.ICSp,new.ICSErr,'log(k_{LV})','ICSe','ICSp','ICSErr');
saveas(gcf,'../../figs/fig4e.pdf');
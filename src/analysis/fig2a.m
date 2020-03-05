function fig2a()
load('../../data/delaytp.mat');
% prepare data
followup_a = table2array(followup(:,:)); % followup group
fs_idx = find(strcmpi(followup.Properties.VariableNames,'SV'));
fse_idx = find(strcmpi(followup.Properties.VariableNames,'SVsd'));
fl_idx = find(strcmpi(followup.Properties.VariableNames,'LV'));
fle_idx = find(strcmpi(followup.Properties.VariableNames,'LVsd'));
fs(:,1) = followup_a(:,fs_idx);
fs(:,2) = followup_a(:,fse_idx);
fs(:,3) = fs(:,2);
fl(:,1) = followup_a(:,fl_idx);
fl(:,2) = followup_a(:,fle_idx);
fl(:,3) = fl(:,2);
new_a = table2array(new(:,:)); % new group
ns_idx = find(strcmpi(new.Properties.VariableNames,'SV'));
nse_idx = find(strcmpi(new.Properties.VariableNames,'SVsd'));
nl_idx = find(strcmpi(new.Properties.VariableNames,'LV'));
nle_idx = find(strcmpi(new.Properties.VariableNames,'LVsd'));
ns(:,1) = new_a(:,ns_idx);
ns(:,2) = new_a(:,nse_idx);
ns(:,3) = ns(:,2);
nl(:,1) = new_a(:,nl_idx);
nl(:,2) = new_a(:,nle_idx);
nl(:,3) = nl(:,2);

% Fig 2A
figure;
cl1 = colormap(parula(10));
x1 = fs;
y1 = fl;
x2 = ns;
y2 = nl;
x=[x1;x2];
y=[y1;y2];
e = errbar(x(:,1),y(:,1),y(:,2),y(:,3),'Color', [0.6 0.6 0.6]);
hold on;
ex = errbar(x(:,1),y(:,1),x(:,2),x(:,3),'horiz','Color', [0.6 0.6 0.6]);
b1  = deming(x1(:,1), y1(:,1));
h3 = plot([-10; x1(:,1); 4],b1(1) + b1(2).*[-10; x1(:,1); 4],'Color',cl1(1,:));
b2  = deming(x2(:,1), y2(:,1));
h4 = plot([-10; x2(:,1); 4],b2(1) + b2(2).*[-10; x2(:,1); 4],'Color',cl1(6,:));
s1 = scatter(x1(:,1),y1(:,1),[],cl1(1,:),'filled','MarkerEdgeColor',[0.3 0.3 0.3]);
hold on;
s2 = scatter(x2(:,1),y2(:,1),[],cl1(6,:),'filled','MarkerEdgeColor',[0.3 0.3 0.3]);
legend([h3 h4 s1 s2],{'TLS follow-up' 'TLS new', 'follow-up','new'},'Location','southeast');
legend boxoff
ylabel('log(k_{LV}), k_{LV} ~ 1/day');
xlabel('log(k_{SV}), k_{SV} ~ 1/sec');
set (gca,'FontSize', 16);
set(gca,'Xtick',[-8 -4 0]);
set(gca,'Ytick',[-8 -4 0]);
[tau_k1,tau_k_p1] = corr(y1(:,1),x1(:,1));
if tau_k_p1<0.01
starp1='**';
elseif tau_k_p1<0.05
starp1='*';
else
starp1='';
end
[tau_k2,tau_k_p2] = corr(y2(:,1),x2(:,1));
if tau_k_p2<0.01
starp2='**';
elseif tau_k_p2<0.05
starp2='*';
else
starp2='';
end
txt1 = sprintf('Pearson r = %5.2f %s',tau_k1,starp1);
text(-9,3,txt1,'FontSize', 16,'Color',cl1(1,:));
txt2 = sprintf('Pearson r = %5.2f %s',tau_k2,starp2);
text(-9,1,txt2,'FontSize', 16,'Color',cl1(6,:));
ylim([-10,4]);
xlim([-10,4]);
set(gcf,'PaperPosition',[0 0 6 5]);
set(gcf, 'PaperSize', [6 5]);
saveas(gcf, '../../figs/F2a.pdf')
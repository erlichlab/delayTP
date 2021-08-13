function threecorrelationplots(x1,x2,x3,x4,t1,t2,t3,t4)
% x1, x2, x3, x4 are inputs for the 3 subplots
% t1, t2, t3, t4 are their labels
figure;clf;
cl = copper(10);
subplot(1,3,1);
scatter(x2,x1,20,cl(5,:),'filled');
xlabel(t2);
ylabel(t1);
xlim([0,1.5]);
ylim([-10,0]);
lsline;
text(0.1,-9.5,corxyt(x1,x2));
subplot(1,3,2);
scatter(x3,x1,20,cl(5,:),'filled');
xlabel(t3);
%ylabel(t1);
ylim([-10,0]);
xlim([0,2]);
lsline;
text(0.2,-9.5,corxyt(x1,x3));
subplot(1,3,3);
scatter(x4,x1,20,cl(5,:),'filled');
xlabel(t4);
%ylabel(t1);
ylim([-10,0]);
xlim([0,0.7]);
lsline;
text(0.05,-9.5,corxyt(x1,x4));
set(gcf,'PaperPosition',[0 0 4 2]);
set(gcf, 'PaperSize', [4 2]);
end
function txt = corxyt(x,y)
[tau_k,tau_k_p] = corr(x,y,'rows','pairwise');
if tau_k_p<0.01
    starp='**';
elseif tau_k_p<0.05
    starp='*';
else
    starp='';
end
txt = sprintf('r = %5.2f %s',tau_k,starp);
end
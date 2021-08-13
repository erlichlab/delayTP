function correlationplot(x1,y1,xt,yt)
figure;
cl1 = copper(10);
b1  = deming(x1(:,1), y1(:,1));
h3 = plot([0; x1(:,1); 2],b1(1) + b1(2).*[0; x1(:,1); 2],'Color',cl1(6,:));
hold on;
s1 = scatter(x1(:,1),y1(:,1),[],cl1(6,:),'filled','MarkerEdgeColor',[0.3 0.3 0.3]);
ylabel(yt);
xlabel(xt);
set (gca,'FontSize', 16);
set(gca,'Xtick',[0 1 2]);
set(gca,'Ytick',[0 1 2]);
[tau_k1,tau_k_p1] = corr(y1(:,1),x1(:,1));
if tau_k_p1<0.01
starp1='**';
elseif tau_k_p1<0.05
starp1='*';
else
starp1='';
end
txt1 = sprintf('Pearson r = %5.2f %s',tau_k1,starp1);
text(0.1,1.7,txt1,'FontSize', 16,'Color',cl1(6,:));
ylim([0,2]);
xlim([0,2]);
set(gcf,'PaperPosition',[0 0 4 3]);
set(gcf, 'PaperSize', [4 3]);


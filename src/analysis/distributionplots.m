function distributionplots(y1,y2,y3,t1,t2,t3)
figure;clf;
ax = draw.jaxes;
axes(ax);
cl = copper(10);
xrange = [0,2];
% uncomment below for Fig3h
%xrange = [-0.5,1];
% uncomment below for Fig4c
%xrange = [-0.5,1];

[f1,x1] = ksdensity(y1); plot(x1,f1,'Color',cl(6,:),'LineWidth',2); 
if ~isnan(y2) 
    hold on;
    [f2,x2] = ksdensity(y2); plot(x2,f2,'--','Color',cl(6,:),'LineWidth',2);   
    if ~isnan(y3)
    hold on; 
    [f3,x3] = ksdensity(y3); plot(x3,f3,'-.','Color',cl(4,:),'LineWidth',2);
    end
end
if isnan(y3) & ~isnan(y2) 
   legend (sprintf(t1),sprintf(t2),'Location','northeast');
elseif isnan(y2)
   legend (t1,'Location','northwest');
else
    legend (t1,t2,t3,'Location','northwest');
end

legend boxoff                   % Hides the legend's axes
xlabel('ICS','Fontsize',16);
ylabel(sprintf('probability density \nestimate'),'Fontsize',16);
%ylim([0,0.4])
xlim(xrange)
set(gca,'FontSize',16);
outpos = get(gca,'OuterPosition');
set(gca,'OuterPosition',[outpos(1) outpos(2) + 0.005 outpos(3) outpos(4)])
set(gcf,'PaperPosition',[0 0 4 3]);
set(gcf, 'PaperSize', [4 3]);
end
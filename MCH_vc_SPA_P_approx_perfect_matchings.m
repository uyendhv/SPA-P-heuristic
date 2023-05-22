clc
clear vars
clear all
close all
%
folder1 = 'outputsEx1_AP_6';
folder2 = 'outputsEx1_AP_8';
folder3 = 'outputsEx1_AP_10';
%SPA-P-HG algorithm
t1 = [];
for n = 100:100:1000
% for m = 5:5:50
    filename = [folder1,'\HG(',num2str(n),').mat'];
    load(filename,'f_results');
    t1 = [t1,sum(f_results(:,2) == 0)]; 
end
%
t2 = [];
for n  = 100:100:1000
% for m = 5:5:50
    filename = [folder2,'\HG(',num2str(n),').mat'];
    load(filename,'f_results');
    t2 = [t2,sum(f_results(:,2) == 0)]; 
end
t3 = [];
for n  = 100:100:1000
% for m = 5:5:50
    filename = [folder3,'\HG(',num2str(n),').mat'];
    load(filename,'f_results');
    t3 = [t3,sum(f_results(:,2) == 0)]; 
end
%
HG_time = [t1;t2;t3];
%==========================================================================
t1 = [];
for n = 100:100:1000
% for m = 5:5:50
    filename = [folder1,'\AP(',num2str(n),').mat'];
    load(filename,'f_results');
    t1 = [t1,sum(f_results(:,2) == 0)]; 
end
%
t2 = [];
for n = 100:100:1000
% for m = 5:5:50
    filename = [folder2,'\AP(',num2str(n),').mat'];
    load(filename,'f_results');
    t2 = [t2,sum(f_results(:,2) == 0)]; 
end
t3 = [];
for n = 100:100:1000
%    for m = 5:5:50
    filename = [folder3,'\AP(',num2str(n),').mat'];
    load(filename,'f_results');
    t3 = [t3,sum(f_results(:,2) == 0)]; 
end
%
MCH_time = [t1;t2;t3];
%==========================================================================
%create a figure (left,top,width,height) 
figure('position',[50, 10, 1000, 500]); 
set(axes, 'Units', 'pixels', 'Position', [100 119.666666666667 827.666666666667 396.666666666667]);
hold on
%
%SPA-P-MCH: lines 1,3,5; SPA-P-approx: lines 2,4,6
%SPA-P-MCH: lines 1,3,5; SPA-P-approx: lines 2,4,6
h(1) = plot(HG_time(1,:),'--bo','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(2) = plot(MCH_time(1,:),'--ro','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);
%h(3) = plot(PROMOTION_time(1,:),'--g^','MarkerEdgeColor','k','MarkerSize',8,'LineWidth',1.5);


h(3) = plot(HG_time(2,:),'--b^','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(4) = plot(MCH_time(2,:),'--r^','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);
%h(6) = plot(PROMOTION_time(2,:),'--g^','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8,'LineWidth',1.5);
h(5) = plot(HG_time(3,:),'--b>','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(6) = plot(MCH_time(3,:),'--r>','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);

%=========================================================================
legendInfo = {'SPA-P-HG, {\it |A_i|} = 6','SPA-P-MCH, {\it |A_i|} = 6',...
              'SPA-P-HG, {\it |A_i|} = 8','SPA-P-MCH, {\it |A_i|} = 8',...
              'SPA-P-HG, {\it |A_i|} = 10','SPA-P-MCH, {\it |A_i|} = 10'};


hand = legend(h,legendInfo,'NumColumns',3); 
%=========================================================================
%for layout of figure
set(hand,'FontSize',17,'Position',[0.70, 0.64, 0.27, 0.15]);  
legend('boxoff')
set(gcf,'color','w');
xlim([1 10]);
xticks(1:10);
xticklabels(5:5:50);
ylim([0,100]);
yticks(0:10:100);
set(gca,'Xcolor','k');
set(gca,'Ycolor','k');
%
hx = xlabel('Number of lecturers','color','k');
set(hx, 'FontSize', 17)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',17)
%
hy = ylabel('Percentage of perfect matchings','color','k');
set(hy,'FontSize',17)
%
grid on
ax = gca;
set(ax,'GridLineStyle','--') 
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.4;
box on
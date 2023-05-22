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
    filename = [folder1,'\HG(',num2str(n),').mat'];
    load(filename,'f_results');
    t1 = [t1,mean(f_results(:,1))]; 
end
%
t2 = [];
for n  = 100:100:1000
    filename = [folder2,'\HG(',num2str(n),').mat'];
    load(filename,'f_results');
    t2 = [t2,mean(f_results(:,1))]; 
end
t3 = [];
for n  = 100:100:1000
    filename = [folder3,'\HG(',num2str(n),').mat'];
    load(filename,'f_results');
    t3 = [t3,mean(f_results(:,1))]; 
end
%
HG_time = [log10(t1);log10(t2);log10(t3)];
%==========================================================================
t1 = [];
for n = 100:100:1000
    filename = [folder1,'\AP(',num2str(n),').mat'];
    load(filename,'f_results');
    t1 = [t1,mean(f_results(:,1))]; 
end
%
t2 = [];
for n = 100:100:1000
% for m = 5:5:50
    filename = [folder2,'\AP(',num2str(n),').mat'];
    load(filename,'f_results');
    t2 = [t2,mean(f_results(:,1))]; 
end
t3 = [];
for n = 100:100:1000
    filename = [folder3,'\AP(',num2str(n),').mat'];
    load(filename,'f_results');
    t3 = [t3,mean(f_results(:,1))]; 
end
%
AP_time = [log10(t1);log10(t2);log10(t3)];
%==========================================================================
figure('position',[50, 10, 1000, 500]); 
set(axes, 'Units', 'pixels', 'Position', [100 119.666666666667 827.666666666667 396.666666666667]);
hold on
%
h(1) = plot(HG_time(1,:),'--bo','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(2) = plot(AP_time(1,:),'--mo','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);

h(3) = plot(HG_time(2,:),'--b^','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(4) = plot(AP_time(2,:),'--m^','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);
%
h(5) = plot(HG_time(3,:),'--b>','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(6) = plot(AP_time(3,:),'--m>','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);

%=========================================================================
legendInfo = {'SPA-P-HG, {\it |A_i|} = 6','SPA-P-AP, {\it |A_i|} = 6',...
              'SPA-P-HG, {\it |A_i|} = 8','SPA-P-AP, {\it |A_i|} = 8',...
              'SPA-P-HG, {\it |A_i|} = 10','SPA-P-AP, {\it |A_i|} = 10'};


hand = legend(h,legendInfo,'NumColumns',3); 
%=========================================================================
%for layout of figure
set(hand,'FontSize',17,'Position',[0.70, 0.64, 0.27, 0.15]);  
legend('boxoff')
set(gcf,'color','w');
xlim([1 10]);
xticks(1:10);
xticklabels(100:100:1000);
% ylim([100,1000]);
% yticks(100:100:1000);
set(gca,'Xcolor','k');
set(gca,'Ycolor','k');
%
hx = xlabel('Number of students','color','k');
set(hx, 'FontSize', 17)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',17)%
hy = ylabel('Average execution time (log_{10}sec.)','color','k');
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
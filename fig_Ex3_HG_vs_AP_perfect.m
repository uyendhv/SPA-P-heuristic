clc
clear vars
clear all
close all
%
folder1 = 'outputsEx3_AP_10';
folder2 = 'outputsEx3_AP_15';
folder3 = 'outputsEx3_AP_20';
%SPA-P-HG algorithm
t1 = [];
for n = 1000:1000:10000
m = 0.05*n;
    filename = [folder1,'\HG(',num2str(n),',', num2str(m),').mat'];
    load(filename,'f_results');
    t1 = [t1,sum(f_results(:,2) == 0)]; 
end
%
t2 = [];
for n  = 1000:1000:10000
m = 0.05*n;
    filename = [folder2,'\HG(',num2str(n),',', num2str(m),').mat'];
    load(filename,'f_results');
    t2 = [t2,sum(f_results(:,2) == 0)]; 
end
t3 = [];
for n  = 1000:1000:10000
 m = 0.05*n;
% for m = 5:5:50
    filename = [folder3,'\HG(',num2str(n),',', num2str(m),').mat'];
    load(filename,'f_results');
    t3 = [t3,sum(f_results(:,2) == 0)]; 
end
%
HG_perfect = [t1;t2;t3];
%==========================================================================
t1 = [];
for n = 1000:1000:10000
m = 0.05*n;
    filename = [folder1,'\AP(',num2str(n),',', num2str(m),').mat'];
    load(filename,'f_results');
    t1 = [t1,sum(f_results(:,2) == 0)]; 
end
%
t2 = [];
for n = 1000:1000:10000
m = 0.05*n;
% for m = 5:5:50
    filename = [folder2,'\AP(',num2str(n),',', num2str(m),').mat'];
    load(filename,'f_results');
    t2 = [t2,sum(f_results(:,2) == 0)]; 
end
t3 = [];
for n = 1000:1000:10000
 m = 0.05*n;
    filename = [folder3,'\AP(',num2str(n),',', num2str(m),').mat'];
    load(filename,'f_results');
    t3 = [t3,sum(f_results(:,2) == 0)]; 
end
%
AP_perfect = [t1;t2;t3];
%==========================================================================
%create a figure (left,top,width,height) 
figure('position',[50, 10, 1000, 500]); 
set(axes, 'Units', 'pixels', 'Position', [100 119.666666666667 827.666666666667 396.666666666667]);
hold on
%
h(1) = plot(HG_perfect(1,:),'--bo','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(2) = plot(AP_perfect(1,:),'--mo','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);

h(3) = plot(HG_perfect(2,:),'--b^','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(4) = plot(AP_perfect(2,:),'--m^','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);
%
h(5) = plot(HG_perfect(3,:),'--b>','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(6) = plot(AP_perfect(3,:),'--m>','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);

%=========================================================================
legendInfo = {'SPA-P-HG, {\it |A_i|} = 10','SPA-P-AP, {\it |A_i|} = 10',...
              'SPA-P-HG, {\it |A_i|} = 15','SPA-P-AP, {\it |A_i|} = 15',...
              'SPA-P-HG, {\it |A_i|} = 20','SPA-P-AP, {\it |A_i|} = 20'};


hand = legend(h,legendInfo,'NumColumns',3); 
%=========================================================================
%for layout of figure
set(hand,'FontSize',17,'Position',[0.70, 0.64, 0.27, 0.15]);  
legend('boxoff')
set(gcf,'color','w');
xlim([1 10]);
xticks(1:10);
xticklabels(1000:1000:10000);
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
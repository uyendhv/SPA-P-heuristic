clc
clear vars
clear all
close all
%
folder1 = 'outputsEx1_AP_100';
folder2 = 'outputsEx1_AP_200';
%SPA-P-HG algorithm
n = 100;
t1 = [];
for A = 3:1:10
    filename = ['outputsEx2_AP_100\HG(',num2str(n),',',num2str(A),').mat'];
    load(filename,'f_results');
    t1 = [t1,sum(f_results(:,2) == 0)]; 
end
%
n = 200;
t2 = [];
for A = 3:1:10
    filename = ['outputsEx2_AP_200\HG(',num2str(n),',',num2str(A),').mat'];
    load(filename,'f_results');
    t2 = [t2,sum(f_results(:,2) == 0)]; 
end
 HG_perfect = [t1;t2];
% %==========================================================================
n= 100;
t1 = [];
for A = 3:1:10
    filename = ['outputsEx2_AP_100\AP(',num2str(n),',',num2str(A),').mat'];
    load(filename,'f_results');
    t1 = [t1,sum(f_results(:,2) == 0)]; 
end
%
n = 200;
t2 = [];
for A = 3:1:10
    filename = ['outputsEx2_AP_200\AP(',num2str(n),',',num2str(A),').mat'];
    load(filename,'f_results');
    t2 = [t2,sum(f_results(:,2) == 0)]; 
end
AP_perfect = [t1;t2];
%==========================================================================
%create a figure (left,top,width,height) 
figure('position',[50, 10, 1000, 500]); 
set(axes, 'Units', 'pixels', 'Position', [100 119.666666666667 827.666666666667 396.666666666667]);
hold on
%
h(1) = plot(HG_perfect(1,:),'--b^','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(2) = plot(AP_perfect(1,:),'--m^','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);

h(3) = plot(HG_perfect(2,:),'--bs','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(4) = plot(AP_perfect(2,:),'--ms','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);
%=========================================================================
legendInfo = {'SPA-P-HG, {\it n} = 100','SPA-P-AP, {\it n} = 100',...
              'SPA-P-HG, {\it n} = 200','SPA-P-AP, {\it n} = 200'};


hand = legend(h,legendInfo,'NumColumns',2); 
%=========================================================================
%for layout of figure
set(hand,'FontSize',17,'Position',[0.70, 0.64, 0.27, 0.15]);  
legend('boxoff')
set(gcf,'color','w');
% xlim([1 8]);
% xticks(1:8);
xticklabels(3:1:10);
ylim([0,100]);
yticks(0:10:100);
set(gca,'Xcolor','k');
set(gca,'Ycolor','k');
%
hx = xlabel('|A_{i}|','color','k');
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
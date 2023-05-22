clc
clear vars
clear all
close all
%
folder1 = 'outputsEx2_AP_100';
folder2 = 'outputsEx2_AP_200';
%SPA-P-HG algorithm
n = 100;
t1 = [];
for A = 3:1:10
% for m = 5:5:50
    filename = ['outputsEx2_AP_100\HG(',num2str(n),',',num2str(A),').mat'];
    load(filename,'f_results');
    t1 = [t1,mean(f_results(:,1))]; 
end
%
n = 200;
t2 = [];
for A = 3:1:10
% for m = 5:5:50
    filename = ['outputsEx2_AP_200\HG(',num2str(n),',',num2str(A),').mat'];
    load(filename,'f_results');
    t2 = [t2,mean(f_results(:,1))]; 
end
%
HG_time = [log10(t1);log10(t2)];
%==========================================================================
n = 100;
t1 = [];
for A = 3:1:10
% for m = 5:5:50
    filename = ['outputsEx2_AP_100\AP(',num2str(n),',',num2str(A),').mat'];
    load(filename,'f_results');
    t1 = [t1,mean(f_results(:,1))]; 
end
%
n = 200;
t2 = [];
for A = 3:1:10
% for m = 5:5:50
    filename = ['outputsEx2_AP_200\AP(',num2str(n),',',num2str(A),').mat'];
    load(filename,'f_results');
    t2 = [t2,mean(f_results(:,1))]; 
end
AP_time = [log10(t1);log10(t2)];
%==========================================================================
%
%create a figure (left,top,width,height) 
figure('position',[50, 10, 1000, 500]); 
set(axes, 'Units', 'pixels', 'Position', [100, 100, 540, 370]);
hold on
%
%SPA-P-MCH: lines 1,3,5; SPA-P-approx: lines 2,4,6
figure('position',[50, 10, 1000, 500]); 
set(axes, 'Units', 'pixels', 'Position', [100 119.666666666667 827.666666666667 396.666666666667]);
hold on
%
h(1) = plot(HG_time(1,:),'--b^','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(2) = plot(AP_time(1,:),'--m^','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);
%h(3) = plot(PROMOTION_time(1,:),'--g^','MarkerEdgeColor','k','MarkerSize',8,'LineWidth',1.5);


h(3) = plot(HG_time(2,:),'--bs','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',9,'LineWidth',1.7);
h(4) = plot(AP_time(2,:),'--ms','MarkerEdgeColor','k','MarkerSize',9,'LineWidth',1.7);
%=========================================================================
legendInfo = {'SPA-P-HG, {\it n} = 100','SPA-P-AP, {\it n} = 100',...
              'SPA-P-HG, {\it n} = 200','SPA-P-AP, {\it n} = 200'};


hand = legend(h,legendInfo,'NumColumns',2); 
%=========================================================================
%for layout of figure
set(hand,'FontSize',17,'Position',[0.70, 0.64, 0.27, 0.15]);  
legend('boxoff')
set(gcf,'color','w');
xticklabels(3:1:10);
% ylim([0,100]);
% yticks(0:10:100);
% ylim([0,18]);
% yticks(0:2:18);
set(gca,'Xcolor','k');
set(gca,'Ycolor','k');
%
hx = xlabel('|A_{i}|','color','k');
set(hx, 'FontSize', 17)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',17)
%
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
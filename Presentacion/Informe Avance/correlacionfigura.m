%Figure correlación
clear all
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 10\CorrV.mat')
figure; plot(corrv3(:,1),corrv3(:,2),'-', 'Color', [255, 102, 0]/255,'LineWidth', 2);hold on
plot(corrv3(:,1),corrv3(:,3),'-','Color',[0, 114, 187]/187,'LineWidth', 2);hold on
plot(corrv3(:,1),corrv3(:,4),'-', 'Color', [0, 100, 0]/150,'LineWidth', 2)
line([0.15, 0.15],[-1 1],'Color','red','LineStyle','-','LineWidth',1.5)
grid on
xlabel({'t [s]'},'FontSize', 16)
ylabel({'Correlación'},'FontSize', 16)
legend('VX','VY', 'VZ')
set(gca,'fontsize',16)

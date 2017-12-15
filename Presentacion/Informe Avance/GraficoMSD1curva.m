%Grafico MSD 1 curva
figure
clear all
cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 10\')
load('MSDxy')
loglog(t(1:290), msd(1:290,1),'--','LineWidth',2,'Color',[0, 114, 187]/187)
hold on
clear all
load('MSDz')
loglog(t(1:290), msd(1:290,1),'-','LineWidth',2, 'Color',[0, 114, 187]/187)
legend('xy','z')
grid on
line([0.15, 0.15],[1E-2 1E4],'Color','red','LineStyle','-','LineWidth',1.5)
line([0.31, 0.31],[1E-2 1E4],'Color',[141, 53, 229]/300,'LineStyle','-','LineWidth',1.5)
xlabel({'t [s]'},'FontSize', 16)
ylabel({'Distancia Cuadrática Media [mm^2]  '},'FontSize', 16)
set(gca,'fontsize',16)

clear all
figure
cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShutting 120 Hz Amplitud 20\')
load('MSDxy')
loglog(t(1:290), msd(1:290,1),'--','LineWidth',2, 'Color',[0, 100, 0]/150)
hold on
clear all
load('MSDz')
loglog(t(1:290), msd(1:290,1),'-','LineWidth',2, 'Color',[0, 100, 0]/150)
cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 15\')
load('MSDxy')
loglog(t(1:290), msd(1:290,1),'--','LineWidth',2, 'Color',[255, 102, 0]/255)
clear all
load('MSDz')
loglog(t(1:290), msd(1:290,1),'-','LineWidth',2, 'Color',[255, 102, 0]/255)
cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 10\')
load('MSDxy')
loglog(t(1:290), msd(1:290,1),'--','LineWidth',2,'Color',[0, 114, 187]/187)
clear all
load('MSDz')
loglog(t(1:290), msd(1:290,1),'-','LineWidth',2, 'Color',[0, 114, 187]/187)
cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\')
load('MSDxy')
loglog(t(1:290), msd(1:290,1),'--','LineWidth',2, 'Color',[141, 53, 229]/229)
clear all
load('MSDz')
loglog(t(1:290), msd(1:290,1),'-','LineWidth',2, 'Color', [141, 53, 229]/229)
cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\23-11-17\Mediciones\Mediciones\Variamos espectro amplitud 10\SingleShutting 2-6\')
load('MSDxy')
loglog(txy1(1:290), msdxy1(1:290,1),'--','LineWidth',2, 'Color',[146, 2, 50]/200)
clear all
load('MSDz')
loglog(tz1(1:290), msdz1(1:290,1),'-','LineWidth',2, 'Color', [146, 2, 50]/200)

legend('xy A=20 mm','z A=20 mm' ,'xy A=15 mm','z A=15 mm','xy A=10 mm','z A=10 mm','xy A=5 mm', 'z A=5 mm')
grid on
xlabel({'t [s]'},'FontSize', 16)
ylabel({'Distancia Cuadrática Media [mm^2]  '},'FontSize', 16)
set(gca,'fontsize',16)

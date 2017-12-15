estadisticav.m    =[];
estadisticav.std  =[];
estadisticav.skew =[];
estadisticav.kurt =[];
estadisticaa.m    =[];
estadisticaa.std  =[];
estadisticaa.skew =[];
estadisticaa.kurt =[];

cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShutting 120 Hz Amplitud 20\')
load('VyA')
r1=sqrt(sum(v1.^2,2))/120;
media1=mean(r1);
estadisticav.m=[estadisticav.m; mean(v1)];
estadisticav.std=[estadisticav.std; std(v1)];
estadisticav.skew=[estadisticav.skew; skewness(v1)];
estadisticav.kurt=[estadisticav.kurt; kurtosis(v1)];

estadisticaa.m    = [estadisticaa.m; mean(a1)];
estadisticaa.std  = [estadisticaa.std; std(a1)];
estadisticaa.skew = [estadisticaa.skew; skewness(a1)];
estadisticaa.kurt = [estadisticaa.kurt; kurtosis(a1)];


cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 15\')
load('VyA')
r2=sqrt(sum(v2.^2,2))/120;
media2=mean(r2);
estadisticav.m=[estadisticav.m; mean(v2)];
estadisticav.std=[estadisticav.std; std(v2)];
estadisticav.skew=[estadisticav.skew; skewness(v2)];
estadisticav.kurt=[estadisticav.kurt; kurtosis(v2)];

estadisticaa.m    = [estadisticaa.m; mean(a2)];
estadisticaa.std  = [estadisticaa.std; std(a2)];
estadisticaa.skew = [estadisticaa.skew; skewness(a2)];
estadisticaa.kurt = [estadisticaa.kurt; kurtosis(a2)];


cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 10\')
load('VyA')
r3=sqrt(sum(v3.^2,2))/120;
media3=mean(r3);
estadisticav.m=[estadisticav.m; mean(v3)];
estadisticav.std=[estadisticav.std; std(v3)];
estadisticav.skew=[estadisticav.skew; skewness(v3)];
estadisticav.kurt=[estadisticav.kurt; kurtosis(v3)];

estadisticaa.m    = [estadisticaa.m; mean(a3)];
estadisticaa.std  = [estadisticaa.std; std(a3)];
estadisticaa.skew = [estadisticaa.skew; skewness(a3)];
estadisticaa.kurt = [estadisticaa.kurt; kurtosis(a3)];


cd('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\')
load('VyA')
r4=sqrt(sum(v4.^2,2))/120;
media4=mean(r4);
estadisticav.m=[estadisticav.m; mean(v4)];
estadisticav.std=[estadisticav.std; std(v4)];
estadisticav.skew=[estadisticav.skew; skewness(v4)];
estadisticav.kurt=[estadisticav.kurt; kurtosis(v4)];

estadisticaa.m    = [estadisticaa.m; mean(a4)];
estadisticaa.std  = [estadisticaa.std; std(a4)];
estadisticaa.skew = [estadisticaa.skew; skewness(a4)];
estadisticaa.kurt = [estadisticaa.kurt; kurtosis(a4)];

amplitudes=[20, 15, 10, 5];
Colores1 = [[255, 102, 0]'/400, [0, 114, 187]'/300, [0, 100, 0]'/200];
Colores2 = [[255, 102, 0]'/255, [0, 114, 187]'/187, [0, 100, 0]'/150];

figure(1);
clf
set(figure(1),'defaultAxesColorOrder',[[0 0 0]; [0 0 0]]);

yyaxis left
for ii=1:3
    plot(amplitudes, estadisticav.skew(:,ii),'d-','Color',Colores1(:,ii),'MarkerEdgeColor',Colores1(:,ii), ...
        'MarkerFaceColor',Colores2(:,ii),...
        'MarkerSize',10)
    hold on
end
xlabel({'Amplitud de Forzado[mm]'},'FontSize', 16)
ylabel({'Skewness'},'FontSize', 16)
set(gca,'fontsize',16)

yyaxis right
for ii=1:3
    plot(amplitudes, estadisticav.kurt(:,ii),'o-','Color',Colores1(:,ii),'MarkerEdgeColor',Colores1(:,ii), ...
        'MarkerFaceColor',Colores2(:,ii),...
        'MarkerSize',10)
    hold on
end
xlabel({'Amplitud de Forzado [mm]'},'FontSize', 16)
ylabel({'Kurtosis'},'FontSize', 16)
legend('S(VX)','S(VY)', 'S(VZ)','K(VX)','K(VY)', 'K(VZ)')
set(gca,'fontsize',16)

figure(2);
clf
set(figure(2),'defaultAxesColorOrder',[[0 0 0]; [0 0 0]]);

yyaxis left

for ii=1:3
    plot(amplitudes, estadisticaa.skew(:,ii),'d-','Color',Colores1(:,ii),'MarkerEdgeColor',Colores1(:,ii), ...
        'MarkerFaceColor',Colores2(:,ii),...
        'MarkerSize',10)
    hold on
end
xlabel({'Amplitud de Forzado[mm]'},'FontSize', 16)
ylabel({'Skewness'},'FontSize', 16)
set(gca,'fontsize',16)

yyaxis right
for ii=1:3
    plot(amplitudes, estadisticaa.kurt(:,ii),'o-','Color',Colores1(:,ii),'MarkerEdgeColor',Colores1(:,ii), ...
        'MarkerFaceColor',Colores2(:,ii),...
        'MarkerSize',10)
end
legend('S(AX)','S(AY)', 'S(AZ)','K(AX)','K(AY)', 'K(AZ)')
xlabel({'Amplitud de Forzado [mm]'},'FontSize', 16)
ylabel({'Kurtosis'},'FontSize', 16)
set(gca,'fontsize',16)



%%%Intercambio de energia dE/dt
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 10\CurvaUnida2.mat')
[curvas4]=analisis(curva2, 0);
dEdt=[];
for kk=1:length(curvas4); 
    dEdt=[dEdt;curvas4{kk}.dEdt];
end
cd ..
cd ..
cd('Presentacion\Informe Avance')

PDFdEdt(dEdt)

skewness(dEdt)
[m, id]=max(largo3);
figure; plot(curvas4{id}.ta, curvas4{id}.dEdt,'o-','Color',[0, 114, 187]/187)
xlabel({'t [s]'},'FontSize', 16)
ylabel({'dE/dT [\mu W]'},'FontSize', 16)
grid on
set(gca,'fontsize',16)


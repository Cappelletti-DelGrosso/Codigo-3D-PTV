% close all
clear all

load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShutting 120 Hz Amplitud 20\CurvaUnida2.mat')
largo3= cellfun(@(x) size(x,1), curva2);
max(largo3)
mean(largo3)
figure; [PDFV, V]=hist(largo3, sqrt(length(largo3))*2);
% DV    = diff(V);
% sv    = sum(DV.*PDFV(1:(end-1)));
% PDFV = PDFV/sv;
plot(V, PDFV, 'bo')
hold on
a=1060;
b=-0.02518;
x=0:max(V);
plot(x, a*exp(b*x), 'k-','LineWidth',2)
grid on
ylabel('Cuentas')
xlabel('Largo [puntos]')
legend('Medicion','Exponencial')
set(gca,'fontsize',16)
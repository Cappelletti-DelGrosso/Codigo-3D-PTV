%grafico rayleigh
clear all
figure

load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShutting 120 Hz Amplitud 20\VyA.mat')
r1=sqrt(sum(v1.^2,2))/120;
PDFRnofit(r1,'o',[0, 100, 0]/200,[0, 100, 0]/150)
hold on
clear r1
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 15\VyA.mat')
r2=sqrt(sum(v2.^2,2))/120;
PDFRnofit(r2,'o',[255, 102, 0]/400,[255, 102, 0]/255)

load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 10\VyA.mat')
r3=sqrt(sum(v3.^2,2))/120;
PDFRnofit(r3,'o',[0, 114, 187]/300,[0, 114, 187]/187)

load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\VyA.mat')
r4=sqrt(sum(v4.^2,2))/120;
PDFRnofit(r4,'o',[141, 53, 229]/300,[141, 53, 229]/229)


clear all
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShutting 120 Hz Amplitud 20\CurvaUnida2.mat')
[curvas1]=analisis(curva2, 0)
v1=[];
a1=[];
largos = cellfun(@(x) size(x.corrv,1), curvas1);
corrvx=zeros(length(curvas1),max(largos));
corrvy=zeros(length(curvas1),max(largos));
corrvz=zeros(length(curvas1),max(largos));

largos2 = cellfun(@(x) size(x.corra,1), curvas1);
corrax=zeros(length(curvas1),max(largos2));
corray=zeros(length(curvas1),max(largos2));
corraz=zeros(length(curvas1),max(largos2));


% figure;
for kk=1:length(curvas1)
    v1  = [v1; curvas1{kk}.v] ;
    a1  = [a1; curvas1{kk}.a] ;
    t   = curvas1{kk}.t;
%     t=t-t(1);
    corr = curvas1{kk}.corrv;
    corrvx(kk,1:size(corr,1))=corr(:,1);
    corrvy(kk,1:size(corr,1))=corr(:,2);
    corrvz(kk,1:size(corr,1))=corr(:,3);
    corra = curvas1{kk}.corra;
    corrax(kk,1:size(corra,1))=corra(:,1);
    corray(kk,1:size(corra,1))=corra(:,2);
    corraz(kk,1:size(corra,1))=corra(:,3);
%     plot(t(1:length(corr)),corr);hold on
end
for ii=1:size(corrvx,2)
    cantidad(ii) =  sum(largos>=ii);
end
for ii=1:size(corrax,2)
    cantidad2(ii) =  sum(largos2>=ii);
end
corrvx=sum(corrvx)./cantidad;
corrvy=sum(corrvy)./cantidad;
corrvz=sum(corrvz)./cantidad;
t=[0:length(corrvx)-1]/120;
figure; plot(t,corrvx,'-', 'Color', [255, 102, 0]/255,'LineWidth', 2);hold on
plot(t,corrvy,'-','Color',[0, 114, 187]/187,'LineWidth', 2);hold on
plot(t,corrvz,'-', 'Color', [0, 100, 0]/150,'LineWidth', 2)
grid on
xlabel({'t [s]'},'FontSize', 16)
ylabel({'Correlación'},'FontSize', 16)
legend('VX','VY', 'VZ')
set(gca,'fontsize',16)
corrv1=[t',corrvx', corrvy', corrvz'];

corrax=sum(corrax)./cantidad;
corray=sum(corray)./cantidad;
corraz=sum(corraz)./cantidad;
t=[0:length(corrax)-1]/120;
figure; plot(t,corrax,'-', 'Color', [255, 102, 0]/255,'LineWidth', 2);hold on
plot(t,corray,'-','Color',[0, 114, 187]/187,'LineWidth', 2);hold on
plot(t,corraz,'-', 'Color', [0, 100, 0]/150,'LineWidth', 2)
grid on
xlabel({'t [s]'},'FontSize', 16)
ylabel({'Correlación'},'FontSize', 16)
legend('AX','AY', 'AZ')
set(gca,'fontsize',16)
corra1=[t',corrvx', corrvy', corrvz'];


r1=sqrt(sum(v1.^2,2))/120;
v1=(v1-mean(v1))./std(v1);
energia=v1.^2;
[ex, fex]  = pwelch(energia(:,1),[],[],[],120,'onesided') ; 
[ey, fey]  = pwelch(energia(:,2),[],[],[],120,'onesided') ; 
[ez, fez]  = pwelch(energia(:,3),[],[],[],120,'onesided') ; 
figure; loglog(fex, ex)
hold on; loglog(fey, ey)
loglog(fez, ez)
cd ..
cd ..
cd('Presentacion\Informe Avance')
PDFVnorm(v1, 'Amplitud  20')
PDFAnorm(a1, 'Amplitud  20')
PDFRnorm(r1,'Rayleigh Amplitud 20')

%%%%%%%%%%%%%%%
clear all
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 15\CurvaUnida2.mat')
[curvas2]=analisis(curva2, 0)
v2=[];
a2=[];
largos = cellfun(@(x) size(x.corrv,1), curvas2);
corrvx=zeros(length(curvas2),max(largos));
corrvy=zeros(length(curvas2),max(largos));
corrvz=zeros(length(curvas2),max(largos));

for kk=1:length(curvas2)
    v2  = [v2; curvas2{kk}.v] ;
    a2  = [a2; curvas2{kk}.a] ;
      corr = curvas2{kk}.corrv;
    corrvx(kk,1:size(corr,1))=corr(:,1);
    corrvy(kk,1:size(corr,1))=corr(:,2);
    corrvz(kk,1:size(corr,1))=corr(:,3);
end
for ii=1:size(corrvx,2)
    cantidad(ii) =  sum(largos>=ii);
end
corrvx=sum(corrvx)./cantidad;
corrvy=sum(corrvy)./cantidad;
corrvz=sum(corrvz)./cantidad;
t=[0:length(corrvx)-1]/120;
figure; plot(t,corrvx,'-', 'Color', [255, 102, 0]/255,'LineWidth', 2);hold on
plot(t,corrvy,'-','Color',[0, 114, 187]/187,'LineWidth', 2);hold on
plot(t,corrvz,'-', 'Color', [0, 100, 0]/150,'LineWidth', 2)
grid on
xlabel({'t [s]'},'FontSize', 16)
ylabel({'Correlación'},'FontSize', 16)
legend('VX','VY', 'VZ')
set(gca,'fontsize',16)
corrv2=[t',corrvx', corrvy', corrvz'];

r2=sqrt(sum(v2.^2,2))/120;
cd ..
cd ..
cd('Presentacion\Informe Avance')
PDFVnorm(v2, 'Amplitud  15')
PDFAnorm(a2, 'Amplitud  15')
PDFRnorm(r2,'Rayleigh Amplitud 15')
v2=(v2-mean(v2))./std(v2);
energia2=v2.^2;
[ex2, fex2]  = pwelch(energia2(:,1),[],[],[],120,'onesided') ; 
[ey2, fey2]  = pwelch(energia2(:,2),[],[],[],120,'onesided') ; 
[ez2, fez2]  = pwelch(energia2(:,3),[],[],[],120,'onesided') ; 
figure; loglog(fex2, ex2)
hold on; loglog(fey2, ey2)
loglog(fez2, ez2)

%%%%%%%%%%%%%%%%%
clear all
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 10\CurvaUnida2.mat')
[curvas3]=analisis(curva2, 0)
v3=[];
a3=[];
largos = cellfun(@(x) size(x.corrv,1), curvas3);
corrvx=zeros(length(curvas3),max(largos));
corrvy=zeros(length(curvas3),max(largos));
corrvz=zeros(length(curvas3),max(largos));

for kk=1:length(curvas3)
    v3  = [v3; curvas3{kk}.v] ;
    a3  = [a3; curvas3{kk}.a] ;
    corr = curvas3{kk}.corrv;
    corrvx(kk,1:size(corr,1))=corr(:,1);
    corrvy(kk,1:size(corr,1))=corr(:,2);
    corrvz(kk,1:size(corr,1))=corr(:,3);
end
for ii=1:size(corrvx,2)
    cantidad(ii) =  sum(largos>=ii);
end
corrvx=sum(corrvx)./cantidad;
corrvy=sum(corrvy)./cantidad;
corrvz=sum(corrvz)./cantidad;
t=[0:length(corrvx)-1]/120;
figure; plot(t,corrvx,'-', 'Color', [255, 102, 0]/255,'LineWidth', 2);hold on
plot(t,corrvy,'-','Color',[0, 114, 187]/187,'LineWidth', 2);hold on
plot(t,corrvz,'-', 'Color', [0, 100, 0]/150,'LineWidth', 2)
grid on
xlabel({'t [s]'},'FontSize', 16)
ylabel({'Correlación'},'FontSize', 16)
legend('VX','VY', 'VZ')
set(gca,'fontsize',16)
corrv3=[t',corrvx', corrvy', corrvz'];

r3=sqrt(sum(v3.^2,2))/120;
cd ..
cd ..
cd('Presentacion\Informe Avance')
PDFVnorm(v3, 'Amplitud  10')
PDFAnorm(a3, 'Amplitud  10')
PDFRnorm(r3,'Rayleigh Amplitud 10')
v3=(v3-mean(v3))./std(v3);
energia3=v3.^2;
[ex3, fex3]  = pwelch(energia3(:,1),[],[],[],120,'onesided') ; 
[ey3, fey3]  = pwelch(energia3(:,2),[],[],[],120,'onesided') ; 
[ez3, fez3]  = pwelch(energia3(:,3),[],[],[],120,'onesided') ; 
figure; loglog(fex3, ex3)
hold on; loglog(fey3, ey3)
loglog(fez3, ez3)


clear all
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\CurvaUnida2.mat')
[curvas4]=analisis(curva2, 0)
v4=[];
a4=[];
largos = cellfun(@(x) size(x.corrv,1), curvas4);
corrvx=zeros(length(curvas4),max(largos));
corrvy=zeros(length(curvas4),max(largos));
corrvz=zeros(length(curvas4),max(largos));

for kk=1:length(curvas4)
    v4  = [v4; curvas4{kk}.v] ;
    a4  = [a4; curvas4{kk}.a] ;
    corr = curvas4{kk}.corrv;
    corrvx(kk,1:size(corr,1))=corr(:,1);
    corrvy(kk,1:size(corr,1))=corr(:,2);
    corrvz(kk,1:size(corr,1))=corr(:,3);
end
for ii=1:size(corrvx,2)
    cantidad(ii) =  sum(largos>=ii);
end
corrvx=sum(corrvx)./cantidad;
corrvy=sum(corrvy)./cantidad;
corrvz=sum(corrvz)./cantidad;
t=[0:length(corrvx)-1]/120;
figure; plot(t,corrvx,'-', 'Color', [255, 102, 0]/255,'LineWidth', 2);hold on
plot(t,corrvy,'-','Color',[0, 114, 187]/187,'LineWidth', 2);hold on
plot(t,corrvz,'-', 'Color', [0, 100, 0]/150,'LineWidth', 2)
grid on
xlabel({'t [s]'},'FontSize', 16)
ylabel({'Correlación'},'FontSize', 16)
legend('VX','VY', 'VZ')
set(gca,'fontsize',16)
corrv4=[t',corrvx', corrvy', corrvz'];


cd ..
cd ..
cd('Presentacion\Informe Avance')
PDFVnorm(v4, 'Amplitud  5')
PDFAnorm(a4, 'Amplitud  5')
r4=sqrt(sum(v4.^2,2))/120;
PDFRnorm(r4,'Rayleigh Amplitud 5')
v4=(v4-mean(v4))./std(v4);
energia4=v4.^2;
[ex4, fex4]  = pwelch(energia4(:,1),[],[],[],120,'onesided') ; 
[ey4, fey4]  = pwelch(energia4(:,2),[],[],[],120,'onesided') ; 
[ez4, fez4]  = pwelch(energia4(:,3),[],[],[],120,'onesided') ; 
figure; loglog(fex4, ex4)
hold on; loglog(fey4, ey4)
loglog(fez4, ez4)

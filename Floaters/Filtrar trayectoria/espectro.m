clear all
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 15\CurvaUnida2')
[curvas2]=analisis(curva2, 0)
v2=[];
z2=[];
Fs=120;
fint = Fs*(0:(round(400/2)))/400;
Eint=zeros(length(fint),3);
for kk = 1:length(curvas2)
    clear v
    v = curvas2{kk}.v ;
    z = curvas2{kk}.xyz(:,3);
    v2=[v2; v];
    z2=[z2; z];
    L=length(v);
    v = (v-mean(v))./std(v) ;
    energia= v;    
    [ex(:,kk), fex(:,kk)]  = pwelch(v(:,1),[],[],[],120,'onesided') ; 
    [ey(:,kk), fey(:,kk)]  = pwelch(v(:,2),[],[],[],120,'onesided') ; 
    [ez(:,kk), fez(:,kk)]  = pwelch(v(:,3),[],[],[],120,'onesided') ; 
    for ii=1:3
        Y = fft(energia(:,ii));
        P2 = abs(Y/L);
        P1 = P2(1:round(L/2)+1);
        P1(2:end-1) = 2*P1(2:end-1);
        f = Fs*(0:(round(L/2)))/L;
        eint(:,ii) = interp1(f,P1,fint,'spline');
    end
    Eint=[Eint + eint.^2];
end
Eint=Eint/length(curvas2);
EX=(mean(ex'));
EY=(mean(ey'));
EZ=(mean(ez'));
FEX=(mean(fex'));
FEY=(mean(fey'));
FEZ=(mean(fez'));

%Método 1

v2=(v2-mean(v2))./std(v2) ;
z2=(z2-mean(z2))./std(z2) ;
E=v2;
[ex, fex]  = pwelch(E(:,1),[],[],[],120,'onesided') ; 
[ey, fey]  = pwelch(E(:,2),[],[],[],120,'onesided') ; 
[ez, fez]  = pwelch(E(:,3),[],[],[],120,'onesided') ; 
[epot, fepot]  = pwelch(z2,[],[],[],120,'onesided') ;
figure;
loglog(fex, ex,'*');hold on
loglog(fey, ey,'*');hold on
loglog(fez, ez,'*');hold on
[epot, fepot]  = pwelch(z2,[],[],[],120,'onesided') ;
grid on

%Método 2

loglog(FEX, EX,'o');hold on
loglog(FEY, EY,'o');hold on
loglog(FEZ, EZ,'o');hold on


%Método 3
% figure;
loglog(fint, Eint(:,1),'d');hold on
loglog(fint, Eint(:,2),'d');hold on
loglog(fint, Eint(:,3),'d');hold on

%Metodo 4
clear E
for ii=1:3
    Y = fft(v2(:,ii));
    L=size(v2,1)
    P2 = abs(Y/L);
    
    P1 = P2(1:round(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(round(L/2)))/L;
    E(:,ii)=P1;
end
figure
loglog(f, E(:,1));hold on
loglog(f, E(:,2))
loglog(f, E(:,3))

figure;
loglog(fex(1:8439), ex(1:8439),'*');hold on
loglog(fey(1:8439), ey(1:8439),'*');hold on
loglog(fez(1:8439), ez(1:8439),'*');hold on
xlabel('Frecuencia [Hz]');
ylabel('Espectro de la Energía Cinética');
grid on
legend('Energía en X', 'Energía en Y', 'Energía en Z')
set(gca,'fontsize',16)

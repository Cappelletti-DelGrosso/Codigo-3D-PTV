%Trayectorias sintéticas
clear all
close all

modo='onesided';
N  = 1    ;
Fs = 120   ;
L  = 500   ; 
T  = L/Fs ;
v  = [ -34.3805,    3.0771,   -1.4175] ;
%error = [0.4522,    0.5223,    0.8180] ;
W = 30;
 error = [2,    0,    0] ;
curva={};
t = (0:L)/Fs ; 
f = Fs*(0:(L/2))/L;
f1 = 1 ;
f2 = 30 ;

for jj=1:N
    
   xyz = [v(1)*t', v(2)*t', v(3)*t' ] ;
   r = [ruido2(f1, f2, f)', ruido2(f1, f2, f)', ruido2(f1, f2, f)' ];
   r = r.*error ;
   xyz2 = xyz + r ;
   curva={curva{:}, [t', xyz2]} ;
end

v=diff(xyz)*Fs;
v2=diff(xyz2)*Fs;

[w, fw] = pwelch(xyz(:,1),[],[],[],Fs,modo) ;
[w2,fw2] = pwelch(xyz2(:,1),[],[],[],Fs,modo) ;
[w3,fw3] = pwelch(r(:,1),[],[],[],Fs,modo) ;

[u, fu]  = pwelch(sum(v.^2,2),[],[],[],Fs,modo) ;
[u2, fu2] = pwelch(sum(v2.^2,2),[],[],[],Fs,modo) ;

[tXYZf, UVWf, ABCf]=FiltrarTrayectoria2([t',xyz2], W);

figure(1)
plot3(xyz(:,1), xyz(:,2), xyz(:,3),'b'); 
hold on
plot3(curva{1}(:,2), curva{1}(:,3), curva{1}(:,4),'r')
grid on
box on
daspect([1,1,1])
title('Trayectoria')
xlabel({'X [mm]'},'FontSize', 16)
ylabel({'Y [mm]'},'FontSize', 16)
zlabel({'Z [mm]'},'FontSize', 16)
set(gca,'fontsize',16)
plot3(tXYZf(:,2), tXYZf(:,3), tXYZf(:,4),'g') ; 
legend('Original','Con Error','Filtrada')

[w4, fw4] = pwelch(tXYZf(:,1),[],[],[],Fs,modo) ;                    
[u4, fu4] = pwelch(sum(UVWf.^2,2),[],[],[],Fs,modo) ; 


figure(2); loglog(fw(1:(length(w))), w(1:(length(w2))))
hold on; loglog(fw2(1:(length(w2))), w2(1:(length(w2))))
loglog(fw3(1:(length(w3))), w3(1:(length(w3))))
loglog(fw4(1:(length(w4))), w4(1:(length(w4))))
title('Espectro trayectoria X')
legend('Original','Con Error','Error','Filtrada')
xlabel({'Frecuencia [Hz]'},'FontSize', 16)
set(gca,'fontsize',16)

figure(3); loglog(fu(1:(length(u))), u(1:(length(u))))
hold on; loglog(fu2(1:(length(u2))), u2(1:(length(u2))))
loglog(fw3(1:(length(w3))), w3(1:(length(w3))))
loglog(fu4(1:(length(u4))), u4(1:(length(u4))))
title('Espectro Energía X')
legend('Original','Con Error','Error','Filtrada')
xlabel({'Frecuencia [Hz]'},'FontSize', 16)
set(gca,'fontsize',16)

f = Fs*(0:(L-1))/L;
ceros=zeros(size(v(:,1)));
ceros(1:size(UVWf,1))=UVWf(:,1);
espectrov2=abs(fft(v2(:,1)));
figure(4)
loglog(f, abs(fft(v(:,1))),'r')
hold on; loglog(f, abs(fft(v2(:,1))),'g')
loglog(f, abs(fft(ceros)),'b')
% xlim([0,Fs/2])
grid on

f = Fs*(0:(L))/L;
ceros=zeros(size(xyz(:,1)));
ceros(1:size(tXYZf,1))=tXYZf(:,2);
espectroxyz2=abs(fft(xyz2(:,1)));
espectroxyz=abs(fft(xyz(:,1)));
espectrof=abs(fft(ceros));
figure(5)
loglog(f, espectroxyz,'--','Color',[255, 102, 0]/255,'LineWidth',2)
hold on; loglog(f, abs(fft(xyz2(:,1))),'Color',[0, 100, 0]/150)
loglog(f, espectrof*espectroxyz(1)/espectrof(1),'.-','Color',[0, 114, 187]/187,'LineWidth',1.5)
% xlim([0,Fs/2])
grid on
box on
title('Espectro Trayectoria')
xlabel({'Frecuencia [Hz]'},'FontSize', 16)
ylabel({'Amplitud'},'FontSize', 16)
set(gca,'fontsize',16)
legend('Original','Con Error','Filtrada')

figure
plot(t,xyz(:,1),'--','Color',[255, 102, 0]/255,'LineWidth',1.5);
hold on
plot(curva{1}(:,1), curva{1}(:,2),'Color',[0, 100, 0]/150,'LineWidth',1.5)
plot(tXYZf(:,1), tXYZf(:,2),'.-','Color',[0, 114, 187]/187,'LineWidth',1.5) ; 
grid on
box on
title('Trayectoria')
xlabel({'Tiempo [s]'},'FontSize', 16)
ylabel({'X [mm]'},'FontSize', 16)
set(gca,'fontsize',16)
legend('Original','Con Error','Filtrada')



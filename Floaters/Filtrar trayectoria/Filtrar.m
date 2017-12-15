clear all
close all

load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\21-06-17\Floaters2\Curva3.mat')

N=length(curva3);
% T=[];
% Tf=[];
ax  = [];
ay  = [];
az  = [];
axf = [];
ayf = [];
azf = [];
vx  = [];
vy  = [];
vz  = [];
vxf = [];
vyf = [];
vzf = [];
espectro  = zeros(3,49) ;
espectrof = zeros(3,37) ;

for jj=1:N
    if length(curva3{jj})>=100
    %tXYZ=[[0:(1/(length(curva3{jj})-1)):1]',curva3{jj}];
    tray=curva3{jj};
    tXYZ=[[0:(1/(100-1)):1]',tray(1:100,:)];
    
    L = size(tXYZ,1);
    t = tXYZ(:,1);
    x = tXYZ(:,2);
    y = tXYZ(:,3);
    z = tXYZ(:,4);
    VXYZ= diff(tXYZ(:,2:4));


    W = 2*6;
    tic
    [XYZf, UVWf, ABCf] = FiltrarTrayectoria(tXYZ,W);
    toc

    xf = XYZf(:,1);
    yf = XYZf(:,2);
    zf = XYZf(:,3);
    
    % figure(1);
    % plot(diff(x),'b');
    % hold on;
    % plot(UVWf(:,1)/L,'r-');
    % hold off
    % grid on;
    % title('velocidad')
    % drawnow
    % 
    % figure(2);
    % plot(diff(diff(x)),'b');
    % hold on;
    % plot(ABCf(:,1)/L^2,'r-');
    % hold off
    % grid on;
    % xlim([2*W L-2*W])
    % title('aceleracion')
    % drawnow

%     figure;
    for ii=1:3
        eva = abs(fft((VXYZ(:,ii))));
        ev(ii,:) = eva(1:(end/2));
%         figure
%         loglog(ev,'b');
%         hold on;
        aux  = UVWf(:,ii);
        aux  = aux(abs(aux)>=0);
        evfa = abs(fft((aux/L).^2));
        evf(ii,:)=evfa(1:(end/2));
%         loglog(evf,'r-');
%         hold off
%         grid on;
%         title(['espectro velocidad, W=',num2str(W)])
%         drawnow
%         T=[T,size(ev,1)];
%         Tf=[Tf,size(evf,1)];

    end
    espectro=espectro+ev;
    espectrof=espectrof+evf;
    
    vx  = [vx; VXYZ(:,1)] ;
    vy  = [vy; VXYZ(:,2)] ;
    vz  = [vz; VXYZ(:,3)] ;
    vxf = [vxf; UVWf(:,1)/L] ;
    vyf = [vyf; UVWf(:,2)/L] ;
    vzf = [vzf; UVWf(:,3)/L] ;
    
    AXYZ = diff(VXYZ) ;
    ax   = [ax;AXYZ(:,1)] ;
    ay   = [ay;AXYZ(:,2)] ;
    az   = [az;AXYZ(:,3)] ;
    axf  = [axf; ABCf(:,1)/L^2] ;
    ayf  = [ayf; ABCf(:,2)/L^2] ;
    azf  = [azf; ABCf(:,3)/L^2] ;
    end
end
figure;
loglog(espectro','b') ;
hold on
loglog(espectrof','r-') ;
grid on

vxf = vxf(abs(vxf)>=0) ;
vyf = vyf(abs(vyf)>=0) ;
vzf = vzf(abs(vzf)>=0) ;
GraficarA(vxf, vyf, vzf, 1)
GraficarA(vx, vy, vz, 1)

axf = axf(abs(axf)>=0) ;
ayf = ayf(abs(ayf)>=0) ;
azf = azf(abs(azf)>=0) ;
GraficarA(axf, ayf, azf, 2)
GraficarA(ax, ay, az, 2)

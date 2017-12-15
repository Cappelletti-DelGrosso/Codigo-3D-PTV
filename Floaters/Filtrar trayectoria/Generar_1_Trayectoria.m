%% Generar trayectorias para Npart particulas en 3D
clf
clear all

% random walk in 3D smoothed
L = 1000;
t = linspace(0,1,L);

Npart = 1;
d = 0.2;
Sfactor = L/10;

XYZt = zeros(Npart,3,L);

for ii=1:Npart,
    xyz = cumsum(d*(randn(L,3)),1)/2;

    xo = xyz(:,1);
    yo = xyz(:,2);
    zo = xyz(:,3);

    x = smooth(xo,Sfactor,'lowess');
    y = smooth(yo,Sfactor,'lowess');
    z = smooth(zo,Sfactor,'lowess');

    XYZt(ii,:,:) = reshape([x y z].',[1,3,L]);
end

%% Lets add noise
nxyz = 0.015*randn(L,3);
nx = nxyz(:,1)*std(x);
ny = nxyz(:,2)*std(y);
nz = nxyz(:,3)*std(z);

x = x+nx;
y = y+ny;
z = z+nz;

figure(1);
plot3(x-nx,y-ny,z-nz,'r')
hold on
plot3(x,y,z,'linewidth',1)
hold off
grid on
box on
camproj perspective
hold on
ax = axis;
plot3(x,y,ax(5)*ones(size(z)),'-','color',0.92*[1 1 1]);
plot3(ax(2)*ones(size(x)),y,z,'-','color',0.92*[1 1 1]);
plot3(x,ax(4)*ones(size(y)),z,'-','color',0.92*[1 1 1]);
hold off
daspect([1 1 1])
view(-18,8)
drawnow

%% Luthi smoothing/decomposition of noise

tXYZ = [t.' x y z ];

W = 20;
tic
[XYZf, UVWf, ABCf] = FiltrarTrayectoria(tXYZ,W);
toc

xf = XYZf(:,1);
yf = XYZf(:,2);
zf = XYZf(:,3);

%% Comparacion de velocidades
figure(4);
plot(diff(x-nx),'b');
hold on;
plot(UVWf(:,1)/L,'r-');
hold off
grid on;
title('velocidad')
drawnow

figure(5);
plot(diff(diff(x-nx)),'b');
hold on;
plot(ABCf(:,1)/L^2,'r-');
hold off
grid on;
xlim([2*W L-2*W])
title('aceleracion')
drawnow

!osascript -e 'tell application "iTerm2" to activate'
return

%% Graficamos los resultados

figure(1);
hold on;
plot3(xf(1:end),yf(1:end),zf(1:end),'g','linewidth',1)
hold off
legend('ORIG','NOISY','SMOOTHED')
camproj perspective
drawnow

figure(2)
plot(t,x-nx,'r',t,x,'b',t(1:numel(xf)),xf,'g','linewidth',1.25)
xlabel('x')
ylabel('y')
legend('ORIG','NOISY','SMOOTHED')
grid on
xlim([0 max(t)])

figure(3);
plot(t,nx,t,x-xf)
grid on
legend('NOISE ADDED','NOISY - FILTERED')
xlim([0 max(t)])

return 

% idxNaN = find(isnan(xf));
% xf(idxNaN) = [];
% x(idxNaN) = [];
% nx(idxNaN) = [];

figure(1);
hist(nx);
grid on

figure(2);
hist(x-xf);
grid on

return

%% Calculemos la transformada fourier

idxNaN = find(isnan(xf));
xf(idxNaN) = [];
x(idxNaN) = [];
nx(idxNaN) = [];

% figure(1); clf;
% plot(x); hold on; plot(xf); plot(x-nx); hold off
% grid on
% xlim([0 L])

win = tukeywin(numel(x),0);

Fx   = fft(x.*win);
Fxnx = fft((x-nx).*win);
Fxf  = fft(xf.*win);
Fx   = Fx(1:end/2);
Fxnx = Fxnx(1:end/2);
Fxf = Fxf(1:end/2);





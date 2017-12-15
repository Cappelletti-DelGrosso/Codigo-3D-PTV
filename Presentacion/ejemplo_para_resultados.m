
X = tray(:,1);
Y = tray(:,2);
Z = tray(:,3);
T = 1:numel(X);

[fitresult, gof] = ajusteporplano(X, Y, Z);

nversor = [fitresult.a, fitresult.b, -1];
zversor = [0,0,1];
theta = acos(nversor*zversor'/(norm(nversor)*norm(zversor)));
k = cross(nversor/norm(nversor), zversor/norm(zversor));
k = k/norm(k);

R = vecarot(k*theta);
centro = [mean(X), mean(Y), mean(Z)];
tray2 = tray - centro;

A=R*tray2';
A=A';

figure;
colormap jet
h = colormapline(A(:,1),A(:,2),A(:,3));
% h.set('linewidth',2)
daspect([1 1 1])
grid on
box on
zlim([-50 50])
hold on
scatter3(0, 0, 0, 50,[0.3 0 0.5],'filled')



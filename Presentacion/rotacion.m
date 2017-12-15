function [R, centro]=rotacion(X,Y,Z)
tray(:,1)=X;
tray(:,2)=Y;
tray(:,3)=Z;

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
end



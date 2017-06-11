function [ P ] = homo( H, Vi )

mH= mean(H, 2);
disH = std(H, 1, 2);

mVi= mean(Vi, 2);
disVi = std(Vi, 1, 2);

T=[1/disVi(1), 0, -mVi(1)/disVi(1); 0, 1/disVi(2), -mVi(2)/disVi(2); 0,0,1];  %Matrices de normalización
U=[1/disH(1) , 0, -mH(1) /disH(1) ; 0, 1/disH(2) , -mH(2) /disH(2) ; 0,0,1];

Qi= T*Vi; %Normalizamos los vectores, a media 0 y dispersión 1
Qw= U*H;

[ G ] = dsvd2( Qw, Qi ); %Hallamos un guess inicial mediante descomposición svd de la homografía

x0=[G(1,:), G(2,:), G(3,:)];

options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt',...
    'MaxFunEvals',3000);

[x,resnorm] = lsqnonlin(@(x) myfun2(x, Qw, Qi),x0,[],[],options); %Hallamos la verdadera homografía con minimización de cuadrados no lineal

X=reshape(x, 3, 3);

P = inv(T)*X'*U; %Recuperamos la homografía de los puntos sin normalizar

end


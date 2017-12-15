function [ A3, R3, T3, k, R4, T4, F ] = zhan6( H, Vi )

N= size(Vi,3); %Cantidad de fotos tomadas
 
H=[H(1:2,:); ones(1,size(H,2))];

V=[];
for kk=1:N
    [  P(:,:,kk)  ] = homo(H, Vi(:,:,kk));%Obtengo la homografía para los puntos H del mundo y Vi de la imagen
    P(:,:,kk) = P(:,:,kk)*sign(det(P(:,:,kk)));
    [ v11 ] = funcionvij(P(:,:,kk)',1,1);
    [ v12 ] = funcionvij(P(:,:,kk)',1,2);
    [ v22 ] = funcionvij(P(:,:,kk)',2,2);
    V = [V;v12; (v11-v22)];
end

[O, Q, J] = svd(V);
Q(6,6)
b = J(:,6);
B = [b(1), b(2), b(4); b(2),b(3), b(5); b(4), b(5), b(6) ];

 v0 = (B(1,2)*B(1,3)-B(1,1)*B(2,3))/(B(1,1)*B(2,2)-B(1,2)^2);
  l = B(3,3)- (B(1,3)^2 + v0*(B(1,2)*B(1,3) - B(1,1)*B(2,3)))/B(1,1);
  a = sqrt(l/B(1,1));
bet = sqrt((l*B(1,1))/(B(1,1)*B(2,2)-B(1,2)^2));
  c = (-B(1,2)*(a^2)*bet)/l;
 u0 =(c*v0)/a - (B(1,3)*a^2)/l;

% disp('Matriz de paramatros intrinsecos')
A = [a, c, u0; 0, bet, v0; 0, 0, 1];


S = inv(A);
R = nan(3,3,N);
for kk=1:N
    lambda    = 1/norm(S*P(:,1,kk));
    Ra        = [lambda*S*P(:,1,kk), lambda*S*P(:,2,kk)];
    R(:,:,kk) = [Ra, cross(Ra(:,1), Ra(:,2))];
    T(:,kk)   = lambda*S*P(:,3,kk);
%     disp(['Rotacion de la imagen ',num2str(kk)])
%     R(:,:,kk)
%     disp(['Traslacion de la imagen ',num2str(kk)])
%     T(:,kk)
end

clear k t kk b B O Q J V v11 v12 v22 S
x0 = [];
x0 = [A(1,1),A(2,2), A(1,3), A(2,3),A(1,2)];
for jj=1:N
   k  = rotavec(R(:,:,jj));
   t  = T(:,jj);
   x0 = [x0,k',t'];
end

F1 = myfun32(x0, H, Vi);

clear jj k t

ub=inf(1,length(x0));
lb=(-1)*ub;
lb(1:5)=10^-7;
options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective',...
    'MaxFunEvals',40000, 'Display','iter','FunctionTolerance', 10^-5);

[x,resnorm] = lsqnonlin(@(x) myfun32(x, H, Vi),x0,lb,ub,options);

x = [x(1:5),nan; (reshape(x(6:end),6 ,(length(x)-5)/6))'];

A2 = [x(1,1), x(1,5), x(1,3);0, x(1,2), x(1,4); 0,0,1];
for jj=2:(N+1)
    k            = [x(jj,1), x(jj,2), x(jj,3)]';
    R2(:,:,jj-1) = vecarot(k);
    T2(:,jj-1)   = [x(jj,4), x(jj,5), x(jj,6)]';
end
clear k x0
ki = [0,0];
[ ~, k0 ] = distorsionar2( H, Vi, ki, A2, R2, T2 );

x0 = [];
x0 = [k0', A2(1,1),A2(2,2), A2(1,3), A2(2,3),A2(1,2)];
for jj=1:N
   v  = rotavec(R2(:,:,jj));
   t  = T2(:,jj);
   x0 = [x0,v',t'];
end

ub=inf(1,length(x0));
lb=(-1)*ub;
lb(3:7)=10^-7;

options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective',...
    'MaxFunEvals',20000, 'Display','iter','FunctionTolerance', 10^-5);

[x,~] = lsqnonlin(@(x) myfun42(x, H, Vi),x0,lb,ub,options);
clear k
% disp('Distorsion Radial')
k = [x(1), x(2)];
x = [x(3:7),nan; (reshape(x(8:end),6 ,(length(x)-7)/6))'];
% 
% disp('Matriz de paramatros intrinsecos')
A3 = [x(1,1), x(1,5), x(1,3);0, x(1,2), x(1,4); 0,0,1]
for jj=2:(N+1)
    v            = [x(jj,1), x(jj,2), x(jj,3)]';
    R3(:,:,jj-1) = vecarot(v);
    T3(:,jj-1)   = -R3(:,:,jj-1)'* [x(jj,4), x(jj,5), x(jj,6)]';
%     disp(['Rotacion de la imagen ',num2str(jj-1)])
    R3(:,:,jj-1);
%     disp(['Traslacion de la imagen ',num2str(jj-1)])
    T3(:,jj-1);
end
clear x0 v t jj
x0 = [];
x0 = [k, A3(1,1),A3(2,2), A3(1,3), A3(2,3),A3(1,2)];
for jj=1:N
   v  = rotavec(R3(:,:,jj));
   t  = -R3(:,:,jj)*T3(:,jj);
   x0 = [x0,v',t'];
end

F=myfun42(x0, H, Vi);

J=F;
S=[];
for ii=1:size(Vi,3)
    S = [S;std(J(1:(size(Vi,2)*2)))];
    J=J((size(Vi,2)*2)+1:end);
end

[~, indice]=sort(S);

i1=indice(1);

R4 = R3(:,:,i1);
T4 = T3(:, i1);

if std(F)>5
    disp('Error: las matrices halladas no aproximan bien a los puntos.')
end
end
function [R, T, A] = minepi(direccion,bien, dirparametros)
load(dirparametros)

imagenescomun(:,:,1)=J1(bien,:);
imagenescomun(:,:,2)=J2(bien,:);
clear J1 J2
dircodigos=cd;

for camara = 1:2
    cd([direccion, '\Puntos', num2str(camara)])
    
    for ii=1:size(imagenescomun,1)
         char(imagenescomun(ii,:,camara))
        B                 = dlmread(char(imagenescomun(ii,:,camara)),';',1,0); %Cargo las imagenes en comun
        Wi(:,:,ii,camara) = [B'; ones(1,size(B,1))];
    end
    cd(dircodigos)
end

x0=[];
for ii=1:2
x0=[x0, A(1,1,ii),A(2,2,ii),A(1,3,ii),A(2,3,ii),A(1,2,ii)];
end

k1  = rotavec(R(:,:,1));
k2  = rotavec(R(:,:,2));
x0 = [x0,k1',T(1,:),k2',T(2,:)];

options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective',...
    'MaxFunEvals',40000, 'Display','iter','FunctionTolerance', 10^-5);

clear R T A
[x,resnorm] = lsqnonlin(@(x) myfuncorr(x, Wi),x0,[],[],options);

for ii=1:2
A(:,:,ii) = [x(1+5*(ii-1)), x(5+5*(ii-1)), x(3+5*(ii-1));0, x(2+5*(ii-1)), x(4+5*(ii-1)); 0,0,1] ;
end

k1 = [x(11),x(12),x(13)];
R(:,:,1) = vecarot(k1);
T(1,:) = [x(14), x(15), x(16)]';
k2 = [x(17),x(18),x(19)];
R(:,:,2) = vecarot(k2);
T(2,:) = [x(20), x(21), x(22)]';
end
clear all
close all

camara = 1;
direccion='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\07-06-2017\';
puntos = dir([direccion,'Puntos',num2str(camara),'\*C',num2str(camara),'S0001.tif.csv']);
n=9;
m=6;
pix = [20E-3; 17E-3]; %tamaño del pixel del sensor
lado=25.4;
Npuntos=length(puntos);

for jj=1:10
    jj
    comienzo = 10*(jj-1)+1 ;
    final    = comienzo+9 ;
    for kk=1:(final-comienzo+1)
   
        A=dlmread([direccion,'Puntos',num2str(camara),'\',puntos(kk+comienzo-1).name],';',1,0);
        Vi(:,:,kk)=[A'; ones(1,size(A,1))];

    end

     [y, x] = meshgrid(1:m,1:n);
          H = lado*[x(:)'-round(n/2);y(:)'-round(m/2)];

    visualizar( H, Vi )      
    pause      

    [ A3, R3, T3, k, R4, T4, F ] = zhan5( H, Vi );

    focal = [A3(1,1), A3(2,2)]*pix(camara)

    f(jj,1)=focal(1);
    f(jj,2)=focal(2);
    U0(jj)=A3(1,3);
    V0(jj)=A3(2,3);
       
    
end

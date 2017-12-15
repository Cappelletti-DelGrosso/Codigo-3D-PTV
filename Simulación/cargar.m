function [ R, T, A, k, J1, J2, M1, M2, sx, sy, F ] = cargar( direccion )

dircodigos=cd;

cd(direccion)
load('Resultados Camara 1.mat')
A1=A;
f1=f;
F1=F;
imagenesbuenas1=imagenesbuenas;
imagenesrechazadas1=imagenesrechazadas;
k1=k;
R1=R;
T1=T;
U01=U0;
V01=V0;
Vi1=Vi;
clearvars -except A1 f1 F1 imagenesbuenas1 imagenesrechazadas1 k1 R1 T1 U01 V01 Vi1 dircodigos

load('Resultados Camara 2.mat')
A2=A;
f2=f;
F2=F;
imagenesbuenas2=imagenesbuenas;
imagenesrechazadas2=imagenesrechazadas;
k2=k;
R2=R;
T2=T;
U02=U0;
V02=V0;
Vi2=Vi;
clearvars -except A2 f2 F2 imagenesbuenas2 imagenesrechazadas2 k2 R2 T2 U02 V02 Vi2  A1 f1 F1 imagenesbuenas1 imagenesrechazadas1 k1 R1 T1 U01 V01 Vi1 dircodigos direccion

I1=uint16(imagenesbuenas1);
I2=uint16(imagenesbuenas2);

comun=[];
for ii=1:size(I1,1)
    
   Z=I1(ii,1:15);
   
   for jj=1:size(I2,1)
       
       s = sum(Z==I2(jj,1:15));
       if s==length(Z)
           comun=[comun; ii, jj];
       end
   end
end

disp('Imágenes en común: ')
J1 = I1(comun(:,1),:);
J2 = I2(comun(:,2),:);
char([J1, uint16(32*ones(size(comun,1),4)), J2])

errores1=reshape(F1,  length(F1)/size(Vi1,3), size(Vi1,3));
errores2=reshape(F2,  length(F2)/size(Vi2,3), size(Vi2,3));

errorescomun = sum([errores1(:,comun(:,1)); errores2(:,comun(:,2))].^2)';

disp('Error acumulado más pequeño:')
min(errorescomun)
% minimo= and(min(errorescomun)*(1-1E-4)<errorescomun, errorescomun<min(errorescomun)*(1+1E-4));
[~, minimo]=min(errorescomun);
mejores=comun(minimo,:);
disp('Mejores imágenes en común: ')

M1=I1(mejores(1),:);
M2=I2(mejores(2),:);
char([M1,uint16(32*ones(1,4)), M2])

A(:,:,1) = A1;
R(:,:,1) = R1(:,:,mejores(1));
T(1,:)   = T1(:,mejores(1));
k(1,:)   = k1;

A(:,:,2) = A2;
R(:,:,2) = R2(:,:,mejores(2));
T(2,:)   = T2(:,mejores(2));
k(2,:)   = k2;
sx       = [20E-3; 17E-3];
sy       = [20E-3; 17E-3];

cd(dircodigos)
cd ..
cd('Correspondencia')
[ F ] = matrizfundamental2( R, T, A, 1, 2 ) ;
cd ..
cd(direccion)

save('Parámetros Montaje Completo', 'R', 'T', 'A', 'k', 'J1', 'J2', 'M1', 'M2', 'sx', 'sy', 'F' )
cd(dircodigos)
end
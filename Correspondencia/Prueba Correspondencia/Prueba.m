%Prueba correspondencia
close all
clear all

load('C:\Users\Nicolás\Desktop\Prueba Correspondencia\Prueba.mat')
dir=cd;
cd ..
correspondencia3(centros1,centros2, im1, [dir,'\Parametros-prueba2.mat'], 1,201);

%Otros

[xtray, ytray]= meshgrid(1:50:150, 1:50:150);

H=[xtray(:)';ytray(:)'; zeros(1,length(xtray(:)))] ;
load('C:\Users\Nicolás\Desktop\Labo 6\Codigo\Github\Correspondencia\Prueba Correspondencia\Parametros-prueba2.mat')
escena( centros1, A(:,:,1), 1, 1, R(:,:,1), (-R(:,:,1)*T(1,:)')', 201, 201, H, im1(:,:,1) )
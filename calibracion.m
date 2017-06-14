close all
clear all

direccion='C:\Users\garba\Desktop\14-06-17\'; %Ruta donde se encuentra la carpeta de imagenes de calibracion
codigos=cd;
for camara=1:2
esquinas10(camara, direccion)
pause

N=mirar(camara, direccion)
pause

leer4(camara, direccion, 1, N, N)
pause
end

pause
cd('Simulación')
cargar( direccion )
simular(direccion);
[X, N]=pruebaerrores(direccion);
cd ..
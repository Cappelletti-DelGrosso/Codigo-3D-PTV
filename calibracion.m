close all
clear all

direccion='C:\Users\Nicolás\Desktop\07-06-2017\Damero\';
codigos=cd;
for camara=1:2
esquinas10(camara, direccion)
% pause

N=mirar(camara, direccion)
% pause

leer4(camara, direccion, 1, N, N)
% pause
end
pause
codigosimulacion='C:\Users\Nicolás\Desktop\Labo 6\Codigo\Simulacion\Simulación- 26-05-17';
cd(codigosimulacion)
[N,X]=simular(direccion, codigosimulacion);
cd(codigos)
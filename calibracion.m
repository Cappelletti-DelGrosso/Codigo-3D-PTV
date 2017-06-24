function []=calibracion(direccion, e, m, l, s, p)
% close all
% clear all
% 
% direccion='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\21-06-17\'; %Ruta donde se encuentra la carpeta de imagenes de calibracion
% codigos=cd;
for camara=1:2
    
    if e==1
%         pause
        esquinas10(camara, direccion)
    end
    
    if m==1
%         pause
        N=mirar(camara, direccion)
    end

    if l==1
%         pause
        leer4(camara, direccion, 1, N, N)
    end
end

if s==1
%     pause
    cd('Simulación')
    cargar( direccion )
    simular(direccion);
    cd ..
end

if p==1 
%     pause
    cd('Simulación')
    [X, N]=pruebaerrores(direccion);
    cd ..
end
end
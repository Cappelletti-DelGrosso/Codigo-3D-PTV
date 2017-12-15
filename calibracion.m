function []=calibracion(direccion, e, m, l, s, p)
%100 imagenes en 45 minutos
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
        N=mirar(camara, direccion, 0)
    end

    if l==1
%         pause
       
        leer4(camara, direccion, 1, 86, 86)
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
    [X, N,errorplano]=pruebaerrores(direccion);
    cd ..
end
end
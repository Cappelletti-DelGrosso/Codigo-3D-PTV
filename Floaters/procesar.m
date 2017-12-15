function []=procesar(direccion)

% direccion      = 'C:\Users\Nicolás\Desktop\Random1-120Hz-primer intento\';
dirparametros  = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\01-09-17\Damero\Parámetros Montaje Completo.mat';
dirfloaters    = cd;
cd(direccion)
load('Particulas')
cd(dirfloaters)

[trayectorias]=trayectoria(particulas);

largo3= cellfun(@(x) size(x,1), trayectorias);
for camara=1:2
    figure; hist(largo3((largo3(:,camara)>20),camara), sqrt(length(largo3(:,camara))))
    title(['Histograma largo trayectorias, camara ',num2str(camara)])
end

figure
for camara=1:2
    cont=0;
    for ii=1:size(trayectorias,1)
        
        if size(trayectorias{ii,camara},1)>50
            cont=cont+1;
            trayectorias2{cont, camara}=trayectorias{ii,camara};
            subplot(1,2,camara)
            plot(trayectorias2{cont, camara}(:,1), trayectorias2{cont, camara}(:,2))
            hold on
            daspect([1,1,1])
            axis([0 1024 0 1024])
%             pause
        end
    end
    
end

%Dura 9856 s= 3 horas
% load('C:\Users\Nicolás\Desktop\Correspondencia_Distorsion\Fmedia.mat')
load('C:\Users\Nicolás\Desktop\Fmatlab.mat')
F=fLMedS
tic
[curva, resultados]=nuevacorrespon(trayectorias2, dirparametros,F);
toc
%
cd(direccion)
save('Curva', 'curva')
cd(dirfloaters)
end
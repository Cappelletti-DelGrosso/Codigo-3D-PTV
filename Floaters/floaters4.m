function [curva4, curva, resultados,vp1, vp2, largo3, particulas]=floaters4(direccion, dirparametros, suplibre, frecuencia, shutting, p, c)
%direccion      = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\12-09-17\Superficie libre\';
%dirparametros  = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\02-11-17\Damero\Parámetros Montaje Completo.mat';
% suplibre= 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Superficie libre\';
% frecuencia = [80, 250];

dirfloaters    = cd;
if p==1
    tic
    [particulas, flot, frames, fc]=circulos2(direccion, 0, 0);
    toc
    % 2726 frames en 1 hora
    cd(direccion)
    save('Particulas', 'particulas')
    cd(dirfloaters)
    clear particulas
end

if c==1
    cd(direccion)
    load('Particulas')
    cd(dirfloaters)
    [trayectorias]=trayectoria(particulas);

    largo3= cellfun(@(x) size(x,1), trayectorias);

%     figure
    for camara=1:2
        cont=0;
        for ii=1:size(trayectorias,1)

            if size(trayectorias{ii,camara},1)>50
                cont=cont+1;
                trayectorias2{cont, camara}=trayectorias{ii,camara};
    %             subplot(1,2,camara)
    %             plot(trayectorias2{cont, camara}(:,1), trayectorias2{cont, camara}(:,2))
    %             hold on
    %             daspect([1,1,1])
    %             axis([0 1024 0 1024])
    %             pause
            end
        end

    end

    %%cuanto se mueven en pixels en cada camara
    vp1=[];
    vp2=[];
    for ii=1:size(trayectorias2, 1)
        if ~isempty(trayectorias2{ii,1})
            vp1=[vp1; sqrt(sum(diff(trayectorias2{ii,1}(:,1:2)).^2, 2))];
        end
        if ~isempty(trayectorias2{ii,2})
            vp2=[vp2; sqrt(sum(diff(trayectorias2{ii,2}(:,1:2)).^2, 2))];
        end
    end
    % [mean(vp1),mean(vp2)]


    load(dirparametros)
    %Dura 9856 s= 3 horas
    tic
    [curva, resultados]=nuevacorrespon(trayectorias2, dirparametros,F);
    toc
    %

    cd(direccion)
    save('Curva', 'curva')
    cd(dirfloaters)

    cont=0;
    for kk=1:length(curva)
        L=size(curva{kk},1);
        if L>50
            cont=cont+1;
            curva2{cont}=curva{kk};
        end
    end

    [curva3]=tiempo(curva2,shutting, frecuencia)

    cd(suplibre)
    load('Rycentro')
    cd(dirfloaters)
    [curva4]=rectificar(curva3,R,centro)

    cd(direccion)
    save('Curva4', 'curva4')
    cd(dirfloaters)
end
end
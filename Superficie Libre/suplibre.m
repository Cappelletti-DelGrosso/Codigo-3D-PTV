function [R, centro]=suplibre(dirparametros, direccion, graf1, graf2)

% dirparametros  = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\02-11-17\Damero\Parámetros Montaje Completo.mat';
% direccion='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Superficie libre\';
cd ..
cd('Floaters')
[particulas, flot, frames, fc]=circulos2(direccion,0 , graf1);

load(dirparametros)
cd ..
cd('Correspondencia')

puntos=[];
figure

for kk=1:size(particulas,1)
    kk
    clear candidatos1 candidatos2
    
    if graf2==1
        for camara=1:2
            im = imread([direccion, 'Floaters\', flot{camara}(kk).name]);
            im1(:,:,camara) = double(im)- fc(:,:,camara);
            clear im
        end
    end
    
[candidatos1, candidatos2,~,~]=nuevacorrespondencia2(particulas{kk,1}', particulas{kk,2}', im1, F, graf2);

for ii=1:length(candidatos1)
    ii
    if size(candidatos1{ii},1) == 1
        [~, ind]=min(sum((particulas{kk,1}-candidatos1{ii}).^2,2));
        
        if size(candidatos2{ind},1)== 1
        [ vw, error ] = triangular2( R, T, A, sx, sy, candidatos1{ii}(1), candidatos1{ii}(2), particulas{kk,2}(ii,1),  particulas{kk,2}(ii,2)  );
        puntos=[puntos; vw'];
        plot3(vw(1), vw(2), vw(3),'o')
        hold on
        end
    end
end

end

cd ..
cd('Presentacion')
[R, centro]=rotacion(puntos(:,1)', puntos(:,2)', puntos(:,3)');

puntos2= (R*((puntos-centro)'))';

figure
plot3(puntos2(:,1), puntos2(:,2), puntos2(:,3), 'o')
grid on
box on
axis([-400 400 -250 250 -200 200])
daspect([1 1 1])
cd ..
cd('Superficie Libre')
end


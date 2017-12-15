function [errorplano2]=Control(direccion, dirparametros)
% clear all
% close all
% 
% direccion='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\21-06-17\Control\';
% dirparametros= 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\02-11-17\Damero\Parámetros Montaje Completo';
dircodigos=cd;


for camara = 1:2
    cd([direccion, '\Puntos', num2str(camara)])
    puntos = dir([direccion, '\Puntos', num2str(camara),'\*C',num2str(camara),'S0001.tif.csv']);
    Npuntos=length(puntos);

    for ii=1:Npuntos
        B                 = dlmread(puntos(ii).name,';',1,0); %Cargo las imagenes en comun
        Wi(:,:,ii,camara) = [B'; ones(1,size(B,1))];
    end
end
load(dirparametros)
cd(dircodigos)
cd ..
cd('Simulación')

lado=25.4;
n=9;
m=6;
[y, x] = meshgrid(1:m,1:n);
     H = lado*[x(:)'-round(n/2);y(:)'-round(m/2)]; % X,Y,Z en columna vertical, cada columna es una partícula
     H = [H; zeros(1,size(H,2))];

errores=[];
errorplano=[];
Npuntos
for ii=1:Npuntos
    inter=[];
    
    for jj=1:size(Wi,2)

    [ vw, error ] = triangular2( R, T, A, sx, sy, Wi(1,jj,ii,1), Wi(2,jj,ii,1), Wi(1,jj,ii,2), Wi(2,jj,ii,2)  );
    inter=[inter, vw];
    end
    
    X=reshape(inter(1,:),9,6)';
    Y=reshape(inter(2,:),9,6)';
    Z=reshape(inter(3,:),9,6)';
    [f, G] = fit( [inter(1,:)', inter(2,:)'], inter(3,:)', 'poly11' );
    seta = f(X,Y);
    errorplano2 = sum(([X(:)'; Y(:)'; Z(:)']-[X(:)'; Y(:)'; seta(:)']).^2);
    errorplano= [errorplano; sqrt(G.sse/54)];
    
    figure
    scatter3(inter(1,:), inter(2,:),inter(3,:), 'ro ')
    hold on
    surf(X,Y,f(X, Y))
    daspect([1,1,1])
    xlabel({'X [mm]'},'FontSize', 16)
    ylabel({'Y [mm]'},'FontSize', 16)
    zlabel({'Z [mm]'},'FontSize', 16)
    set(gca,'fontsize',16)
    
    errores(:,ii)=(((sum((inter-inter(:,23)).^2)).^0.5)'-((sum((H-H(:,23)).^2)).^0.5)');%./(((sum((H-H(:,1)).^2)).^0.5)');*100
    figure
    hist(errores(:,ii)) %Grafico un histograma de sus errores, este está desplazado por el error del punto 0
    title('Histograma errores respecto del punto 0 en mm')
end
figure
hist(errorplano2)

disp(['Error relativo al plano: ',num2str(mean(errorplano)),'mm'])

disp(['Error relativo entre puntos del plano: ',num2str(std(errores)),'mm'])

title('Histograma errores respecto del plano en mm^2')
cd ..
cd('Control')
end
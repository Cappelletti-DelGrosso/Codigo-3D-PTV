function [N]=mirar(camara, dirimagenes)

% clear all
% close all

% dirimagenes = 'C:\Users\Nicolás\Desktop\07-06-2017\Damero\';
codigos= cd;
cd(dirimagenes)

% camara=1
puntos = dir([dirimagenes,'\Puntos',num2str(camara),'\*C',num2str(camara),'S0001.tif.csv']);

N=length(puntos)

for ii=1:N
    ii
    imagen= double(puntos(ii).name);
    imagen= char(imagen(1:(end-4)))
    B=dlmread([dirimagenes,'Puntos',num2str(camara),'\',puntos(ii).name],';',1,0);

    im = imread([dirimagenes,'Damero\',imagen]);
    figure
    imshow(im, [0, 1.7*max(im(:))])
    daspect([1,1,1])

    hold on
    plot(B(:,1), B(:,2), 'r', 'LineWidth',2)
%     for ii=1:(9*6)
%     text(B(ii,1),B(ii, 2),num2str(ii),'Color','blue','FontSize',14);
%     end
    pause(3)
    close all
end
cd(codigos)
end
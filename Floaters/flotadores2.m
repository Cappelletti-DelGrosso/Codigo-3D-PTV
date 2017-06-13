clear all
close all

direccion = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\07-06-17\Floaters\';
dirparametros  = 'C:\Users\Nicolás\Desktop\07-06-2017\Damero\Parámetros Montaje Completo.mat';
dirsimulacion = cd;

for jj=1:3
centros=[];
    for camara=1:2

    fondo = dir([direccion,'Fondo blanco\*C',num2str(camara),'S0001.tif']);
    fc = double(imread([direccion,'Fondo blanco\',fondo.name]));

    flot=dir([direccion, 'Floaters\*C',num2str(camara),'S0001.tif']);
    N=length(flot)

    flot(jj).name
    im = imread([direccion, 'Floaters\', flot(jj).name]);

    im1(:,:,camara) = double(im)- fc;
    % figure
    % imagesc(im1(:,:,camara))
    % daspect([1 1 1])
    % colorbar

    [centersDark, radiiDark] = imfindcircles(im1(:,:,camara),[5 20],'ObjectPolarity','dark');
    %hold on
    %viscircles(centersDark, radiiDark,'Color','r');

    centros(:,:,camara)= centersDark' ;

    end

cd ..
cd('Correspondencia')
correspondencia
cd(dirsimulacion)
end
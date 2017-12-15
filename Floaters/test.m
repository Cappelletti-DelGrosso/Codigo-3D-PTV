clear all
close all

load im5.mat
im1 = im1(:,:,2);

tic
% primero conseguimos el valor threshold de intensidad que permite binarizar
% la imagen original, distinguiendo al fluido de las particulas flotantes
[counts,x] = hist(im1(:));
idxM = find(counts==max(counts))
thrv = x(counts(1:idxM)==min(counts(1:idxM)))

figure; plot(x, counts)

% thresholding
th = (im1<thrv);

% Tomemos las propiedades de las regiones
stats = regionprops(th, 'Centroid', 'MajorAxisLength', 'MinorAxisLength');
Npart = numel(stats);

% Creamos arrays donde van los resultados
centros = zeros(Npart,2);
radios  = zeros(Npart,1);

% Actuamos buscando circulos en cada subimagen que tiene particula
% version vectorizada 
for ii=1:Npart
    xoi = round(stats(ii).Centroid(1));
    yoi = round(stats(ii).Centroid(2));
    MAxL = stats(ii).MajorAxisLength;
    mAxL = stats(ii).MinorAxisLength;
    Wi = round(MAxL*1.75/2);
    Hi = round(mAxL*1.75/2);
    Rmin = round(mAxL/2);
    Rmax = round(MAxL/2);
    
    % Los bordes de cada subimagen de particula
    xmin = max(1,    xoi-Wi);
    xmax = min(1024, xoi+Wi);
    ymin = max(1,    yoi-Hi);
    ymax = yoi;
    
    % recortamos en la region de interes
    recorte = [(im1(ymin:ymax,xmin:xmax) < thrv); zeros(ymax-ymin+1,xmax-xmin+1)];
    recorte = imgaussfilt(recorte,2);
    
    % encontramos los circulos basados en la mitad superior de la subimagen
    %  de particula
    [centro, radio] = imfindcircles(recorte, [Rmin, Rmax], ...
        'ObjectPolarity','bright','Method','TwoStage');
    if isempty(centro)
        disp('no funciona porque la particula esta muy cerca del borde de la imagen:')
        disp([xoi yoi])
    else
    % armamos los arrays de resultados
    centros(ii,:) = [xoi+centro(1)-Wi-1, yoi+centro(2)-Hi-1];
    radios(ii)    = radio;
    end
end
toc

% visualizamos los resultados para comparar
imagesc(im1); hold on; colormap gray
viscircles(centros, radios,'LineStyle','--'); 
scatter(centros(:,1), centros(:,2),'rx');
% plot(centros(:,1), centros(:,2), 'w.','markersize',14);
hold off
axis equal




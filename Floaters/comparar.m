function []=comparar(direccion,dirparametros,xyzt)

load(dirparametros);
H = [xyzt(:,1:3)'; ones(1,size(xyzt,1))] ;

for camara=1:2
fondo          = dir([direccion,'Fondo blanco\*C',num2str(camara),'S0001.tif']);
fc(:,:,camara) = double(imread([direccion,'Fondo blanco\',fondo.name]));

flot{camara}  = dir([direccion, 'Floaters\*C',num2str(camara),'*.tif']);
    N(camara) = length(flot{camara});
    
    G(:,:,camara) = A(:,:,camara)*[R(:,:,camara), -R(:,:,camara)*T(camara,:)'];
    a(:,:,camara) = G(:,:,camara)*H ;
    a(:,:,camara) = a(:,:,camara)*diag((1./a(3,:, camara)));

end
frames = xyzt(:,4);


figure

for jj = 1:length(frames)
    for camara=1:2
    
    
    frame = frames(jj)
    flot{camara}(frame).name
    im = imread([direccion, 'Floaters\', flot{camara}(frame).name]);

    im1(:,:,camara) = double(im)- fc(:,:,camara);

    subplot(1,2,camara)
    imagesc(im1(:,:,camara))
    daspect([1 1 1])
    colormap gray
    hold on
    scatter(a(1,jj,camara),a(2,jj,camara),'rx')
    drawnow
    end
end
end
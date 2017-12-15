function [particulas, flot, frames, fc]=circulos(direccion)

for camara=1:2
fondo          = dir([direccion,'Fondo blanco\*C',num2str(camara),'S0001.tif']);
fc(:,:,camara) = double(imread([direccion,'Fondo blanco\',fondo.name]));

flot{camara}  = dir([direccion, 'Floaters\*C',num2str(camara),'*.tif']);
    N(camara) = length(flot{camara})
    
end
frames= min(N);

% figure
for jj=1:frames
    for camara=1:2
        
    particulas{jj,camara}=[];
    
    flot{camara}(jj).name
    im = imread([direccion, 'Floaters\', flot{camara}(jj).name]);

    im1(:,:,camara) = double(im)- fc(:,:,camara);
%     B=im1(:,:,camara);
%     A=im1(:,:,camara)>0;
%     B(A)=max(B(:));
%     im1(:,:,camara) = B;
    subplot(1,2,camara)
    imagesc(im1(:,:,camara))
    daspect([1 1 1])
    colorbar
    
    [centersDark, radiiDark] = imfindcircles(im1(:,:,camara),[10, 30],'ObjectPolarity','dark');
    hold on
    viscircles(centersDark, radiiDark,'Color','r');
    drawnow
    scatter(centersDark(:,1), centersDark(:,2), 'rx')
    particulas{jj,camara}= centersDark ;
    
    end
end
end
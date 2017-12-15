function [particulas, flot, frames, fc]=circulos2(direccion,graf, p)

for camara=1:2
fondo          = dir([direccion,'Fondo blanco\*C',num2str(camara),'S0001.tif']);
fc(:,:,camara) = double(imread([direccion,'Fondo blanco\',fondo.name]));

flot{camara}  = dir([direccion, 'Floaters\*C',num2str(camara),'*.tif']);
    N(camara) = length(flot{camara});
    
end
frames= min(N);

particulas=cell(frames,2);
% figure
%parfor jj=1:frames
for jj=1:frames
    im1=zeros(1024,1024,2);
    for camara=1:2
    
    particulas{jj,camara}=[];
    
    flot{camara}(jj).name
    im = imread([direccion, 'Floaters\', flot{camara}(jj).name]);

    im1(:,:,camara) = double(im)- fc(:,:,camara);
    
    if graf==1
    subplot(1,2,camara)
    imagesc(im1(:,:,camara))
    daspect([1 1 1])
    colormap gray
    colorbar
    end
    [centros, radios]=encontrarcentros(im1(:,:,camara));
    
    if graf==1
    hold on
    viscircles(centros, radios,'Color','r');
    drawnow
    scatter(centros(:,1), centros(:,2), 'rx')
    xlabel({'Pixels'},'FontSize', 16)
    ylabel({'Pixels '},'FontSize', 16)
    set(gca,'fontsize',16)
    if p==1
        pause
    end
    end
    
    particulas{jj,camara}= centros ;
    
    end
    
end
end
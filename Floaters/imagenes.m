function []=imagenes(particulas, flot, direccion, frames, fc)
for jj=1:frames
    for camara=1:2
        im = imread([direccion, 'Floaters\', flot{camara}(jj).name]);
        im1(:,:,camara) = double(im)- fc(:,:,camara);
        subplot(1,2,camara)
        imagesc(im1(:,:,camara))
        daspect([1 1 1])
        colorbar
        title(['Frame: ',num2str(jj)])
        hold on
        for ii=1:jj
            scatter(particulas{ii,camara}(:,1), particulas{ii,camara}(:,2), 'rx')
            hold on
            daspect([1 1 1])
        end
    end
    pause
end
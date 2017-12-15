function [candidatos1, candidatos2]=correspondencia(centros1,centros2, im1, dirparametros, graf)

Qi{1} = [centros1; ones(1,size(centros1,2))];
Qi{2} = [centros2; ones(1,size(centros2,2))];
Lx=1024;

camaras=2;

if length(im1)>1
    figure; 
    subplot(1,2,1); imagesc(im1(:,:,1))
    colormap gray
    daspect([1,1,1])
    hold on
    title('Camara 1')

    subplot(1,2,2); imagesc(im1(:,:,2))
    colormap gray
    daspect([1,1,1])
    hold on
    title('Camara 2')

    % figure(3); imshow(J(:,:,3))
    % hold on
    % title('Camara 3')
end

%for kk=1:camaras
    %for jj=(kk+1):camaras
        kk = 1;
        jj = 2;
        dircodigo = cd;
        load(dirparametros)
        cd(dircodigo)
        [ F ] = matrizfundamental( R, T, A, kk, jj ) ;

        candidatos1=[];
        
        if graf==1
            subplot(1,2,kk)
            Qi{kk}
            hold on
            scatter(Qi{kk}(1,:), Qi{kk}(2,:),'bo')
            hold on
            daspect([1,1,1])
            axis([0 1024 0 1024])
        end
        
        for ii=1:size(Qi{jj},2)
           
            u1 = (Qi{jj}(:,ii))' *F;
            x1 = 1:(Lx+1);
            y1 = (-u1(3)-u1(1)*x1)/(u1(2));
            candidatos1{ii} = encontrarcandidatos(Qi{kk},x1, y1);
            
            if graf==1
                subplot(1,2,kk)
                plot(x1, y1,'Color','r')
                hold on
                if length(candidatos1{ii})>0
                    scatter(candidatos1{ii}(:,1), candidatos1{ii}(:,2),'gx')
                    text(candidatos1{ii}(:,1),candidatos1{ii}(:,2),num2str(ii),'Color','blue','FontSize',14);
                end
                subplot(1,2,jj)
                text(Qi{jj}(1,ii),Qi{jj}(2,ii),num2str(ii),'Color','blue','FontSize',14);
                pause
            end
            
        end

        candidatos2=[];
        if graf==1
            subplot(1,2,jj)
            hold on
            scatter(Qi{jj}(1,:), Qi{jj}(2,:),'ro')
            hold on
            daspect([1,1,1])
            axis([0 1024 0 1024])
        end

        for ii=1:size(Qi{kk},2)
            u2 = F*(Qi{kk}(:,ii));
            x2 = 1:(Lx+1);
            y2 = (-u2(3)-u2(1)*x2)/(u2(2));
            candidatos2{ii} = encontrarcandidatos(Qi{jj},x2, y2);
            
            if graf==1
                subplot(1,2,jj)
                plot(x2, y2,'Color','b')
                ii
                (candidatos2{ii})
                if length(candidatos2{ii})>0
                    scatter(candidatos2{ii}(:,1), candidatos2{ii}(:,2), 'gx')
                    text(candidatos2{ii}(:,1),candidatos2{ii}(:,2),num2str(ii),'Color','magenta','FontSize',14);
                end
                subplot(1,2,kk)
                text(Qi{kk}(1,ii),Qi{kk}(2,ii),num2str(ii),'Color','magenta','FontSize',14);
                pause
            end

        end
end
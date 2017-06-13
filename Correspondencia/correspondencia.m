close all
clear Qi
Qi(:,:,1)=[centros(:,:,1); ones(1,size(centros,2))];
Qi(:,:,2)=[centros(:,:,2); ones(1,size(centros,2))];
Lx=1024;

camaras=2;
close all
figure(1); imagesc(im1(:,:,1))
daspect([1,1,1])
hold on
title('Camara 1')

figure(2); imagesc(im1(:,:,2))
daspect([1,1,1])
hold on
title('Camara 2')

% figure(3); imshow(J(:,:,3))
% hold on
% title('Camara 3')


%for kk=1:camaras
    %for jj=(kk+1):camaras
        kk=1;
        jj=2;
        dircodigo=cd;
        load(dirparametros)
        cd(dircodigo)
        [ F ] = matrizfundamental( R, T, A, kk, jj )

        %r1=rand(1,3);
        candidatos=[];
        
        for ii=1:size(Qi,2)
            Qi(:,ii,jj)'
            u1 = (Qi(:,ii,jj)')*F;
            x1 = 1:(Lx+1);
            y1 = (-u1(3)-u1(1)*x1)/(u1(2));
            figure(kk)
            plot(x1, y1,'Color','r')
            
            candidatos(:,:,ii) = encontrarcandidatos(Qi(:,:,kk),x1, y1);
        end

        %r2=rand(1,3);
        candidatos=[];
        
        for ii=1:size(Qi,2)
            
            u2 = F*(Qi(:,ii,kk));
            x2 = 1:(Lx+1);
            y2 = (-u2(3)-u2(1)*x2)/(u2(2));
            
            figure(jj)
            plot(x2, y2,'Color','b')
            
            candidatos(:,:,ii) = encontrarcandidatos(Qi(:,:,jj),x2, y2);

        end
        
    %end
%end
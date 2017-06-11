clear all
close all

Lx = 1024;
Ly = 1024;
% Lz = 50;
pasos = 1;
lado=25.4;
n=9;
m=6;

dirimagenes = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\07-06-2017';
dircodigos  = 'C:\Users\Nicolás\Desktop\Labo 6\Codigo\Simulacion\Simulación- 26-05-17';
[ R, T, A, k, imagenescomun(:,:,1), imagenescomun(:,:,2), M1, M2, sx, sy ] = cargar( dirimagenes, dircodigos );

cd(dirimagenes)
char(M1(1:(end-4)))
char(M2(1:(end-4)))
im(:,:,1) = imread([dirimagenes,'\Damero\',char(M1(1:(end-4)))]);
im(:,:,2) = imread([dirimagenes,'\Damero\',char(M2(1:(end-4)))]);

cd(dircodigos)

[y, x] = meshgrid(1:m,1:n);
     H = lado*[x(:)'-round(n/2);y(:)'-round(m/2)]; % X,Y,Z en columna vertical, cada columna es una partícula
     H = [H; zeros(1,size(H,2))];
% figure
% subplot(1,3,1);
%[ I ] = mundo2d( Lx, Ly, pasos, H(1,:,:), H(2,:,:) );

C = zeros([Lx, Ly, 1, 2]);

for ll=1:2 %Camaras
    for kk=1:size(C,3) %fotogramas

          G = A(:,:,ll)*[R(:,:,ll), -R(:,:,ll)*T(ll,:)'];
        Vi1 = G*[H(:,:,kk); ones(1,size(H,2))];
        Vi1 = Vi1*diag((1./Vi1(3,:)));
        [ Vi(:,:,kk,ll), ~ ] = distorsionar2( H(:,:,kk), Vi1, k(ll, :), A(:,:,ll), R(:,:,ll), -R(:,:,ll)*T(ll,:)'  );

        for ii=1:size(Vi,2)

                xi = round(Vi(1,ii, kk, ll));
                yi = round(Vi(2,ii, kk, ll));
                if xi>0 && xi<=size(C,2) && yi>=0 && yi<size(C,1)
                        C(yi, xi, kk, ll) = 1;
                end

        end
        J(:,:,ll) = imdilate(C(:,:,kk, ll),[0,1,0;1,1,1;0,1,0]);
%         subplot(1,3,ll+1);
%         pcolor(J(:,:,ll))
%         colormap gray
%         shading flat
%         daspect([1 1 1])
%         title(['Particulas Proyectadas, Cámara ',num2str(ll), ' t=',num2str(kk)])
%         pause(0.01)
    end
end

% figure
for ll=1:2
    escena( Vi(:,:,pasos,ll), A(:,:,ll), sx(ll), sy(ll), R(:,:,ll), (-R(:,:,ll)*T(ll,:)')', Lx, Ly, H(:,:,pasos), im(:,:,ll)); %J(:,:,ll) );
end

clear a b c E F ii jj kk ll xi yi Vw

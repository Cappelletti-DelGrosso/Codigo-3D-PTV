function [X, N, errorplano, bien] = pruebaerrores(direccion)

dircodigos=cd;
cd(direccion)
load('Parámetros Montaje Completo')
imagenescomun(:,:,1)=J1;
imagenescomun(:,:,2)=J2;
clear J1 J2

lado=25.4;
n=9;
m=6;
[y, x] = meshgrid(1:m,1:n);
     H = lado*[x(:)'-round(n/2);y(:)'-round(m/2)]; % X,Y,Z en columna vertical, cada columna es una partícula
     H = [H; zeros(1,size(H,2))];
     
     
     %%%%%%%%%Prueba distorsion
%      cd(dircodigos)
%      for camara=1:2
%         [~, xd(:,:,camara), yd(:,:,camara), xu(:,:,camara), yu(:,:,camara)] = desdistorsionar3( zeros(1024,1024), [A(1,1,camara), A(2,2,camara)], [[A(1,3,camara), A(2,3,camara)]], [k(camara,:),0], [0,0], 'lineal');
%      end   
%      
     %%%%%%%%%

for camara = 1:2
    cd([direccion, '\Puntos', num2str(camara)])
%     xdc=xd(:,:,camara);
%     ydc=yd(:,:,camara);
%     xuc=xu(:,:,camara);
%     yuc=yu(:,:,camara);
    for ii=1:size(imagenescomun,1)
%         char(imagenescomun(ii,:,camara))
        B                 = dlmread(char(imagenescomun(ii,:,camara)),';',1,0); %Cargo las imagenes en comun
        Wi(:,:,ii,camara) = [B'; ones(1,size(B,1))];
        %%%%%%
% %          
%         for jj=1:size(Wi, 2)
%             [~, id] = min((xdc(:)-Wi(1,jj,ii,camara)).^2 + (ydc(:)-Wi(2,jj,ii,camara)).^2) ;
%             Widd(1:2,jj,ii,camara) = [xuc(id), yuc(id)];
%         end  
%         
        %%%%%%
    end
    cd(dircodigos)
end

%%%%%
% Wi=Widd;
%%%%%
errores=[];
errorplano=[];
for ii=1:size(imagenescomun,1)
    inter=[];
    
    for jj=1:size(Wi,2)

    [ vw, error ] = triangular2( R, T, A, sx, sy, Wi(1,jj,ii,1), Wi(2,jj,ii,1), Wi(1,jj,ii,2), Wi(2,jj,ii,2)  );
    inter = [inter, vw];
    end

    X=reshape(inter(1,:),9,6)';
    Y=reshape(inter(2,:),9,6)';
    [f, G] = fit( [inter(1,:)', inter(2,:)'], inter(3,:)', 'poly11' );
    errorplano= [errorplano; sqrt(G.sse/54)];
    sqrt(G.sse/54)
    
%     figure
%     scatter3(inter(1,:), inter(2,:),inter(3,:), 'ro ')
%     hold on
%     surf(X,Y,f(X, Y))
%     daspect([1,1,1])
    
    errores(:,ii)=(((sum((inter-inter(:,23)).^2)).^0.5)'-((sum((H-H(:,23)).^2)).^0.5)');%./(((sum((H-H(:,1)).^2)).^0.5)');*100
%     figure
%     hist(errores(:,ii)) %Grafico un histograma de sus errores, este está desplazado por el error del punto 0
%     figure
%     plot(errores(:,ii))
end

disp(['Imagenes en común: ',num2str(size(imagenescomun,1))])

numeros=1:(length(errorplano));
if max(errorplano)>1
    disp(['Los siguientes planos están mal numerados: ', num2str(numeros(errorplano>1))]) 
end

bien = numeros(errorplano<1);

errores2=errores(:,bien);%-mean(errores(2:end,:));  %Llevo los histogramas al 0 para independizarme del punto 0 de cada uno
errores2=errores2(2:end,:);
errores2=errores2(:);

[X,N]=hist(errores2, sqrt(length(errores2))/2);

figure
plot(N, X/sum(X))

disp(['Error relativo al plano: ',num2str(mean(errorplano(bien))),' mm'])

disp(['Error relativo entre puntos del plano: ',num2str(std(errores2)),' mm'])


figure
hist(errorplano, sqrt(length(errorplano)))
end
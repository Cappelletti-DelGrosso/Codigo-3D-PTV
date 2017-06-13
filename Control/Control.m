dirimagenes='C:\Users\Nicol�s\Desktop\Labo 6\Mediciones\09-06-17\';
dircodigos='C:\Users\Nicol�s\Desktop\Labo 6\Codigo\Simulacion\Simulaci�n- 26-05-17';


for camara = 1:2
    cd([dirimagenes, '\Puntos', num2str(camara)])
    puntos = dir([dirimagenes, '\Puntos', num2str(camara),'\*C',num2str(camara),'S0001.tif.csv']);
    Npuntos=length(puntos);

    for ii=1:Npuntos
        B                 = dlmread(puntos(ii).name,';',1,0); %Cargo las imagenes en comun
        Wi(:,:,ii,camara) = [B'; ones(1,size(B,1))];
    end
    cd(dircodigos)
end

errores=[];
for ii=1:Npuntos
    inter=[];
    
    for jj=1:size(Wi,2)

    [ vw, error ] = triangular2( R, T, A, sx, sy, Wi(1,jj,ii,1), Wi(2,jj,ii,1), Wi(1,jj,ii,2), Wi(2,jj,ii,2)  );
    inter=[inter, vw];
    end
    
    X=reshape(inter(1,:),9,6)';
    Y=reshape(inter(2,:),9,6)';
    [f, G] = fit( [inter(1,:)', inter(2,:)'], inter(3,:)', 'poly11' );
    errorplano= [errorplano; G.sse];
    sqrt(G.sse)/54
    
    figure
    scatter3(inter(1,:), inter(2,:),inter(3,:), 'ro ')
    hold on
    surf(X,Y,f(X, Y))
    daspect([1,1,1])

    errores(:,ii)=(((sum((inter-inter(:,23)).^2)).^0.5)'-((sum((H-H(:,23)).^2)).^0.5)');%./(((sum((H-H(:,1)).^2)).^0.5)');*100
    figure
    hist(errores(:,ii)) %Grafico un histograma de sus errores, este est� desplazado por el error del punto 0

end
function [ uv2, kn ] = distorsionar2( H, Vi, k, A2, R2, T2  )

u0 =A2(1,3);
v0 =A2(2,3);
 d =[];
 D =[];
 M = size(Vi,2);
 N = size(Vi,3);
for jj=1:N
      uv(:,:,jj) = A2*[R2(:,:,jj),T2(:,jj)]*[H(1:2,:); zeros(1,size(H,2));ones(1,size(H,2))]; %uso las matrices de proyeccion que obtuve para encontrar los u, v ideales
      uv(:,:,jj) = uv(:,:,jj)*diag((1./uv(3,:,jj)));
     muv = mean(uv(:,:,jj), 2);
   disuv = std(uv(:,:,jj), 1, 2);
      Tn = [1/disuv(1), 0, -muv(1)/disuv(1); 0, 1/disuv(2), -muv(2)/disuv(2); 0,0,1];  %Matrices de normalización
      xy = Tn*uv(:,:,jj);                %Normalizamos los vectores, a media 0 y dispersión 1
       d = [d; reshape(Vi(1:2,:, jj)-uv(1:2,:, jj), 2*size(uv,2),1)];
    unos = ones(1,M);
     dif = uv(1:2,:, jj)-[u0*unos; v0*unos];
     dif = reshape(dif(1:2,:), size(dif,2)*2,1);
    for kk=1:M
        norma(kk) = (norm(xy(1:2,kk)))^2;
    end
	norma2 = norma.^2;
    norma3 = reshape([norma; norma], length(norma)*2, 1);
    norma4 = reshape([norma2; norma2], length(norma2)*2, 1);
         D = [D; dif.*norma3, dif.*norma4];
         
end

kn= inv(D'*D)*D'*d;

uv2=uv(1:2,:,:)+reshape(D*k',2,M, N);

end

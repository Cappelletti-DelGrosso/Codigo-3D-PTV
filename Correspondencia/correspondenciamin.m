function [e12, e21]=correspondenciamin(centros1,centros2, R, T, A, Lx)

Qi{1} = [centros1; ones(1,size(centros1,2))];
Qi{2} = [centros2; ones(1,size(centros2,2))];
% Lx=201;

camaras=2;

kk = 1;
jj = 2;
[ F ] = matrizfundamental( R, T, A, kk, jj ) ;  

for ii=1:size(Qi{jj},2)

    u1 = (Qi{jj}(:,ii))' *F;
    x1 = 1:(Lx+1);
    y1 = (-u1(3)-u1(1)*x1)/(u1(2));
    [~, e12(ii)]= encontrarcandidatos2(Qi{kk},x1, y1);

end

for ii=1:size(Qi{kk},2)
    u2 = F*(Qi{kk}(:,ii));
    x2 = 1:(Lx+1);
    y2 = (-u2(3)-u2(1)*x2)/(u2(2));
    [~, e21(ii)]= encontrarcandidatos2(Qi{jj},x2, y2);
end

end
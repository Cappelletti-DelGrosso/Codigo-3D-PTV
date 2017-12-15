function [tXYZf, UVWf, ABCf]=FiltrarTrayectoria2(tXYZ, W)
if mod(W,2)==1,
    error('The second argument to the function must be an even integer.');
    return
end

L = size(tXYZ,1);

tXYZf = zeros(L-W,3);
 UVWf = zeros(L-W,3);
 ABCf = zeros(L-W,3);

tXYZf(:,1) = tXYZ((W/2+1):(end-(W/2)),1);

for jj = 1:(L-W)
    t = tXYZ(jj:(jj+W),1);
    for ii = 1:3
        x = tXYZ(jj:(jj+W),ii+1);
        [xf, uf, af] = coeficientes(x, t);
        tXYZf(jj,ii+1) = xf ; 
         UVWf(jj,ii) = uf ;
         ABCf(jj,ii) = af ;
    end
end
end
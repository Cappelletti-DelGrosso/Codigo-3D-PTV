function [ G ] = dsvd2( H, Vi )

u=[];

for ii=1:size(H,2)
    u=[u; H(:,ii)', zeros(1,3), (-H(:,ii)'*Vi(1,ii)); zeros(1,3), H(:,ii)', (-H(:,ii)'*Vi(2,ii)) ];
end

[U,S,V] = svd(u);
g=V(:,9);
G=[g(1:3)'; g(4:6)'; g(7:9)'];

end


function F = myfun2(x, Qw, Qi)

H=[x(1:3); x(4:6); x(7:9)]; %9componentes
a = H*Qw; %misombrero sin normalizar
a = a*diag((1./a(3,:)));
f= a(1:2,:)- Qi(1:2,:);
F= reshape(f, 2*size(Qw,2),1);
end

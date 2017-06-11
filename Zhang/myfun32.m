function F = myfun32(x, H, Vi)

x = [x(1:5),nan; (reshape(x(6:end),6 ,(length(x)-5)/6))'];
H = [H(1:2,:);zeros(1,size(H,2)); ones(1,size(H,2))];
N = size(Vi,3);
A = [x(1,1), x(1,5), x(1,3);0, x(1,2), x(1,4); 0,0,1];
F = [];
for jj=1:N
    k = [x(jj+1,1), x(jj+1,2), x(jj+1,3)]';
    R = vecarot(k);
    T = [x(jj+1,4), x(jj+1,5), x(jj+1,6)]';
    G = A*[R, T];
    a = G*H;
    a = a*diag((1./a(3,:)));
    f = a(1:2,:)-Vi(1:2,:,jj);
    F = [F; reshape(f, 2*size(H,2),1)];
end 

end
function F = myfun42(x, H, Vi)
k = [x(1), x(2)];
x = [x(3:7),nan; (reshape(x(8:end),6 ,(length(x)-7)/6))'];
H = [H(1:2,:);zeros(1,size(H,2)); ones(1,size(H,2))];
N = size(Vi,3);
A = [x(1,1), x(1,5), x(1,3);0, x(1,2), x(1,4); 0,0,1];
F = [];
for jj=1:N
    v = [x(jj+1,1), x(jj+1,2), x(jj+1,3)]';
    R = vecarot(v);
    T = [x(jj+1,4), x(jj+1,5), x(jj+1,6)]';
    G = A*[R, T];
    a = G*H;
    a = a*diag((1./a(3,:)));
    [ uv2, kn ] = distorsionar2( H, a, k, A, R, T  );
    a = uv2;
    f = a(1:2,:)-Vi(1:2,:,jj);
    F = [F; reshape(f, 2*size(H,2),1)];
end 

end
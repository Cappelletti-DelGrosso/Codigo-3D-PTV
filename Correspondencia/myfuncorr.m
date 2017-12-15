function F = myfuncorr(x, Wi)
for ii=1:2
A(:,:,ii) = [x(1+5*(ii-1)), x(5+5*(ii-1)), x(3+5*(ii-1));0, x(2+5*(ii-1)), x(4+5*(ii-1)); 0,0,1] ;
end

k1 = [x(11),x(12),x(13)];
R(:,:,1) = vecarot(k1);
T(1,:) = [x(14), x(15), x(16)]';
k2 = [x(17),x(18),x(19)];
R(:,:,2) = vecarot(k2);
T(2,:) = [x(20), x(21), x(22)]';

for kk=1:size(Wi,3)
    for jj=1:size(Wi,2)
        [f12(jj,kk), f21(jj,kk)] = correspondenciamin(Wi(1:2,jj,kk,1),Wi(1:2,jj,kk,2), R,T,A,1024);
    end
end
F = [f12(:), f21(:)];
end
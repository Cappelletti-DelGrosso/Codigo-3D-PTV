function [ vw, error ] = triangular2( R, T, K, sx, sy, xi1, yi1, xi2, yi2  )

f(1)     = ( K(1,1,1)*sx(1) + K(2,2,1)*sy(1) )/2;
f(2)     = ( K(1,1,2)*sx(2) + K(2,2,2)*sy(2) )/2;

R1 = R(:,:,1);
T1 = (-R(:,:,1)* T(1,:)')';

p1 = inv(K(:,:,1))*[xi1, yi1, 1]'*f(1);
%p1 = [sx(1)*xi1, sy(1)*yi1, f(1)]';

R2 = R(:,:,2);
T2 = (-R(:,:,2)*T(2,:)')';

p2 = inv(K(:,:,2))*[xi2, yi2, 1]'*f(2);
%p2 = [sx(2)*xi2, sy(2)*yi2, f(2)]';

Rc = R2*R1';
Tc = T1'-Rc'*T2';
a = p1/norm(p1);
b = (-Rc'*p2)/norm(-Rc'*p2);
c = cross(p1,Rc'*p2)/norm(cross(p1,Rc'*p2));

A = [a,b,c];
B = inv(A)*Tc;

vc = B(1)*a+B(3)*c/2;
vw = R1'*(vc-T1');
error=B(3);
end

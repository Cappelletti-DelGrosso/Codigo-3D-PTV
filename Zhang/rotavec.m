function [k] = rotavec(R1)
[U,S,V] = svd(R1-eye(3));
k = V(:,3)/norm(V(:,3));%*sign(V(2,3)); %antes decia k= abs(V(:,3))/norm(V(:,3))
w = k+[1, 2 , 3]';
w = w/norm(w);
w = w-(k'*w)*k;
w = w/norm(w);
z = cross((R1*w), w);

for ii=1:3
    if abs(k(ii))>0.001 
        t = z(ii)/k(ii);
    end
end

r = (R1*w)'*w; %w'*(R1*w)

if abs(r)>0.999999
    k = [0,0,0]';
else

k = k*(acos(r)*sign(-t)+pi*(1-sign(-t)));
end
end
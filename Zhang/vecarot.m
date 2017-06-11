function [R1] = vecarot(k)
theta = norm(k);
if theta==0
    R1=eye(3);
else
k = k/theta;
K=[0, -k(3), k(2); k(3), 0 , -k(1); -k(2), k(1), 0];
R1 = eye(3)+sin(theta)*K+(1-cos(theta))*K^2;
end
end
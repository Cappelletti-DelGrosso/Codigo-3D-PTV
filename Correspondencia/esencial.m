function [ E ] = esencial( R1, R2, T1, T2)

Rc = R2*R1';
Tc = T1-Rc'*T2;

S= [0, -Tc(3), Tc(2); Tc(3), 0, -Tc(1); -Tc(2), Tc(1), 0];

E= Rc*S;
end

function [ F ] = fundamentalmatrix( E, M1, M2 )

%M1 y M2 son las matrices de parametros intrinsecos de cada camara
%NO CONFUNDIR CON LA M=Mint*Me
%F=M1^(-t)*E*M2^(-1)

Y=inv(M2)' ;
X=inv(M1)  ;

F= Y*E*X;

end


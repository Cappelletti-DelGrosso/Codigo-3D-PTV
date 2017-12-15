function [ F ] = matrizfundamental2( R, T, A, i, j )

R1 = R(:,:,i) ;
R2 = R(:,:,j) ;

T1 = -R1*T(i,:)'  ;
T2 = -R2*T(j,:)'  ;

M1 = A(:,:,i) ;
M2 = A(:,:,j) ;

[ E ] = esencial( R1, R2, T1, T2) ;

[ F ] = fundamentalmatrix2( E, M1, M2 ) ;

end
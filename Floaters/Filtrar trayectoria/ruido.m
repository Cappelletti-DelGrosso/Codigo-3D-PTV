function [r]=ruido(f1,f2, df)
% df = 0.001 ;
% f1 = 2 ;
% f2 = 4 ;
% 2*f2/df+1=length(r)

F = [-f2:df:f2] ;
N = (f2-f1)/df ;
A = zeros(size(F)) ;
A((end-N+1):end) = 1 ; 
A(1:N) = 1 ; 
theta0 = (rand(size(F))*2*pi-pi).*A ;
aux = [1:N];
aux =  sort(aux, 'descend');
theta0((end-N+1):end) = -theta0(aux) ;
M = (length(F)+1)/2 ;
A = [A(M:end), A(1:(M-1))] ;
theta = [theta0(M:end), theta0(1:(M-1))]; 
z = A.*(exp(i*theta));
r = real(ifft(z));
w=fft(r);
w(abs(w)<1E-10)=0;
r = r/std(r);
% figure; plot(F(end-M+1:end), abs(w(1:M)))
% figure; plot(F(end-M+1:end), angle(w(1:M)))
end
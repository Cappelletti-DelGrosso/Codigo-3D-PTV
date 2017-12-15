function [r]=ruido2(f1,f2, f)
% df = 0.001 ;
% f1 = 2 ;
% f2 = 4 ;
% 2*f2/df+1=length(r)

F = [sort(-f(2:end)), f] ;
A = zeros(size(F)) ;
A(and((F>=f1) , (F<=f2))) = 1 ; 
A(and((F<= -f1) , (F>=-f2))) = 1 ; 
theta0 = (rand(size(F))*2*pi-pi).*A ;
N = (length(F)+1)/2 ;
aux = [1:N];
aux =  sort(aux, 'descend');
theta0((end-N+1):end) = -theta0(aux) ;
A = [A(N:end), A(1:(N-1))] ;
theta = [theta0(N:end), theta0(1:(N-1))]; 
z = A.*(exp(i*theta));
r = real(ifft(z));
w=fft(r);
w(abs(w)<1E-10)=0;
r = r/std(r);
% figure; plot(F(end-N+1:end), abs(w(1:N)))
% figure; plot(F(end-N+1:end), angle(w(1:N)))
end
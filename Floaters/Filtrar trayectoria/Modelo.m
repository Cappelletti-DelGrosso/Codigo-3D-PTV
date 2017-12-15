clear all
close all

x=0;
T=1E5;
for ii=1:T
    p=0.5*exp(-abs(x(ii))^2/(2*2.6));
    q=rand(1);
    if p>q
        if x(ii)==0
            x=[x, x(ii)+abs(randn(1)/1.3)];
        else
            x=[x, x(ii)+sign(x(ii))*abs(randn(1)/1.3)];
        end
    else
        if x(ii)==0
            x=[x, x(ii)-abs(randn(1)/1.3)];
        else
            x=[x, x(ii)-sign(x(ii))*abs(randn(1)/1.3)];
        end
    end
end

v = diff(x);
a = diff(v);

x = (x-mean(x))/std(x);
v = (v-mean(v))/std(v);
a = (a-mean(a))/std(a);

[PDFX, X] = hist(x, sqrt(length(x))/2);
[PDFV, V] = hist(v, sqrt(length(v))/2);
[PDFA, A] = hist(a, sqrt(length(a))/2);


DX    = diff(X);
sx    = sum(DX.*PDFX(1:(end-1)));
PDFX = PDFX/sx;                 %Normalizo a área 1

DV    = diff(V);
sv    = sum(DV.*PDFV(1:(end-1)));
PDFV = PDFV/sv;                 %Normalizo a área 1

DA    = diff(A);
sa    = sum(DA.*PDFA(1:(end-1)));
PDFA = PDFA/sa;                 %Normalizo a área 1

a1= 1/sqrt(2*pi);
b1=0;
c1=sqrt(2);

figure;
subplot(1,3,1)
semilogy(X, PDFX,'bo'); hold on
semilogy(X, a1*exp(-((X-b1)/c1).^2),'Color','k', 'LineWidth', 3)
title('PDF posición')

subplot(1,3,2)
semilogy(V, PDFV,'ro'); hold on
semilogy(V, a1*exp(-((V-b1)/c1).^2),'Color','k', 'LineWidth', 3)
title('PDF velocidad')

subplot(1,3,3)
semilogy(A, PDFA,'go'); hold on
semilogy(A, a1*exp(-((A-b1)/c1).^2),'Color','k', 'LineWidth', 3)
title('PDF aceleración')

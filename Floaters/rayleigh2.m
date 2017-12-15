frecuencia=120;
desp=[];
for kk = 1:length(curvas)
    desp=[desp; sum(((curvas{kk}.v)/frecuencia).^2,2)];
end

[PDFSALT,SALT]=hist(desp, sqrt(length(desp))*20)
 DSALT    = diff(SALT);
    ssalt    = sum(DSALT.*PDFSALT(1:(end-1)));
    PDFSALT = PDFSALT(1:(end))/ssalt;   
    SALT=SALT(1:(end));

    figure; plot(SALT,PDFSALT,'bo-')
figure; semilogy(SALT,PDFSALT)
[fitresult, gof] = rayleigh(SALT, PDFSALT)
figure; semilogy(SALT,PDFSALT)



[PDFSALT,SALT]=hist(saltos, sqrt(length(saltos))/8)
 DSALT    = diff(SALT);
    ssalt    = sum(DSALT.*PDFSALT(1:(end-1)));
    PDFSALT = PDFSALT(1:(end))/ssalt;   
    SALT=SALT(1:(end));

    figure; plot(SALT,PDFSALT,'bo-')
figure; semilogy(SALT,PDFSALT,'bo-')
[fitresult, gof] = rayleigh(SALT, PDFSALT)

% f(x) = 
% Coefficients (with 95% confidence bounds):
%        a1 =   4.568e+08  
%        b1 =      -18.51 
%        c1 =       4.289 
      a1 =        0.41  
       b1 =     0.07743 
       c1 =       2.119  

       hold on; semilogy(SALT,a1*SALT.*exp(-((SALT-b1)/c1).^2),'r')


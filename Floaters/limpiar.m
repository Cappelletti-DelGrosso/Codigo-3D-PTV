function [curva2,limited, limitei ]=limpiar(curva)
%amano=240
Z = [];
for ii = 1:length(curva)
    Z = [Z; curva{ii}(:,4)];
end
 [PDFZ, BZ] = hist(Z,sqrt(length(Z))/2);

[MZ, idmz] = max(PDFZ);

% candidatos = PDFZ<MZ/amano;
candidatos=[];
for kk=2:(length(PDFZ)-1)
    if and(PDFZ(kk)<=PDFZ(kk-1),PDFZ(kk)<=PDFZ(kk+1) )
    candidatos=[candidatos; kk];
    end
end
aux = BZ(idmz)-BZ(candidatos);
auxi = aux;
auxi(auxi<0) = nan;
auxd = aux;
auxd(auxd>0) = nan;

[mi, idi] = min(auxi);
[md, idd] = min(-auxd);

aux2=BZ(candidatos);
limitei = aux2(idi);
limited = aux2(idd);
limited 
limitei 

cont = 0;
for ii=1:length(curva)
    M  = max((curva{ii}));
    mi = min((curva{ii}));
    if and(M(4)<limited, mi(4)> limitei)
        cont=cont+1;
        curva2{cont}=curva{ii};
    end
end

end
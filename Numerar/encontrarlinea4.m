function [linea, J]=encontrarlinea4(p1, p2, Vi)

t = (1:1024)/1024;
segmento = p1'*(1-t)+ p2'*t;
linea = [];
J=[];
for jj=1:length(Vi)
    dist = sum(sqrt((segmento-Vi(jj,:)').^2));
    d = min(dist);
    if d<10
       linea = [linea, Vi(jj,:)'] ;
       J=[J, 0];
    else
       J=[J, 1];
    end
     
end
dist2 = sum(sqrt((linea-p1').^2));
[~, I]=sort(dist2);
linea=linea(:,I);
end
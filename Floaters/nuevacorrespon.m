%Tengo trayectoria1 y trayectoria2, hago correspondencia y triangulo
function [curva, resultados]=nuevacorrespon(trayectorias, dirparametros, F)

N=size(trayectorias,1)
resultados=[];
a=0;
dirfloaters    = cd;
% dirparametros='C:\Users\Nicolás\Desktop\simulacionrankine\Parámetros Montaje Completo';
for ii = 1:N
    for kk = 1:N
        ii
        kk
        if length(trayectorias{ii,1})>0 && length(trayectorias{kk,2})>0 
            trayectoria1 = trayectorias{ii,1};
            trayectoria2 = trayectorias{kk,2};

            principio1 = trayectoria1(1,3) ;
            principio2 = trayectoria2(1,3) ;
            final1     = trayectoria1(end,3) ;
            final2     = trayectoria2(end,3) ;

            if or(and(principio1<=principio2,principio2<=final1), and(principio1<=final2,final2<=final1))
                m = max(principio1, principio2) ;
                M = min(final1, final2) ;

                i1           = and(trayectoria1(:,3)>=m, trayectoria1(:,3)<=M) ;
                i2           = and(trayectoria2(:,3)>=m, trayectoria2(:,3)<=M) ;
                trayectoria1 = (trayectoria1(i1,1:2))' ;
                trayectoria2 = (trayectoria2(i2,1:2))' ;

                C=[];
                for jj = 1:(M-m+1)
                    cd ..
                    cd('Correspondencia')
                    [candidatos1, candidatos2,~,~]=nuevacorrespondencia2(trayectoria1(:,jj),trayectoria2(:,jj), 0, F, 0);
                    C=[C; length(candidatos1{1})==2, length(candidatos2{1})==2];
                end
%                 size(C)
%                 M-m+1
%                 sum(C)
                porcentaje = mean(sum(C))/(M-m+1)*100;
                resultados = [resultados; porcentaje, ii, kk, m, M] ;
                if porcentaje > 90
                    a=a+1;
                    curva{a}=[];
                    load(dirparametros)
                    for jj = 1:(M-m+1)
                    [ vw, error ] = triangular2( R, T, A, sx, sy, trayectoria1(1,jj), trayectoria1(2,jj), trayectoria2(1,jj), trayectoria2(2,jj)  );
                    curva{a}=[curva{a}; vw',m+jj-1];
                    end
                end
            end
        end
    end
end

end
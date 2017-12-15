function [R2,t,cont]=R2b(curva, largo,graf)
cont=0;
for kk=1:length(curva)
    kk
    if size(curva{kk},1)>largo-1
        flag=kk;
        cont=cont+1;
        R(cont, :)=sum((curva{kk}(1:largo,2:4)-curva{kk}(1,2:4))'.^2);
    end
end

R2 = mean(R) ;
s = std(R)   ;
t=(curva{flag}(1:largo,1)-curva{flag}(1,1));
if graf==1
    figure; loglog(t,R2,'o')
% figure; loglog(curva4{1}(1:50,1),R2,'o')

    xlabel({'Tiempo [s]'},'FontSize', 16)
    ylabel({'Distancia Cuadrática Media [mm^2]'},'FontSize', 16)
    set(gca,'fontsize',16)
end
end
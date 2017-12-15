% for kk=1:length(curva3)
%     kk
%     R(kk, :)=sum((curva3{kk}(1:25,:)-curva3{kk}(1,:))'.^2);
% end

for kk=1:length(curva4)
    kk
    R(kk, :)=sum((curva4{kk}(1:50,2:4)-curva4{kk}(1,2:4))'.^2);
end

R2 = mean(R) ;
s = std(R)   ;

figure; loglog((curva4{1}(1:50,1)-curva4{1}(1,1)),R2,'o')
% figure; loglog(curva4{1}(1:50,1),R2,'o')

    xlabel({'Tiempo [s]'},'FontSize', 16)
    ylabel({'Distancia Cuadrática Media [mm^2]'},'FontSize', 16)
    set(gca,'fontsize',16)

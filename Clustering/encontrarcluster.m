function [cluster, clusterid]=encontrarcluster(puntos, tri2, areas, Ac, plot_flag, ncurva)
% plot(puntos(:,1), puntos(:,2),'ro');
if plot_flag==1
    
    figure(1)
    clf
    triplot(tri2,puntos(:,1),puntos(:,2)); hold on;
    scatter(puntos(:,1),puntos(:,2),'ko','filled')
    daspect([1 1 1])
    grid on
    axis([-350 350 -200 300])
    xlabel('Pixels')
    ylabel('Pixels')
    set(gca,'fontsize',16)
    figure(2)
    clf
    triplot(tri2,puntos(:,1),puntos(:,2)); hold on;
end
candidatos = areas < Ac ;
aux = tri2(candidatos,:);

cont = 0;
while(size(aux,1)>0)
    cont = cont+1;
    cluster{cont}= aux(1, :);
    cont2 = 0;
    while( cont2+1 <= size(cluster{cont}, 1) )
        cont2 = cont2 + 1;
        size(cluster{cont}, 1);
        for ii=1:3
            mismocluster = sum((aux-cluster{cont}(cont2, ii))==0, 2) > 0 ;
            cluster{cont} = [ cluster{cont}; aux(mismocluster, :) ] ;
            aux(mismocluster, :) = [];
        end
    end
    sz = 30;
    
    if plot_flag==1
        figure(2)
        scatter(puntos(cluster{cont}(:),1), puntos(cluster{cont}(:),2),sz,'filled')
        daspect([1 1 1])
        grid on
        axis([-350 350 -200 300])
        xlabel('Pixels')
        ylabel('Pixels')
        set(gca,'fontsize',16)
    end
    
    a = cluster{cont}(:);
    [b,m1,~] = unique(a,'first');
    [~,d1] =sort(m1);
    b = b(d1);
    
    clusterid{cont} =  ncurva(b, :);
end
if cont==0
    cluster={};
    clusterid={};
end
    
end
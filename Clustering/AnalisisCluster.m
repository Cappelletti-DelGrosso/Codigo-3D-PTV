clear all
close all

centro   = [0, 0] ;
Ac       = 0.2 ;
NumParts = 500 ;
lado     = 10 ;
puntos_random = [(rand(NumParts,1)-0.5)*lado+centro(1), (rand(NumParts,1)-0.5)*lado+centro(2)];

tri2 = delaunay(puntos_random(:,1),puntos_random(:,2));
[areas_new2, ~] = triangle_area(tri2,puntos_random(:,1),puntos_random(:,2));

line([centro(1)-lado/2, centro(1)-lado/2],[centro(2)-lado/2, centro(2)+lado/2],'Color','red','LineStyle','-')
line([centro(1)+lado/2, centro(1)+lado/2],[centro(2)-lado/2, centro(2)+lado/2],'Color','red','LineStyle','-')
line([centro(1)-lado/2, centro(1)+lado/2],[centro(2)-lado/2, centro(2)-lado/2],'Color','red','LineStyle','-')
line([centro(1)-lado/2, centro(1)+lado/2],[centro(2)+lado/2, centro(2)+lado/2],'Color','red','LineStyle','-')

% hold on
% plot(puntos_random(:,1), puntos_random(:,2),'ro');
% triplot(tri2,puntos_random(:,1),puntos_random(:,2)); hold on;
% candidatos = areas_new2<Ac ;
% aux = tri2(candidatos,:);
% 
% cont = 0;
% while(size(aux,1)>0)
%     cont = cont+1;
%     cluster{cont}=[aux(1, :)];
%     cont2 = 0;
%     while( cont2+1 <= size(cluster{cont}, 1) )
%         cont2 = cont2 + 1
%         size(cluster{cont}, 1)
%         for ii=1:3
%             mismocluster = sum((aux-cluster{cont}(cont2, ii))==0, 2) > 0 ;
%             cluster{cont} = [ cluster{cont}; aux(mismocluster, :) ] ;
%             aux(mismocluster, :) = [];
%         end
%     end
%     sz = 30;
%     scatter(puntos_random(cluster{cont}(:),1), puntos_random(cluster{cont}(:),2),sz,'filled')
% end

encontrarcluster(puntos_random, tri2, areas_new2, Ac, 1)


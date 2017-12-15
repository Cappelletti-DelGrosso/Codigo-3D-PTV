function []=ver2(curva)
figure

for ii=1:length(curva)/1
    clear xtray ytray ztray 
    xtray = curva{ii*1}(:,2)' ;
    ytray = curva{ii*1}(:,3)' ;
    ztray = curva{ii*1}(:,4)' ;
%     scatter3(xtray(1), ytray(1),ztray(1),'ro','LineWidth',2)
%     text(xtray(1), ytray(1),ztray(1),[num2str(ii)])
    hold on
    h=plot3(xtray, ytray, ztray,'LineWidth',1,'Color',[1,1,1]*0.5)%,'Color',[134,136,138]*(0.7+ii/length(curva))/256)
    alpha(h, 0.5)
%     scatter3(xtray, ytray, ztray,'LineWidth',2)

end
xlabel({'X [mm]'},'FontSize', 16)
ylabel({'Y [mm]'},'FontSize', 16)
zlabel({'Z [mm]'},'FontSize', 16)
set(gca,'fontsize',16)
 axis([-170, 20, 60, 140, -20, 20])
 daspect([1,1,1])
grid on
% title('Trayectoria Triangulada')

end
function []=ver(curva)
figure

for ii=1:length(curva)/1
    clear xtray ytray ztray 
    xtray = curva{ii*1}(:,1)' ;
    ytray = curva{ii*1}(:,2)' ;
    ztray = curva{ii*1}(:,3)' ;
%     scatter3(xtray(1), ytray(1),ztray(1),'ro','LineWidth',2)
%     text(xtray(1), ytray(1),ztray(1),[num2str(ii)])
    hold on
    plot3(xtray, ytray, ztray,'LineWidth',1)%,'Color',[134,136,138]*(0.7+ii/length(curva))/256)
    
%     scatter3(xtray, ytray, ztray,'LineWidth',2)

end
xlabel({'X [mm]'},'FontSize', 16)
ylabel({'Y [mm]'},'FontSize', 16)
zlabel({'Z [mm]'},'FontSize', 16)
set(gca,'fontsize',16)
%  axis([100, 240, -300, -150, -20, 30])
daspect([1,1,1])
grid on
% title('Trayectoria Triangulada')

end
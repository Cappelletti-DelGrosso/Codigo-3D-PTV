
[R2,t,cont300]=R2b(curva3, 300,0);
 figure; loglog(t,R2,'o')
    xlabel({'Tiempo [s]'},'FontSize', 16)
    ylabel({'Distancia Cuadrática Media [mm^2]'},'FontSize', 16)
    set(gca,'fontsize',16)
    [R2,t,cont200]=R2b(curva3, 200,0);
    hold on
    loglog(t,R2,'s')
      [R2,t,cont100]=R2b(curva3, 100,0);
    hold on
    loglog(t,R2,'d')
      [R2,t,cont50]=R2b(curva3, 50,0);
    hold on
    loglog(t,R2,'^')
    legend('14 Tray. de más de 300 ptos.','45 Tray. de más de 200 ptos.','128 Tray. de más de 100 ptos.','243 Tray. de más de 50 ptos.')
    axis([1E-3, 3, 1, 1E4])
    grid on
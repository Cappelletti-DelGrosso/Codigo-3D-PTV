figure
AZ=AZ/1000;
DZ=diff(AZ);
sz=sum(DZ.*PDFAZ(1:(end-1)))
PDFAZ=PDFAZ/sz;
semilogy(AZ, PDFAZ, 'o',...
    'MarkerEdgeColor',[0, 100, 0]/300,...
    'MarkerFaceColor',[0, 100, 0]/150,...
    'MarkerSize',10)

hold on
AX=AX/1000;
DX=diff(AX);
sx=sum(DX.*PDFAX(1:(end-1)))
PDFAX=PDFAX/sx;
semilogy(AX, PDFAX,  'square',...
    'MarkerEdgeColor',[255, 102, 0]/400,...
    'MarkerFaceColor',[255, 102, 0]/255,...
    'MarkerSize',10)
hold on
AY=AY/1000;
DY=diff(AY);
sy=sum(DY.*PDFAY(1:(end-1)))
PDFAY=PDFAY/sy;
semilogy(AY, PDFAY,  'd',...
    'MarkerEdgeColor',[0, 114, 187]/300,...%255
    'MarkerFaceColor',[0, 114, 187]/187,...%187
    'MarkerSize',10)

axis([-60, 60, 1E-4, 1.5E-1])
a1 =     0.09794  ;
b1 =     0.02773  ;
c1 =       5.586  ;
semilogy(AX, a1*exp(-((AX-b1)/c1).^2),'Color','k', 'LineWidth', 3)

grid on
% title('PDF de Aceleraciones en X, Y y Z')
xlabel({'A [m/s^2]'},'FontSize', 16)
ylabel({'PDF( A )'},'FontSize', 16)
legend({'AZ','AX', 'AY','Normal'}, 'FontSize', 16)
set(gca,'fontsize',16)
function []=PDFRnofit(r, marcador,color1, color2)
 bins=sqrt(length(r))
% nbin=size(r,1)/200;
% limite=4;
% ancho=2*limite/nbin;
% bins = [0:ancho:limite];
% 
[PDFR, R] = hist(r, bins) ;
DR    = diff(R);
sr    = sum(DR.*PDFR(1:(end-1)));
PDFR = PDFR/sr;
semilogy(R, PDFR, marcador,'MarkerEdgeColor',color1,...
    'MarkerFaceColor',color2,...
    'MarkerSize',5)
hold on
grid on
xlabel({'Desplazamiento [mm]'},'FontSize', 16)
ylabel({'PDF( Desplazamiento ) '},'FontSize', 16)
set(gca,'fontsize',16)
axis([0 3 1E-4 10])

end

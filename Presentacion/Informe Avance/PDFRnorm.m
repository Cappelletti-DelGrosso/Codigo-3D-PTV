function []=PDFRnorm(r,titulo)
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
figure
semilogy(R, PDFR, 'o',...
    'MarkerEdgeColor',[0, 100, 0]/200,...
    'MarkerFaceColor',[0, 100, 0]/150,...
    'MarkerSize',10)
%,  'MarkerSize',5,'MarkerEdgeColor',[255, 102, 0]/400)
hold on
%[0, 114, 187]/187

% semilogy(VX, a1*exp(-((VX-b1)/c1).^2),'-','Color',[0, 114, 187]/187)
grid on
 title(titulo)
xlabel({'Desplazamiento [mm]'},'FontSize', 16)
ylabel({'PDF( Desplazamiento ) '},'FontSize', 16)
set(gca,'fontsize',16)
axis([0 3 1E-4 10])

R2 = [0:min(diff(R))/100:max(R)];
sigma=mean(r)*sqrt(2/pi)
    semilogy(R2, R2/(sigma^2).*exp(-0.5*((R2)/sigma).^2),'Color','k', 'LineWidth', 3)
    legend({'Medicion', 'Ajuste Rayleigh'}, 'FontSize', 16)
end

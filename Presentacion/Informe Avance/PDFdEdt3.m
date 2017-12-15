function []=PDFdEdt3(v,titulo)
v = (v-mean(v))./std(v) ;
figure;
nbin=size(v,1)/200;
limite=50;
ancho=2*limite/nbin;
bins=[-limite:ancho:limite];

ii=1;
[PDFV(:,ii), V(:,ii)] = hist(v(:,ii), bins) ;
DV    = diff(V(:,ii));
sv    = sum(DV.*PDFV(1:(end-1),ii));
PDFV(:,ii) = PDFV(:,ii)/sv;
plot(V(:,ii), abs(PDFV(:,ii).*(V(:,ii).^3)), 'square',...
    'MarkerEdgeColor',[255, 102, 0]/400,...
    'MarkerFaceColor',[255, 102, 0]/255,...
    'MarkerSize',10)
%,  'MarkerSize',5,'MarkerEdgeColor',[255, 102, 0]/400)
grid on
 title(titulo)
xlabel({'E'},'FontSize', 16)
ylabel({'PDF( E ) '},'FontSize', 16)
set(gca,'fontsize',16)

% axis([-6 6 1E-3 1])
% a1= 1/sqrt(2*pi);
%     b1=0;
%     c1=sqrt(2);
%     semilogy(V(:,ii), a1*exp(-((V(:,ii)-b1)/c1).^2),'Color','k', 'LineWidth', 3)
end

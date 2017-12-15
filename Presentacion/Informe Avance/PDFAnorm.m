function []=PDFAnorm(a,titulo)
a = (a-mean(a))./std(a) ;

figure;
nbin=size(a,1)/200;
% nbin=sqrt(length(a(:,ii)))/2;
% comienzo=0.5;
% fin=10;
% anchobin=(log(fin)-log(comienzo))/(nbin-1);
% vector=exp([log(comienzo):anchobin:log(fin)]);
% h=vector(2)-vector(1);
% vector=vector-vector(1)+h;
% vector2=-vector(sort([1:length(vector)],'descend'));
% bins=[vector2,vector];
limite=50;
ancho=2*limite/nbin;
bins=[-limite:ancho:limite];
ii=1;
[PDFA(:,ii), A(:,ii)] = hist(a(:,ii), bins) ;
DA    = diff(A(:,ii));
sa    = sum(DA.*PDFA(1:(end-1),ii));
PDFA(:,ii) = PDFA(:,ii)/sa;
h=semilogy(A(:,ii), PDFA(:,ii), 'square',...
    'MarkerEdgeColor',[255, 102, 0]/400,...
    'MarkerFaceColor',[255, 102, 0]/255,...
    'MarkerSize',10)
hold on


ii=2;
[PDFA(:,ii), A(:,ii)] = hist(a(:,ii), bins) ;
DA    = diff(A(:,ii));
sa    = sum(DA.*PDFA(1:(end-1),ii));
PDFA(:,ii) = PDFA(:,ii)/sa;
h=semilogy(A(:,ii), PDFA(:,ii),  'd',...
    'MarkerEdgeColor',[0, 114, 187]/300,...%255
    'MarkerFaceColor',[0, 114, 187]/187,...%187
    'MarkerSize',10)

ii=3;

[PDFA(:,ii), A(:,ii)] = hist(a(:,ii), bins) ;
Da    = diff(A(:,ii));
sa    = sum(DA.*PDFA(1:(end-1),ii));
PDFA(:,ii) = PDFA(:,ii)/sa;
h=semilogy(A(:,ii), PDFA(:,ii), 'o',...
    'MarkerEdgeColor',[0, 100, 0]/200,...
    'MarkerFaceColor',[0, 100, 0]/150,...
    'MarkerSize',10)
hold on

grid on
title(titulo)
xlabel({'A'},'FontSize', 16)
ylabel({'PDF( A ) '},'FontSize', 16)
set(gca,'fontsize',16)

axis([-6 6 1E-3 1])
a1= 1/sqrt(2*pi);
    b1=0;
    c1=sqrt(2);
    semilogy(A(:,ii), a1*exp(-((A(:,ii)-b1)/c1).^2),'Color','k', 'LineWidth', 3)
    legend({'AX','AY', 'AZ', 'N(0,1)'}, 'FontSize', 16)
end

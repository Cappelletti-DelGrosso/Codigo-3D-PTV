

figure;
%[0, 100, 0]/200
% semilogy(VZ/1000, a1*exp(-((VZ-b1)/c1).^2),'-','Color',[0, 100, 0]/100)

ii=1;
[PDFA(:,ii), A(:,ii)] = hist(a(:,ii)/1000, sqrt(length(a(:,ii)))) ;
DA    = diff(A(:,ii));
sa    = sum(DA.*PDFA(1:(end-1),ii));
PDFA(:,ii) = PDFA(:,ii)/sa;
semilogy(A(:,ii), PDFA(:,ii), 'square',...
    'MarkerEdgeColor',[255, 102, 0]/400,...
    'MarkerFaceColor',[255, 102, 0]/255,...
    'MarkerSize',10)
%,  'MarkerSize',5,'MarkerEdgeColor',[255, 102, 0]/400)
hold on
%[0, 114, 187]/187

% semilogy(VX/1000, a1*exp(-((VX-b1)/c1).^2),'-','Color',[0, 114, 187]/187)
hold on

ii=2;
[PDFA(:,ii), A(:,ii)] = hist(a(:,ii)/1000, sqrt(length(a(:,ii)))) ;
Da    = diff(A(:,ii));
sa    = sum(DA.*PDFA(1:(end-1),ii));
PDFA(:,ii) = PDFA(:,ii)/sa;
semilogy(A(:,ii), PDFA(:,ii),  'd',...
    'MarkerEdgeColor',[0, 114, 187]/300,...%255
    'MarkerFaceColor',[0, 114, 187]/187,...%187
    'MarkerSize',10)

ii=3;

[PDFA(:,ii), A(:,ii)] = hist(a(:,ii)/1000, sqrt(length(a(:,ii)))) ;
DA    = diff(A(:,ii));
sa    = sum(DA.*PDFA(1:(end-1),ii));
PDFA(:,ii) = PDFA(:,ii)/sa;
semilogy(A(:,ii), PDFA(:,ii), 'o',...
    'MarkerEdgeColor',[0, 100, 0]/200,...
    'MarkerFaceColor',[0, 100, 0]/150,...
    'MarkerSize',10)
hold on

grid on
% title('PDF de Velocidades en X, Y y Z')
xlabel({'A [m/s^{2}]'},'FontSize', 16)
ylabel({'PDF( A ) '},'FontSize', 16)
set(gca,'fontsize',16)
legend({'AX','AY', 'AZ', 'N(0,1)'}, 'FontSize', 16)
axis([-40 40 1E-4 0.46])

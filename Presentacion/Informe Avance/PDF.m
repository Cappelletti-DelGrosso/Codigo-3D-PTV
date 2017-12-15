clear all
close all

load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\21-06-17\Damero\Resultados Camara 1.mat')
[X, N]=hist(F, sqrt(length(F)));
DN=diff(N);
sx=sum(DN.*X(1:(end-1)))
X=X/sx;

semilogy(N, X, 's','Color', [0, 128, 255]/255,...
    'MarkerEdgeColor',[0, 128, 255]/255,...
    'MarkerFaceColor',[0, 128, 255]/500,...
    'MarkerSize',10)

hold on

clearvars -except N X
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\21-06-17\Damero\Resultados Camara 2.mat')
[Y, M]=hist(F, sqrt(length(F)));
DM=diff(M);
sy=sum(DM.*Y(1:(end-1)))
Y=Y/sy;

semilogy(M, Y,'o','Color', [140, 0, 26]/140,...
    'MarkerEdgeColor',[0, 100, 0]/150,...
    'MarkerFaceColor',[0, 100, 0]/350,...
    'MarkerSize',10) %'Color',[140, 0, 26]/140 ,'MarkerEdgeColor',[140, 0, 26]/280,  'MarkerSize',10)

% title('PDF de Errores de Reproyección Cámara 1 y 2')

a1 =       1.343  ;
b1 =    -0.03038  ;
c1 =      0.4056  ;
h2=semilogy(N,  a1*exp(-((N-b1)/c1).^2),'Color', [0, 128, 255]/255, 'LineWidth',3)
% [0.4940 0.1840 0.5560] violeta

a1 =       1.813  ;
b1 =  -0.0009555  ;
c1 =      0.3017  ;
h1=semilogy(M,  a1*exp(-((M-b1)/c1).^2),'Color',[0, 100, 0]/150,'LineWidth', 3)
%[0.9290 0.6940 0.1250] amarillo
% 


xlabel({'Er [pixels]'},'FontSize', 16)
ylabel({'PDF( Er ) '},'FontSize', 16)
axis([-2, 2, 0.002, 5])
legend({'Cámara 1','Cámara 2', 'Normal 1', 'Normal 2'}, 'FontSize', 16)
set(gca,'fontsize',16)
grid on


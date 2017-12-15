direccion= 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\21-06-17\Damero\'
figure
X=X/sum(X)
semilogy(N, X, 's-','Color',[27, 171, 11]/300 ,'MarkerEdgeColor',[0, 100, 0]/400,  'MarkerSize',10,...
    'MarkerFaceColor',[0, 100, 0]/200)
hold on

% a1 =      0.2761  ;
% b1 =     0.03624  ;
% c1 =      0.2853 ;
% semilogy(N,  a1*exp(-((N-b1)/c1).^2))
axis([-2.5, 2.5, 0.0001, 1])

% title('PDF de Errores 3D')
xlabel({'E_{3D} [mm]'},'FontSize', 16)
ylabel({'PDF( E_{3D} ) '},'FontSize', 16)
grid on
set(gca,'fontsize',16)



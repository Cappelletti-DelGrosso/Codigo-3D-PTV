
Lvz=length(vz);
a1 =     0.02963  ;
b1 =       3.969  ;
c1 =       178.4  ;
[PDFVZ, VZ]=hist((vz-mean(vz))/std(vz), sqrt(Lvz));

DZ=diff(VZ);
sz=sum(DZ.*PDFVZ(1:(end-1)))
PDFVZ=PDFVZ/sz;

figure
semilogy(VZ, PDFVZ, 'o',...
    'MarkerEdgeColor',[0, 100, 0]/200,...
    'MarkerFaceColor',[0, 100, 0]/150,...
    'MarkerSize',10)
hold on
%[0, 100, 0]/200
% semilogy(VZ/1000, a1*exp(-((VZ-b1)/c1).^2),'-','Color',[0, 100, 0]/100)


Lvx=length(vx);
a1 =     0.03199  ;
b1 =      -47.82  ;
c1 =       136.6  ;
[PDFVX, VX]=hist((vx-mean(vx))/std(vx), sqrt(Lvx));

DX=diff(VX);
sx=sum(DX.*PDFVX(1:(end-1)))
PDFVX=PDFVX/sx;


semilogy(VX, PDFVX, 'square',...
    'MarkerEdgeColor',[255, 102, 0]/400,...
    'MarkerFaceColor',[255, 102, 0]/255,...
    'MarkerSize',10)
%,  'MarkerSize',5,'MarkerEdgeColor',[255, 102, 0]/400)
hold on
%[0, 114, 187]/187

% semilogy(VX/1000, a1*exp(-((VX-b1)/c1).^2),'-','Color',[0, 114, 187]/187)
hold on

Lvy=length(vy);
a1 =     0.04437  ;
b1 =        14.8  ;
c1 =       157.7  ;
[PDFVY, VY]=hist((vy-mean(vy))/std(vy), sqrt(Lvy));

DY=diff(VY);
sy=sum(DY.*PDFVY(1:(end-1)))
PDFVY=PDFVY/sy;

semilogy(VY, PDFVY,  'd',...
    'MarkerEdgeColor',[0, 114, 187]/300,...%255
    'MarkerFaceColor',[0, 114, 187]/187,...%187
    'MarkerSize',10)

%'d' ,'MarkerFaceColor',[140, 0, 26]/140,  'MarkerSize',5,'MarkerEdgeColor',[140, 0, 26]/280)
%[140, 0, 26]/140
%0, 0, 128]/255 o 255
%
axis([-4, 4, 0.001, 1])
semilogy(VY, 1/sqrt(2*pi)*exp(-0.5*(VY.^2)),'-', 'LineWidth', 3, 'Color','k')
grid on
% title('PDF de Velocidades en X, Y y Z')
xlabel({'V'},'FontSize', 16)
ylabel({'PDF( V ) '},'FontSize', 16)
set(gca,'fontsize',16)
legend({'VZ','VX', 'VY', 'Normal'}, 'FontSize', 16)



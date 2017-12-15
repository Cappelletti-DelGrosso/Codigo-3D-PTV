function [] = GraficarA(ax, ay, az, r)

ax = (ax-mean(ax))/std(ax) ;
ay = (ay-mean(ay))/std(ay) ;
az = (az-mean(az))/std(az) ;

[PDFAX, AX]=hist(ax, sqrt(length(ax)));
[PDFAY, AY]=hist(ay, sqrt(length(ay)));
[PDFAZ, AZ]=hist(az, sqrt(length(az)));

figure
DX    = diff(AX);
sx    = sum(DX.*PDFAX(1:(end-1)));
PDFAX = PDFAX/sx;
semilogy(AX, PDFAX,  'square',...
    'MarkerEdgeColor',[255, 102, 0]/400,...
    'MarkerFaceColor',[255, 102, 0]/255,...
    'MarkerSize',10)
hold on
DY    = diff(AY);
sy    = sum(DY.*PDFAY(1:(end-1)));
PDFAY = PDFAY/sy;
semilogy(AY, PDFAY,  'd',...
    'MarkerEdgeColor',[0, 114, 187]/300,...%255
    'MarkerFaceColor',[0, 114, 187]/187,...%187
    'MarkerSize',10)
hold on
DZ    = diff(AZ);
sz    = sum(DZ.*PDFAZ(1:(end-1)));
PDFAZ = PDFAZ/sz;                 %Normalizo a área 1
semilogy(AZ, PDFAZ, 'o',...
    'MarkerEdgeColor',[0, 100, 0]/300,...
    'MarkerFaceColor',[0, 100, 0]/150,...
    'MarkerSize',10)
hold on

mx = min([AX, AY, AZ])*1.2 ;
Mx = max([AX, AY, AZ])*1.2 ;
my = min([PDFAX, PDFAY, PDFAZ])*1.2 ;
My = max([PDFAX, PDFAY, PDFAZ])*1.2 ;

a1= 1/sqrt(2*pi);
b1=0;
c1=sqrt(2);
semilogy(AX, a1*exp(-((AX-b1)/c1).^2),'Color','k', 'LineWidth', 3)

axis([mx, Mx, my, My])
grid on

if r==10
    title('PDF de Posición')
    legend('X','Y','Z')
if r==1
    title('PDF de Velocidades')
    legend('VX','VY','VZ')
end
if r==2
    title('PDF de Aceleraciones')
    legend('AX','AY','AZ')
end

end
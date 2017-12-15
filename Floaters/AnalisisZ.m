
close all
clear all

%load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\21-06-17\Floaters2\Curva3.mat')
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\23-06-17\Floaters3\Curva3.mat')

%curva4=[];
%curva4=[curva4,curva3];
%clear curva3

x=[];
y=[];
z=[];

for jj=1:length(curva3)
   tray = curva3{jj};
    x = [x; tray(:,1)];
    y = [y; tray(:,2)];
    z = [z; tray(:,3)];
   
end
mean(z)
std(z)
z = (z-mean(z))/std(z) ;
[PDFZ, Z]=hist(z, sqrt(length(z))/2);
DZ    = diff(Z);
sz    = sum(DZ.*PDFZ(1:(end-1)));
PDFZ = PDFZ/sz;
semilogy(Z, PDFZ,'bo', 'LineWidth', 3)
hold on

a1= 1/sqrt(2*pi);
b1=0;
c1=sqrt(2);
semilogy(Z, a1*exp(-((Z-b1)/c1).^2),'Color','k', 'LineWidth', 3)

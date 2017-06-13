clear all
close all

camara=2;
direccion='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\07-06-2017\Floaters\';

fondo = dir([direccion,'Fondo blanco\*C',num2str(camara),'S0001.tif']);
fc = double(imread([direccion,'Fondo blanco\',fondo.name]));
figure
imagesc(fc)
daspect([1 1 1])

flot=dir([direccion, 'Floaters\*C',num2str(camara),'S0001.tif']);
N=length(flot)

for jj=1:N
im1 = imread([direccion, 'Floaters\', flot(jj).name]);
% figure
% imagesc(im1)
% daspect([1 1 1])

im2 = double(im1) - fc;
figure
imagesc(im2)
daspect([1 1 1])
colorbar

[centersDark, radiiDark] = imfindcircles(im2,[15 30],'ObjectPolarity','dark');
hold on
viscircles(centersDark, radiiDark,'Color','r');

end
% im1=-double(im1);
% BW = im1>-500 ;
% figure
% imshow(BW)
% daspect([1 1 1])
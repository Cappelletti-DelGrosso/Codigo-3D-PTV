function [ particulas ]=detectarcirculos(direccion)
%direccion      = 'C:\Users\Nicol�s\Desktop\Labo 6\Mediciones\12-09-17\Superficie libre\';
%dirparametros  = 'C:\Users\Nicol�s\Desktop\Labo 6\Mediciones\02-11-17\Damero\Par�metros Montaje Completo.mat';
% suplibre= 'C:\Users\Nicol�s\Desktop\Labo 6\Mediciones\09-11-17\Superficie libre\';
% frecuencia = [80, 250];

dirfloaters    = cd;

tic
[particulas, ~, ~, ~]=circulos2(direccion, 0, 0);
toc
% 2726 frames en 1 hora
cd(direccion)
save('Particulas', 'particulas')
cd(dirfloaters)
end
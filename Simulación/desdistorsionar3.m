function [compensada, xd, yd, xu, yu] = desdistorsionar3(imagen, f, pp, k, p, metodo)
%  imagen:  imagen original (con distorsion)
%  f:       vector de 2 componentes con distancia focal en pixeles
%           es decir calculada como (dist_focal_en_mm/tamano_pixel_en_mm)
%  pp:      vector con los 2 puntos principales (en pixeles)
%  k:       vector de los 3 parametros de la distorsion radial
%  p:       vector de los 2 parametros de la distorsion tangencial

% Generamos una grilla con los valores de las coordenadas que
% corresponderian a una imagen sin distorsiones. Luego mapeamos estas
% coordenadas, teniendo en cuenta las distorsiones de la lente, para
% obtener asi las ubicaciones de las imagenes, ahora distorsionadas por los
% defectos del sistema optico. Las nuevas coordenadas distorsionadas se
% guardan en una matriz que esta indexada por las coordenadas originales
% (sin distorsionar). Entonces para cada ubicacion no distorsionada podemos
% determinar la ubicacion en la imagen distorsionada, lo que nos permite
% mapear cada valor del gris de los pixeles asociados.

% Definimos los parametros del problema (esto despues se podria mejorar
%  escribiendolo como matriz)
fx = f(1); fy = f(2);
ppx = pp(1); ppy = pp(2);
k1 = k(1); k2 = k(2); k3 = k(3);
p1 = p(1); p2 = p(2);

% grids para la no distorsionada
[rows,cols] = size(imagen);
[xu,yu] = meshgrid(1:cols, 1:rows);

% convertimos los valores de la grilla a normalizados con el origen en los
% principal points. Al dividir por la distancia focal (en pixeles) tenemos
% coordenadas normalizadas con Z = 1. 
x = (xu-ppx)/fx;
y = (yu-ppy)/fy;

% distorsion radial
r2 = x.^2+y.^2;                    
dr = k1*r2 + k2*r2.^2 + k3*r2.^3;  

% distorsion tangencial
% cuidado con el orden, que cambia segun la referencia usada
dtx =    2*p1*x.*y      +  p2*(r2 + 2*x.^2);
dty = p1*(r2 + 2*y.^2)  +    2*p2*x.*y;

% aplicamos las distorsiones radiales y tangenciales 
% a cada componente (se puede hacer en matrices o vectorizado)
x = x + dr.*x + dtx;
y = y + dr.*y + dty;

% reescalamos por fx y fy y sumamos otra vez el principal point para tener
% las coordenadas x e y distorsionadas
xd = x*fx + ppx;
yd = y*fy + ppy;

% al final interpolamos los valores de la imagen distorsionada (original)
% a sus ubicaciones corregidas o compensadas (ideales)
% metodo puede ser cualquier opcion de interp2, aunque comparando los
% resultados veo que 'linear' (que es bilineal) da los mismos resultados
% que el toolbox de matlab (difieren en valor absoluto en 1e-13)
if sum(imagen(:))>1E-4
compensada = interp2(xu,yu,double(imagen),xd,yd, metodo);
else
    compensada=0;
end
end
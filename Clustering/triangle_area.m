function [area, areapiola] = triangle_area(tri,xx,yy)
% Calcula el area de todos los triangulos que tiene la triangulacion de
% delaunay

area = zeros(size(tri,1),1);

for ii=1:size(tri,1)
    x1 = xx(tri(ii,1)); 
    y1 = yy(tri(ii,1));
    x2 = xx(tri(ii,2));
    y2 = yy(tri(ii,2));
    x3 = xx(tri(ii,3));
    y3 = yy(tri(ii,3));
    
    area(ii) = 1/2*abs((x2-x1)*(y3-y1)-(x3-x1)*(y2-y1));
    
    
    clear x1 x2 x3 y1 y2 y3
    
end

% including instantaneous normalization
areapiola=area;
area = area/mean(area);
    
function [curva7]=rectificar(curva6,R,centro)

for kk=1:length(curva6)
    curva7{kk}(:, 1) = curva6{kk}(:,1);
    curva7{kk}(:,2:4) = (R*((curva6{kk}(:,2:4)-centro)'))';
end

end
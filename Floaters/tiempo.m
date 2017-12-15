function [curva2]=tiempo(curva,s, f)
%s tiepo de shutting 1, 2, 3
%f(1) frecuencia más chica f(2) frecuencia más grande ej. f=[120, 250]

curva2={};
for kk=1:length(curva)
    frame =curva{kk}(:,4);
    t = floor((frame-1)/s)/f(1) + mod( (frame-1) ,s)/f(2);  
    curva2={curva2{:}, [t,curva{kk}(:,1:3)]};
end
    
end
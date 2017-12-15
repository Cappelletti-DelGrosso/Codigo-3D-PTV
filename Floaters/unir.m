function [curva]=unir(direcciones)
curva={};
for ii=1:length(direcciones)
    ii
   load([direcciones{ii},'Curva4']);
   curva={curva{:}, curva4{:}};
end

end
function [curva3]=cargarcurvas(direccion,n,largo)
curva2={};
for ii=1:n
    ii
    load([direccion,num2str(ii),'\Curva.mat'])
    curva2={curva2{:}, curva{:}}
end
cont=0;
for jj=1:length(curva2)
    if length(curva2{jj})>(largo-1)
        cont=cont+1;
        curva3{cont}=curva2{jj};
    end
end
end
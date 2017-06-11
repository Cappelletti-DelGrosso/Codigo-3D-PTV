function [ I ] = mundo2d( Lx, Ly, pasos, xtray, ytray )

N=size(xtray,2);

I = zeros(Lx+1, Ly+1, pasos); %Matrices de imágenes

for kk=1:pasos
    for pp=1:N
        j = round(ytray(kk, pp))+Ly/2 ;
        i = round(xtray(kk, pp))+Lx/2 ;
        if Ly>j && j>0 && Lx>i && i>0
            I(j, i, kk) = 1 ;        %Lleno los fotogramas siguientes
        end
    end
    J=imdilate(I(:,:,kk),[0,1,0;1,1,1;0,1,0]);
    pcolor(J)     %Grafico el fotograma
    colormap gray
    shading flat
    daspect([1 1 1])
    title(['Particulas en el Mundo 2D, t=',num2str(kk)])
    pause(0.01)
end

end


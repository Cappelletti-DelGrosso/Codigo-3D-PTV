%Trayectoria: tengo particulas{frame, camara} en cada camara y en cada
%frame tengo una matriz con las posiciones de las partículas, quiero
%trayectorias{numero de particula, camara} sea una matriz con x, y, z y el
%numero de frame.
% clear all
% load particulas

function [trayectorias]=trayectoria(particulas)

tolerancia=10;
% figure

for camara = 1:size(particulas,2)
    camara;
    N=1;
    for frame = 1:size(particulas,1)
        frame;
        Vi=(particulas{frame, camara})';
        L = size(Vi, 2);
        if L>0 % Si la matriz no está vacía
            for ii = 1:L %Para todas las partículas en esa matriz
                
                trayectorias{N, camara}=[];
                m=0;
                x0 =  Vi(:, ii);
                I=ii;
                Wi=Vi;
                cont=0;
                while m>-1 && frame+cont+1<=size(particulas,1) %Para todos los frames siguientes calculo para cada particula la distancia al punto determina del frame anterior y me lo quedo si es menor a 5 pixels
                    trayectorias{N, camara}= [trayectorias{N, camara}; x0', frame+cont];
                    particulas{frame+cont, camara} = [Wi(:, 1:(I-1)), Wi(:, (I+1):end)]';
                    Wi(:, (I+1):end);
                    
                    Wi = (particulas{frame+cont+1, camara})';
                    if length(Wi)==0
                        m=nan;
                    else
                    T  =sqrt(sum((Wi-x0).^2));
                    T( T>tolerancia )=nan;
                    [m, I]= min(T);
                    x0 = Wi(:,I);
                    cont=cont+1;
                    end
                    %pause
                end
                if frame+cont==size(particulas,1)
                    trayectorias{N, camara}= [trayectorias{N, camara}; x0', frame+cont];
                    particulas{frame+cont, camara} = [Wi(:, 1:(I-1)), Wi(:, (I+1):end)]';
                end
                    
                A=trayectorias{N, camara};
%                 subplot(1,2,camara);
%                 title(['Camara ',num2str(camara)])
%                 scatter(A(:,1), A(:,2))
%                 hold on
%                 daspect([1 1 1])
%                 axis([0 1024 0 1024])
%                 text(A(1,1), A(1,2),num2str(N),'Color','blue','FontSize',14);
%                 pause
                N=N+1;
            end 
        end
    end
end
% 
% PARA PROBAR QUE TRAYECTORIA ESTA BIEN
% 
% load Vi
% for ii=1:size(trayectorias,2)
%     for jj=1: size(trayectorias,1)
%         L=size(trayectorias{jj,ii},1);
%         for kk=1:L
%             frame=trayectorias{jj,ii}(kk,3);
%             Wi=round(Vi(:,:,frame,ii)');
%             lx=(Wi(:,1)==trayectorias{jj,ii}(kk,1));
%             ly=(Wi(:,2)==trayectorias{jj,ii}(kk,2));
%             lf=and(lx,ly);
%             s=sum(lf);
%             if s~=1
%                 stop
%             end
%         end
%     end
% end
end
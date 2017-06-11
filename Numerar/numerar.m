function [Viorden, n, m]=numerar(Vi, graf)
N=length(Vi);

%if graf==1
    figure(1)
    hold on
    scatter(Vi(:,1), Vi(:,2) )
    daspect([1,1,1])
    axis([0, 1024, 0,1024])
    hold on
%end


[~,I]=sort(Vi(:,1));
D=sort([I(1), I(end)]);
[~,J]=sort(Vi(:,2));
p(:,1)=Vi(I(1),:);
p(:,2)=Vi(I(end),:);
p(:,3)=Vi(J(1),:);
p(:,4)=Vi(J(end),:);

if graf==1
        pause
        scatter(p(1,:), p(2,:), 'ro')
end


    A=Vi-p(:,1)';
    pendiente= abs(A(:,2)./A(:,1));
    angulo = 180/pi*atan(pendiente);
    [~,I]=max(angulo);
    q(:,1)=Vi(I,:);
    

    A=Vi-p(:,2)';
    pendiente= abs(A(:,2)./A(:,1));
    angulo = 180/pi*atan(pendiente);
    [~,I]=max(angulo);
    q(:,2)=Vi(I,:);    
    
    A=Vi-p(:,3)';
    pendiente= abs(A(:,2)./A(:,1));
    angulo = 180/pi*atan(pendiente);
    [~,I]=min(angulo);
    q(:,3)=Vi(I,:);
    
    A=Vi-p(:,4)';
    pendiente= abs(A(:,2)./A(:,1));
    angulo = 180/pi*atan(pendiente);
    [~,I]=min(angulo);
    q(:,4)=Vi(I,:);

    if graf==1
        scatter(q(1,1), q(2,1),'go')
        pause
        scatter(q(1,2), q(2,2),'go')
        pause
        scatter(q(1,3), q(2,3),'go')
        pause
        scatter(q(1,4), q(2,4),'go')
        pause
    end
    
    esquinas=[];
    %intersecciones
    E=[1,2];
    F=[3,4];
    
    for ii=1:2
        for jj=1:2
            a=E(ii);
            b=F(jj);
            x1 = p(1,a); 
            y1 = p(2,a);
            x2 = q(1,a);
            y2 = q(2,a);
            x3 = p(1,b); 
            y3 = p(2,b);
            x4 = q(1,b);
            y4 = q(2,b);

            clear A
            A = [(y2-y1), -(x2-x1);...
            (y4-y3), -(x4-x3)];
            b = [(y2-y1)*x1-(x2-x1)*y1;...
            (y4-y3)*x3-(x4-x3)*y3];
            PInt = A\b;
            
            %scatter(PInt(1), PInt(2),'rx')
            
            dist=sqrt((Vi(:,1)-PInt(1)).^2+(Vi(:,2)-PInt(2)).^2);
            [~,I]=min(dist);
            
            esquinas=[esquinas, Vi(I,:)'];
            %pause
        end
    end
    
    
    centro=[mean(esquinas(1,:)); mean(esquinas(2,:))];
    if graf==1
        scatter(centro(1), centro(2), 'bx')
        pause
    end
    
    [~,I]=sort(esquinas(1,:)); %busco las 2 minimas coordenadas en x
    [~,J]=sort(esquinas(2,I(1:2))); %de esas 2 esquinas me quedo con la que tiene mínima componente en y
    e1=I(J(1));
    
    [esquina1, esquina2, esquina3, esquina4]=ordenaresquinas(esquinas,e1);
    
    if graf==1
        plot([esquina1(1), esquina2(1), esquina3(1), esquina4(1)],[esquina1(2), esquina2(2), esquina3(2), esquina4(2)])
    end
    
    esquinas(:,1)=esquina1;
    esquinas(:,2)=esquina2;
    esquinas(:,3)=esquina3;
    esquinas(:,4)=esquina4;
    
    red1 = esquina1+(esquina1-centro)/norm(esquina1-centro)*10; %encierro a los puntos con una red
    red2 = esquina2+(esquina2-centro)/norm(esquina2-centro)*10;
    red3 = esquina3+(esquina3-centro)/norm(esquina3-centro)*10;
    red4 = esquina4+(esquina4-centro)/norm(esquina4-centro)*10;

    xv=[red1(1), red2(1), red3(1), red4(1)];
    yv=[red1(2), red2(2), red3(2), red4(2)];
    [in]=inpolygon( Vi(:,1), Vi(:,2) ,xv ,yv );
    if graf==1
        hold on
        scatter(xv, yv, 'gx')
        pause
    end
    
    if sum(in)~= size(Vi,1)
     
        disp('Error: No se encontraron las esquinas.')
        stop
    end
    
    esquina1=esquinas(:,1)';
    esquina2=esquinas(:,2)';
    esquina3=esquinas(:,3)';
    esquina4=esquinas(:,4)';
    
    if graf==1
        scatter([esquina1(1), esquina2(1), esquina3(1), esquina4(1)], [esquina1(2), esquina2(2), esquina3(2), esquina4(2)], 'mo')
    end
       
    [linea12, J12]=encontrarlinea4(esquina1, esquina2, Vi);
    
    [linea14, J14]=encontrarlinea4(esquina1, esquina4, Vi);
    
    [tablero, I] = sort([length(linea12), length(linea14)]);
    Viorden = [];
    
    m=tablero(1);
    n=tablero(2);
    
    if I(2)==1
        Viorden = [Viorden, linea12];
        nuevoinicial = linea14(:,2)';
        final = linea12(:,end)';
        [auxiliar, ~]=encontrarlinea4(final, esquina3, Vi);
        nuevofinal= auxiliar(:,2)';
        Vi=Vi(J12==1,:);
    else
        esquina2a=esquina4;
        esquina4a=esquina2;
        esquina2=esquina2a;
        esquina4=esquina4a;
        nuevoinicial = linea12(:,2)';
        final= linea14(:,end)';
        [auxiliar, ~]=encontrarlinea4(final, esquina3, Vi);
        nuevofinal= auxiliar(:,2)';
        Viorden = [Viorden, linea14];
        Vi=Vi(J14==1,:);

    end
    
    while size(Viorden,2)~=N
        
        
        [linea, J]=encontrarlinea4(nuevoinicial, nuevofinal, Vi);
        Viorden = [Viorden, linea];
        
        if length(Viorden)~=N
            [auxiliar, ~]=encontrarlinea4(nuevoinicial, esquina4, Vi);
            nuevoinicial = auxiliar(:,2)';
            final= linea(:,end)';
            [auxiliar, ~]=encontrarlinea4(final, esquina3, Vi);
            nuevofinal= auxiliar(:,2)';
        end
        Vi=Vi(J==1,:);
    end
    
    end
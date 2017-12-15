function [ cero, uno ] = escena( Vi, K, sx, sy, R, T, Lx, Ly, H, A )

 f     = ( K(1,1)*sx + K(2,2)*sy )/2;
 ladox = (1:10:Lx) ;        %Esto es para hacer el ccd
 ladoy = (1:10:Ly) ;
[x, y] = meshgrid(ladox, ladoy) ;
z = ones(size(x)) ;

 B=[x(:)';y(:)'; z(:)'] ;
 B= K\(B*f) ;
 
E=zeros(3, size(B,2));
E(1,:)=T(1);
E(2,:)=T(2);
E(3,:)=T(3);


J=R'*(B-E);
x2 = (vec2mat(J(1,:),size(x,1)))';
y2 = (vec2mat(J(2,:),size(x,1)))';
z2 = (vec2mat(J(3,:),size(x,1)))';


Vc= K\([Vi; ones(1, size(Vi,2))]*f);     %Esto es para marcar los puntos de la imagen en el ccd
Em=zeros(3, size(Vi,2));
Em(1,:)=T(1);
Em(2,:)=T(2);
Em(3,:)=T(3);

mundo= R'*(Vc-Em);

cero= R'*(-T');  %centro de proyeccion
uno= R'*([0,0,f]'-T'); % centro ccd

%figure
%surface(x2,y2,z2) 
surface('XData',x2,'YData',y2,...
        'ZData',z2,'CData',A,...
        'FaceColor','texturemap','EdgeColor','none');
axis([-Lx*1.25, Lx*1.25, -Ly*1.25, Ly*1.25, -Lx*1.25,Lx*1.25]) 
colormap gray
alpha 0.9
grid on
box on
daspect([1 1 1])

hold on %, uno(1)] ,uno(2) , uno(3)
scatter3([H(1,:), mundo(1,:), cero(1)], [H(2,:),mundo(2,:), cero(2)], [H(3,:),mundo(3,:), cero(3)],'r','LineWidth',2)

for ii=1:size(H,2)
    line([cero(1), H(1,ii)], [cero(2), H(2,ii)], [cero(3), H(3,ii)],'Color','blue')%,'LineWidth',2)
end

% surface(x,y,z) 
% shading flat
end


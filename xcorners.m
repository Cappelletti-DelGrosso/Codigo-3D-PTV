function [centros2, maj]=xcorners(im, s, Lx, Ly, dx ,dy, graf, mostrar)

[rx,ry] = gradient(im);
    
[rxx,rxy] = gradient(rx);
[~  ,ryy] = gradient(ry);

rxxb = imgaussfilt(rxx,s);
ryyb = imgaussfilt(ryy,s);
rxyb = imgaussfilt(rxy,s);

S = rxxb.*ryyb-rxyb.^2;

N=4;
T = size(S,2);
w = tukeywin(T,N*s/T);
w2D = w*w';

S=S.*w2D;

blureada = imgaussfilt(im,s);

sig=s; %sigma
xo=0;  %centro
yo=0;  %centro 

x = -Lx/2: 1 :Lx/2;
y = -Ly/2: 1 :Ly/2;

[X,Y]=meshgrid(x,y);
z= min(S(:))*exp(-((X-xo).^2 + (Y-yo).^2)./(2*sig^2));

u=xcorr2(S,z); 

u = u((Lx/2+1):(end-Lx/2),(Ly/2+1):(end-Ly/2));

BW = u>(-min(u(:)));

c=regionprops(BW,'centroid');

N=size(c,1);
centros=[];
for jj=1:N
    centros=[centros; c(jj).Centroid];
end

if graf==1
    figure
    imshow(BW)
    hold on
    scatter(centros(:,1), centros(:,2), 'ro ')
end
ajuste=[];

centros2=[];
for kk=1:size(centros,1)
    x0 = round(centros(kk,1));
    y0 = round(centros(kk,2));
    lado1 = (-dx+x0):(dx+x0);
    lado2 = (-dy+y0):(dy+y0);
    xcorner = blureada(lado2, lado1);
    x=1:(2*dx+1);
    y=1:(2*dy+1);  
    [X, Y] = meshgrid(x,y);
    [f, G] = fit( [X(:), Y(:)], xcorner(:), 'poly22' );
    ajuste = [ajuste; G.adjrsquare];
%          figure
%          scatter3(X(:), Y(:),f(X(:),Y(:)), 'ro ')
%          hold on
%          surf(xcorner)
    x1=(2*(f.p02)*(f.p10)-(f.p01)*(f.p11))/((f.p11)^2-4*(f.p20)*(f.p02));
    y1=(2*(f.p01)*(f.p20)-(f.p11)*(f.p10))/((f.p11)^2-4*(f.p20)*(f.p02));
    centros2=[centros2; x1-dx-1+x0, y1-dy-1+y0];      
end

if size(centros2,1)>0
    if mostrar==1
%      figure
%      imshow(im, [min(im(:)), max(im(:))])
     hold on
     scatter(centros2(:,1), centros2(:,2), 'ro ')
     hold on
     daspect([1 1 1])
    end
maj = mean(ajuste);
else
    maj=[];
end

end
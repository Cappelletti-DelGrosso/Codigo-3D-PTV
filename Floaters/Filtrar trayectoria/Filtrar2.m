N=length(curva3);
% T=[];
% Tf=[];
ax  = [];
ay  = [];
az  = [];
axf = [];
ayf = [];
azf = [];
vx  = [];
vy  = [];
vz  = [];
vxf = [];
vyf = [];
vzf = [];

for jj=1:N
    jj
    tXYZ=[[0:(1/(length(curva3{jj})-1)):1]',curva3{jj}];
    
    L = size(tXYZ,1);
    t = tXYZ(:,1);
    x = tXYZ(:,2);
    y = tXYZ(:,3);
    z = tXYZ(:,4);
    VXYZ= diff(tXYZ(:,2:4));

    W = 2*6;
    tic
    [XYZf, UVWf, ABCf] = FiltrarTrayectoria(tXYZ,W);
    toc

    xf = XYZf(:,1);
    yf = XYZf(:,2);
    zf = XYZf(:,3);
    
    vx  = [vx; VXYZ(:,1)] ;
    vy  = [vy; VXYZ(:,2)] ;
    vz  = [vz; VXYZ(:,3)] ;
    vxf = [vxf; UVWf(:,1)/L] ;
    vyf = [vyf; UVWf(:,2)/L] ;
    vzf = [vzf; UVWf(:,3)/L] ;
    
    AXYZ = diff(VXYZ) ;
    ax   = [ax;AXYZ(:,1)] ;
    ay   = [ay;AXYZ(:,2)] ;
    az   = [az;AXYZ(:,3)] ;
    axf  = [axf; ABCf(:,1)/L^2] ;
    ayf  = [ayf; ABCf(:,2)/L^2] ;
    azf  = [azf; ABCf(:,3)/L^2] ;
    
    XYZf=reshape(XYZf(~isnan(XYZf(:))),length(XYZf(~isnan(XYZf(:))))/3,3);
    curva4{jj}=XYZf;
end

vxf = vxf(abs(vxf)>=0) ;
vyf = vyf(abs(vyf)>=0) ;
vzf = vzf(abs(vzf)>=0) ;
GraficarA(vxf, vyf, vzf, 1)
GraficarA(vx, vy, vz, 1)

axf = axf(abs(axf)>=0) ;
ayf = ayf(abs(ayf)>=0) ;
azf = azf(abs(azf)>=0) ;
GraficarA(axf, ayf, azf, 2)
GraficarA(ax, ay, az, 2)

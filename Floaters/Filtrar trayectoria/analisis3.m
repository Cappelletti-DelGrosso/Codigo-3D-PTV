function [curvas]=analisis3(curva, f)
N=length(curva);
curvas={};

for kk=1:N
    kk
    tXYZ = curva{kk};
    clear trayetoria
      trayectoria.t = tXYZ(:,1);
      trayectoria.tv = (trayectoria.t(1:end-1)+trayectoria.t(2:end))/2;
      trayectoria.ta = (trayectoria.tv(1:end-1)+trayectoria.tv(2:end))/2;
      dt = diff(trayectoria.t);
    trayectoria.xyz = tXYZ(:,2:4);
    
      trayectoria.v = diff(trayectoria.xyz) ./ dt;
%        t2 = diff(curva{kk}(:,1))>min(diff(curva{kk}(:,1)));
      shutting = round(sum((diff(trayectoria.t)-max(diff(trayectoria.t)))<=-1E-4)/sum(abs(diff(trayectoria.t)-max(diff(trayectoria.t)))<1E-4))+1;
      
      shutting
      if shutting==2
      t1 = (diff(trayectoria.t)-max(diff(trayectoria.t)))<=-1E-4;
      trayectoria.v = trayectoria.v(t1,:);
      desp = diff(trayectoria.xyz);
      trayectoria.desp = desp(t1,:);                    %Desplazamiento tiempos cortos
      trayectoria.desp2 = desp(not(t1(1:end-1,:)),:);   %Desplazamiento tiempos largos
%        trayectoria.v2 = trayectoria.v(not(t1(1:end)),:);
      trayectoria.t = trayectoria.t(t1);
      trayectoria.xyz = trayectoria.xyz(t1,:);
      end
      if shutting==3
        t1= (diff(trayectoria.t)-max(diff(trayectoria.t)))<=-1E-4;
        trayectoria.v = trayectoria.v(t1,:);
        t2 = diff((diff(trayectoria.t)-max(diff(trayectoria.t)))<=-1E-4)==0;
        desp = diff(trayectoria.xyz);
        trayectoria.desp = desp(t1,:);
        trayectoria.desp2 = desp(not(t1(1:end-1,:)),:);
        trayectoria.t = trayectoria.t(t2);
        trayectoria.xyz = trayectoria.xyz(t2,:);
      end
      
      trayectoria.a = diff(trayectoria.v) / max(dt);
      if shutting==3
            t3=t1;
            t3(abs(diff(t1)+1)<1E-4)=0;
            t3=t3(t1);
          trayectoria.a = trayectoria.a(t3(1:end-1),:);
      end
      if f==1
      %W = round(size(trayectoria.xyz,1)*3/100)+mod(round(size(trayectoria.xyz,1)*3/100),2);
      W=18;
      [tXYZf, UVWf, ABCf]=FiltrarTrayectoria3([trayectoria.t,trayectoria.xyz], W);
      trayectoria.tf = tXYZf(:,1);
      trayectoria.xyzf = tXYZf(:,2:4);
      trayectoria.vf = UVWf;
      trayectoria.af = ABCf;
      end
      largocorr = round(length(trayectoria.v(:,1))/2);
      trayectoria.corrv = [autocorr(trayectoria.v(:,1),largocorr), autocorr(trayectoria.v(:,2),largocorr), autocorr(trayectoria.v(:,3),largocorr)];
      largocorr2 = round(length(trayectoria.a(:,1))/2);
      trayectoria.corra = [autocorr(trayectoria.a(:,1),largocorr2), autocorr(trayectoria.a(:,2),largocorr2), autocorr(trayectoria.a(:,3),largocorr2)];

        % trayectoria.corrv = [autocorr(trayectoria.v(:,1)), autocorr(trayectoria.v(:,2)), autocorr(trayectoria.v(:,3))];      
if shutting==1
    for ii=1:3
        vint = interp1(trayectoria.tv,trayectoria.v,trayectoria.ta,'spline');
    end
    trayectoria.vint= vint;
    trayectoria.dEdt = sum(trayectoria.vint.*trayectoria.a, 2);
end
if f==1
    n1 = find(abs(trayectoria.t-trayectoria.tf(1))<1E-4,1,'first') ;
    n2 = find(abs(trayectoria.t-trayectoria.tf(end))<1E-4,1,'first') ;
    errorv = (trayectoria.v(n1:n2,:)-trayectoria.vf)./trayectoria.vf ;
    trayectoria.errorv = errorv ;
end

curvas ={curvas{:}, trayectoria};
    
end

end
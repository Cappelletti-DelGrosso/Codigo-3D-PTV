function []=clustering(pref,plot_flag)

% pref = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\5';
dircodigo=cd;
Fs=120;
load([pref '\Curva5.mat']);
curva2 = curva5; clear curva5

% load([pref '/CurvaUnida2.mat']);
areas = [];
cant= [];

for jj=0:1*(1/Fs):22
    jj
    % target_time = 0.5583;
    target_time = jj;
    tolerance   = 0.005;
    
    xyz = [];
    kk  = 0;
    
    for ii=1:size(curva2,2)
        idx = find( abs(curva2{ii}(:,1)-target_time)<tolerance, 1,'first');
        if ~isempty(idx)
            kk = kk + 1;
            xyz(kk,1) = curva2{ii}(idx,2);
            xyz(kk,2) = curva2{ii}(idx,3);
            xyz(kk,3) = curva2{ii}(idx,4);
        end
    end
    NumParts = kk;
    
    % Points in 2D projection
    %     figure(3)
    %     plot(xx,yy,'bo')
    %     daspect([1 1 1])
    %     grid on
    %     title(num2str(NumParts));
    %     axis([-300 300 -200 200])
    %     drawnow
    
    if NumParts>5
        xx = xyz(:,1);
        yy = xyz(:,2);
        zz = xyz(:,3);
        tri = delaunay(xx,yy);
        
        centro=mean([xx,yy]);
    
    
        areas_new = triangle_area(tri,xx,yy);

        lado = sqrt(sum(areas_new));
        puntos_random = [rand(NumParts,1)*lado/2+centro(1), rand(NumParts,1)*lado/2+centro(2)];
        areas = [areas ; areas_new]; clear areas_new;
       
        
        if plot_flag ==1
            % Delaunay triangulation in 2D
            figure(5);
            line([centro(1)-lado/2, centro(1)+lado/2],[centro(2)-lado/2, centro(2)+lado/2],'Color','red','LineStyle','-')
            hold on
            plot(xx,yy,'ro'); hold on;
            scatter(puntos_random(:,1),puntos_random(:,2),'bx')
            triplot(tri,xx,yy); hold off;
            daspect([1 1 1])
            grid on
            title(num2str(NumParts));
            axis([-350 350 -200 200])
            drawnow
        end
    
    else
       disp('Menos de 10 partículas.') 
    end
    cant=[cant;jj, NumParts];
    
end

Nhist = sqrt(length(areas));
% Nhist = 40;

% [na, xa] = hist(areas, Nhist);
xa = linspace(0.025,5,Nhist);
na = hist(areas,xa);

aa = mean(areas)^2/std(areas)^2;
ba = mean(areas)/std(areas)^2;

Avar = linspace(min(xa),max(xa),1000);
% distribucion gamma
Pa = ba^aa/gamma(aa)*Avar.^(aa-1).*exp(-ba*Avar);

% renormalizamos para que las integrales den lo mismo
dA = mean(diff(Avar));
dx = mean(diff(xa));
sumP = sum(Pa(:)*dA);
sumN = sum(na(:)*dx);
na = na/sumN*sumP;

% para areas
figure(6);
semilogy(xa,na,'*');
hold on
semilogy(Avar, Pa,'k--');
hold off
grid on
title('estadistica areas')
xlabel('Area [u.a.]');
ylabel('PDF(Area)');
drawnow

cd(pref)
save('Areas','xa','na','cant','areas')
cd(dircodigo)
end

function [cluster2]=clusterframes(pref,plot_flag, Ac)

% pref = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\5';

dircodigo = cd  ;
Fs        = 120 ;
load([pref '\Curva5.mat']) ;
curva2 = curva5 ; clear curva5

cant = [] ;

for jj = 0:1*(1/Fs):20
    jj
    target_time = jj;
    tolerance   = 0.005;
    
    xyziin = [];
    kk  = 0;
    
    for ii=1:size(curva2,2)
        idx = find( abs(curva2{ii}(:,1)-target_time)<tolerance, 1,'first');
        if ~isempty(idx)
            kk = kk + 1;
            xyziin(kk,1) = curva2{ii}(idx,2);
            xyziin(kk,2) = curva2{ii}(idx,3);
            xyziin(kk,3) = curva2{ii}(idx,4);
            xyziin(kk,4) = ii;
            xyziin(kk,5) = idx;
        end
    end
    NumParts = kk;
        
    if NumParts>5
        xx = xyziin(:,1);
        yy = xyziin(:,2);
        zz = xyziin(:,3);
        tri = delaunay(xx,yy);
        
       
        [areas_new, ~] = triangle_area(tri,xx,yy);

            % Delaunay triangulation in 2D
        figure(5);
        clear cluster
        [cluster, clusterid]=encontrarcluster([xx, yy], tri, areas_new, Ac, plot_flag,xyziin(:,4:5) );
        
        cluster2{round(jj*Fs+1)}= clusterid ;
        
        if plot_flag ==1
            title(num2str(NumParts));
            drawnow
            length(clusterid)
%             if length(clusterid)>2
%                 pause
%             end
        if jj==11.9
            stop
        end
        end
        
    else
       disp('Menos de 10 partículas.') 
       cluster2{jj*Fs, :}= {} ;
    end
    cant=[cant;jj, NumParts];
    
end


end
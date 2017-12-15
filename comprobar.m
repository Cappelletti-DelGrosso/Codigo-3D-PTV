function [N, MM1]=comprobar(camara, dirimagenes)

% clear all
% close all

% dirimagenes = 'C:\Users\Nicolás\Desktop\07-06-2017\Damero\';
codigos= cd;
cd(dirimagenes)

% camara=1
puntos = dir([dirimagenes,'\Puntos',num2str(camara),'\*C',num2str(camara),'S0001.tif.csv']);

N=length(puntos);
maxerrores1=[];
maxerrores2=[];

for ii=1:N
    ii;
    imagen= double(puntos(ii).name);
    imagen= char(imagen(1:(end-4)));
    B=dlmread([dirimagenes,'Puntos',num2str(camara),'\',puntos(ii).name],';',1,0);
    
    error1=[];
    for jj=1:6
        n=(jj-1)*9+1;
        v=[n:(n+8)];
        [f, G] = fit( B(v,1), B(v,2), 'poly1' );
        error1=[error1; sqrt(G.sse/9)];
%         scatter(B(v,1),B(v,2))
%         hold on
%         pause
    end
    m1 = min(error1);
    [M1, indice1] = max(error1);
    M1;
    
%     error2=[];
%     for jj=1:9
%         v=[];
%         for kk=1:6
%             v = [v, (kk-1)*9+jj];
%         end
%         [f, G] = fit( [B(v,1), B(v,2)],zeros(size(B(v,1))), 'poly11' );
%         error2=[error2; sqrt(G.sse/6)];
% %         scatter(B(v,1),B(v,2))
% %         hold on
% %         pause
%     end
%     m2 = min(error2);
%     [M2, indice2] = max(error2);
%     M2
    
    if M1>4
        disp('La imagen está mal numerada.')
        n=(indice1-1)*9+1;
        v=[n:(n+8)];
        [f, G] = fit( B(v,1), B(v,2), 'poly1' );
        G
        scatter(B(v,1), B(v,2))
        axis([0 1024 0 1024])
        daspect([1,1,1])
        stop
    end
    
%     if M2>10
%         disp('La imagen está mal numerada.')
%         v=[];
%         for kk=1:6
%             v = [v, (kk-1)*9+indice2];
%         end
%         v
%         [f, G] = fit( B(v,1), B(v,2), 'poly1' );
%         G
%         scatter(B(v,1), B(v,2),'b')
%         axis([0 1024 0 1024])
%         hold on
%         plot(B(v,1),f(B(v,1)),'r')
%         daspect([1,1,1])
%         stop
%     end
    
    maxerrores1 = [maxerrores1; M1];
    MM1 = max(maxerrores1);
    
    D = diff(B);
    umbral = (max(D(:,1))+min(D(:,1)))/2;
    s = sum(D(:,1)<umbral)
    if s ~= 5
        ii
        disp('La imagen está mal numerada.')
        cd(codigos)
        mirar(camara, dirimagenes, ii)
        cd(dirimagenes)
        %stop
    end
    
%     maxerrores2 = [maxerrores2; M2];
%     MM2 = max(maxerrores2);
end
cd(codigos)
end
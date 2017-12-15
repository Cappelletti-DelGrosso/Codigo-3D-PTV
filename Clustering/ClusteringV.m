%%Funcion que dado cluster2 devuelve las velocidades adimensionalizadas
%%para cada cluster para cada tiempo
clear all
close all

load(['C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\3','\Curva5.mat'])
dircodigo= cd;
cd('C:\Users\Nicolás\Desktop\Labo 6\Codigo\Github\Floaters\Filtrar trayectoria')
[curvas]=analisis(curva5, 0)
cd(dircodigo)
[cluster2]=clusterframes('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\3', 0, 0.26)

v=[];
for ii=1:length(cluster2)
    clf;
    for kk=1: length(cluster2{ii})
        vc = [];
        txyzc = [];
        indice=cluster2{ii}{kk};
        for jj=1:size(indice,1)
            vp=curvas{indice(jj,1)}.vint;
            if and(indice(jj,2)-1>=1, indice(jj,2)-1<=size(vp, 1))
                vc=[vc; vp(indice(jj,2)-1, :)];
            end
            txyzp=[curvas{indice(jj,1)}.t, curvas{indice(jj,1)}.xyz];
            txyzc=[txyzc; txyzp(indice(jj,2),:)];
%             figure(1)
%             scatter(txyzc(:,2),txyzc(:,3))
%             axis([-350 350 -200 200])
%             title(num2str(ii)) 
%               grid on
        end
        v=[v; (vc-mean(vc))./std(vc)];
    end
%     drawnow
end
% v2 = sqrt(sum(v.^2,2));
v2 = v(:,2);
 [PDFN, N]=hist((v2-mean(v2))./std(v2), sqrt(length(v2))/2)
DN    = diff(N);
sn    = sum(DN.*PDFN(1:(end-1)));
PDFN = PDFN/sn;
a1= 1/sqrt(2*pi);
b1=0;
c1=sqrt(2);
figure;
semilogy(N, a1*exp(-((N-b1)/c1).^2),'Color','k', 'LineWidth', 3)
grid on
hold on
semilogy(N,PDFN,'r')


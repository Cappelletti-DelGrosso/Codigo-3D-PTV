% clear all
close all

load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\1\Particulas.mat')
[trayectorias]=trayectoria(particulas);
figure;
for camara=1:2
        cont=0;
        for ii=1:size(trayectorias,1)

            if size(trayectorias{ii,camara},1)>50
                cont=cont+1;
                
                trayectorias2{cont, camara}=trayectorias{ii,camara};
                subplot(1,2,camara)
                plot(trayectorias2{cont, camara}(:,1), trayectorias2{cont, camara}(:,2))
                hold on
                xlabel('Pixels');
                ylabel('Pixels');
                daspect([1,1,1])
                axis([0 1024 0 1024])
                grid on
                title(['Camara ',num2str(camara)])
                set(gca,'fontsize',16)
                %pause
            end
        end
end

vp1=[];
vp2=[];
for ii=1:size(trayectorias2, 1)
    if ~isempty(trayectorias2{ii,1})
        vp1=[vp1; sqrt(sum(diff(trayectorias2{ii,1}(:,1:2)).^2, 2))];
    end
    if ~isempty(trayectorias2{ii,2})
        vp2=[vp2; sqrt(sum(diff(trayectorias2{ii,2}(:,1:2)).^2, 2))];
    end
end
[mean(vp1),mean(vp2)]
vp{1}=vp1;
vp{2}=vp2;

figure
for camara=1:2
    [PDFV, V]=hist(vp{camara}, sqrt(length(vp{camara})));
    DV    = diff(V);
    sv    = sum(DV.*PDFV(1:(end-1)));
    PDFV = PDFV/sv;
    plot(V, PDFV,'LineWidth',3)
    hold on
    clear PDFV V DV sv
end

grid on
axis([0 6 0 0.9])
xlabel('Distancia [Pixels]')
ylabel('PDF')
legend('Camara 1', 'Camara 2')
set(gca,'fontsize',16)



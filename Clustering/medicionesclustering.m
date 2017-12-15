clear all
close all

direcciones{1}='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 5\';
direcciones{2}='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 10\';
direcciones{3}='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 15\';
direcciones{4}='C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Mediciones\SingleShutting 120 Hz Amplitud 20\';

% for kk=1:4
%     parfor ii=1:7
%        clustering2([direcciones{kk},num2str(ii),'\'], 0)
%     end
% end

amplitudes=[5,10,15,20];
L=zeros(7,4);
areas3=cell(1,4);
areas4=cell(1,4);

for kk=1:4
    figure(kk)
    
    for ii=1:7
        cd([direcciones{kk},num2str(ii),'\'])
        load('Areas')
        areas3{kk}=[areas3{kk}; areas];
        areas4{kk}=[areas4{kk}; areas2];
        L(ii,kk)=length(xa);
%         semilogy(xa,na,'o','Color',[0, 114, 187]/300,'MarkerSize',1)
%         grid on
%         title(['Estadística áreas A=',num2str(amplitudes(kk))])
%         xlabel('Area [u.a.]');
%         ylabel('PDF(Area)');
% 
%         hold on
        clear xa na
    end
end
m=min(L);
M=max(L);
aes1=zeros(7,4);
aes2=[];
bes2=[];
aes4=[];
bes4=[];


for kk=1:4
    clear xa1 na1
    xas = linspace(0.025,5,M(kk));
    xa1=[];
    na1=[];
    xa3=[];
    na3=[];

    for ii=1:7
        cd([direcciones{kk},num2str(ii),'\'])
        load('Areas')
        aes1(ii,kk) = mean(areas)^2/std(areas)^2;
        naint(ii,:) = interp1(xa,na,xas,'spline');
        xa1=[xa1; xa'];
        na1=[na1; na'];
        xa3=[xa3; xa2'];
        na3=[na3; na2'];

        clear xa na xa2 na2
    end
        
        areas=areas3{kk};
        areas5=areas4{kk};
        
        figure(kk)
        semilogy(xa1,na1,'o','MarkerEdgeColor',[0, 114, 187]/300,'MarkerFaceColor',[0, 114, 187]/300,'MarkerSize',1)
        grid on
        title(['Estadística áreas A=',num2str(amplitudes(kk))])
        xlabel('Area [u.a.]');
        ylabel('PDF(Area)');

        hold on
        semilogy(xa3,na3,'gs','MarkerSize',1)

        na=mean(naint);
        aa = mean(areas)^2/std(areas)^2;
        ba = mean(areas)/std(areas)^2;
        
        aes2 = [aes2; aa];
        bes2 = [bes2; ba];

        Avar = linspace(min(xas),max(xas),1000);
        % distribucion gamma
        Pa = ba^aa/gamma(aa)*Avar.^(aa-1).*exp(-ba*Avar);

        % renormalizamos para que las integrales den lo mismo
        dA = mean(diff(Avar));
        dx = mean(diff(xas));
        sumP = sum(Pa(:)*dA);
        sumN = sum(na(:)*dx);
        na = na/sumN*sumP;

        % para areas
%         na=mean(naint);
%         aa = mean(areas)^2/std(areas)^2;
%         ba = mean(areas)/std(areas)^2;
%         
%         aes2 = [aes2; aa];
%         Avar = linspace(min(xas),max(xas),1000);
%         % distribucion gamma
%         Pa = ba^aa/gamma(aa)*Avar.^(aa-1).*exp(-ba*Avar);
% 
%         % renormalizamos para que las integrales den lo mismo
%         dA = mean(diff(Avar));
%         dx = mean(diff(xas));
%         sumP = sum(Pa(:)*dA);
%         sumN = sum(na(:)*dx);
%         na = na/sumN*sumP;

        %%% Sinteticas
        Nhist4 = sqrt(length(areas5));
        xa4 = linspace(0.025,5,Nhist4);
        na4 = hist(areas5,xa4);
        
        aa4 = mean(areas5)^2/std(areas5)^2;
        ba4 = mean(areas5)/std(areas5)^2;
        
        aes4=[aes4; aa4];
        bes4=[bes4; ba4];
        
        Avar4 = linspace(min(xa4),max(xa4),1000);
        % distribucion gamma
        Pa4 = ba4^aa4/gamma(aa4)*Avar4.^(aa4-1).*exp(-ba4*Avar4);

        % renormalizamos para que las integrales den lo mismo
        dA4 = mean(diff(Avar4));
        dx4 = mean(diff(xa4));
        sumP4 = sum(Pa4(:)*dA4);
        sumN4 = sum(na4(:)*dx4);
        na4 = na4/sumN4*sumP4;
% 
%         % para areas
%         na=mean(naint);
%         aa = mean(areas)^2/std(areas)^2;
%         ba = mean(areas)/std(areas)^2;
%         
%         aes2 = [aes2; aa];
%         Avar = linspace(min(xas),max(xas),1000);
%         % distribucion gamma
%         Pa = ba^aa/gamma(aa)*Avar.^(aa-1).*exp(-ba*Avar);
% 
%         % renormalizamos para que las integrales den lo mismo
%         dA = mean(diff(Avar));
%         dx = mean(diff(xas));
%         sumP = sum(Pa(:)*dA);
%         sumN = sum(na(:)*dx);
%         na = na/sumN*sumP;

        
        
        hold on
        semilogy(xas,na,'-','LineWidth',3,'Color',[255, 102, 0]/255)
        hold on
%         semilogy(xa4,na4,'-m','LineWidth',3)
        semilogy(Avar, Pa,'k-','LineWidth',3);
        semilogy(Avar4, Pa4,'m--','LineWidth',3);

        legend('Mediciones', 'Sintéticos','Promedio', 'Ajuste Gamma Mediciones','Ajuste Gamma Sintéticos')
        clear naint xa na xas
end

figure; errorbar(amplitudes, aes2, std(aes1))
hold on
pp = sum(aes2'./std(aes1))/sum((std(aes1)).^-1);
line([min(amplitudes), max(amplitudes)],[pp,pp],'Color','red','LineStyle','--')
xlabel('Amplitud del Forzado');
ylabel('a');
set(gca,'fontsize',16)
grid on
legend('Ajustes','Promedio Ponderado')

clearvars -except bes2 aes2 bes4 aes4 direcciones
for ii=1:4
Areac(ii) = ((bes2(ii)^aes2(ii)*gamma(aes4(ii)))/(bes4(ii)^aes4(ii)*gamma(aes2(ii))))^(1/(aes4(ii)-aes2(ii)));

for kk=1:1
[cluster2]=clusterframes([direcciones{kk},num2str(ii),'\'], 0, Areac(ii))
end
end

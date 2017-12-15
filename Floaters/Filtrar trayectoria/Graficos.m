exyz = [] ;
ev   = [] ;
ea   = [] ;
a    = [] ;
af   = [] ;
v    = [] ;
vf   = [] ;
z    = [] ;
desp=[];
desp2=[];
corrv=zeros(26,3) ;
largocorr=[];
for kk = 1:length(curvas)
    trayectoria1=curvas{kk};
    letras=[string(' X'), string(' Y'), string(' Z')];

%     figure; 
%     for ii=1:3
%         subplot(1,3,ii)
%         plot(trayectoria1.t, trayectoria1.xyz(:,ii))
%         hold on
%         plot(trayectoria1.tf, trayectoria1.xyzf(:,ii))
%         legend('Medida', 'Filtrada')
%         xlabel({'Tiempo [s]'},'FontSize', 16)
%         ylabel({strcat(strcat('Posición',letras(ii)),' [mm]')},'FontSize', 16)
%         set(gca,'fontsize',16)
%     end
% 
%     figure; 
%     for ii=1:3
%         subplot(1,3,ii)
%         plot(trayectoria1.t(1:end-1), trayectoria1.v(:,ii))
%         hold on
%         plot(trayectoria1.tf, trayectoria1.vf(:,ii))
%         legend('Medida', 'Filtrada')
%         xlabel({'Tiempo [s]'},'FontSize', 16)
%         ylabel({strcat(strcat('Velocidad',letras(ii)),' [mm/s]')},'FontSize', 16)
%         set(gca,'fontsize',16)
%     end
% 
%     figure; 
%     for ii=1:3
%         subplot(1,3,ii)
%         plot(trayectoria1.t(1:end-2), trayectoria1.a(:,ii))
%         hold on
%         plot(trayectoria1.tf, trayectoria1.af(:,ii))
%         legend('Medida', 'Filtrada')
%         xlabel({'Tiempo [s]'},'FontSize', 16)
%         ylabel({strcat(strcat('Aceleración',letras(ii)),' [mm/s^2]')},'FontSize', 16)
%         set(gca,'fontsize',16)
%     end
    
    
%     exyz = [ exyz; curvas{kk}.exyz] ;
%     ev   = [ ev;   curvas{kk}.ev  ] ;
%     ea   = [ ea;   curvas{kk}.ea  ] ;
%     
    v  = [v; curvas{kk}.v] ;
%     vf = [vf; curvas{kk}.vf] ;
    
    a  = [a; curvas{kk}.a] ;
%     af = [af; curvas{kk}.af] ;
    
    z  = [z; curvas{kk}()];
    
%     desp  = [desp; curvas{kk}.desp] ;
%     desp2  = [desp2; curvas{kk}.desp2] ;
%     corrv = corrv+curvas{kk}.corrv(1:13,:);
        largocorr = [largocorr, size(curvas{kk}.corrv,1)];
end

corrv=corrv/length(curvas);
figure;
    plot(curvas{1}.t(1:length(corrv)),corrv,'o-')
    legend('Velocidad X', 'Velocidad Y','Velocidad z')
    xlabel({'Tiempo [s]'},'FontSize', 16)
    ylabel({'Correlacion'},'FontSize', 16)
    set(gca,'fontsize',16)

% figure;
% for ii=1:3
%     subplot(1,3,ii)
%     [PDFE(:,ii), E(:,ii)]=hist(exyz(:,ii), sqrt(length(exyz(:,ii))));
%     semilogy(E(:,ii), PDFE(:,ii),'bo-')
%     ylabel({strcat('PDF Error Posición',letras(ii))},'FontSize', 16)
% end
% 
% figure;
% for ii=1:3
%     subplot(1,3,ii)
%     [PDFEV(:,ii), EV(:,ii)]=hist(ev(:,ii), sqrt(length(ev(:,ii))));
%     semilogy(EV(:,ii), PDFEV(:,ii),'bo-')
%     ylabel({strcat('PDF Error Velocidad',letras(ii))},'FontSize', 16)
% end
% 
% figure;
% for ii=1:3
%     subplot(1,3,ii)
%     [PDFEA(:,ii), EA(:,ii)]=hist(ea(:,ii), sqrt(length(ea(:,ii))));
%     semilogy(EA(:,ii), PDFEA(:,ii),'bo-')
%     ylabel({strcat('PDF Error Aceleración',letras(ii))},'FontSize', 16)
% end

Fs = 120;
a = (a-mean(a))./std(a) ;
v = (v-mean(v))./std(v) ;
af = (af-mean(af))./std(af) ;
vf = (vf-mean(vf))./std(vf) ;
energia = v.^2;

figure;
for ii=1:3
      [PDFV(:,ii), V(:,ii)] = hist(v(:,ii), sqrt(length(v(:,ii)))) ;
    DV    = diff(V(:,ii));
    sv    = sum(DV.*PDFV(1:(end-1),ii));
    PDFV(:,ii) = PDFV(:,ii)/sv;   
    
    semilogy(V(:,ii), PDFV(:,ii),'o-')
    ylabel({strcat('PDF Velocidad')},'FontSize', 16)
    hold on
end
 axis([-400 400 1E-3 1E1])
a1= 1/sqrt(2*pi);
    b1=0;
    c1=sqrt(2);
    semilogy(V(:,ii), a1*exp(-((V(:,ii)-b1)/c1).^2),'Color','k', 'LineWidth', 1)
    
    
    figure;
for ii=1:3
      [PDFA(:,ii), A(:,ii)] = hist(a(:,ii), sqrt(length(a(:,ii)))) ;
    DA    = diff(A(:,ii));
    sa    = sum(DA.*PDFA(1:(end-1),ii));
    PDFA(:,ii) = PDFA(:,ii)/sa;   
    
    semilogy(A(:,ii), PDFA(:,ii),'o-')
    ylabel({strcat('PDF Aceleración')},'FontSize', 16)
    hold on
end
axis([-7 7 1E-4 1])
a1= 1/sqrt(2*pi);
    b1=0;
    c1=sqrt(2);
    semilogy(A(:,ii), a1*exp(-((A(:,ii)-b1)/c1).^2),'Color','k', 'LineWidth', 3)


    
     figure;
for ii=1:3
      [PDFAF(:,ii), AF(:,ii)] = hist(af(:,ii), sqrt(length(af(:,ii)))) ;
    DAF    = diff(AF(:,ii));
    saf    = sum(DAF.*PDFAF(1:(end-1),ii));
    PDFAF(:,ii) = PDFAF(:,ii)/saf;   
    
    semilogy(AF(:,ii), PDFAF(:,ii),'o-')
    ylabel({strcat('PDF AceleraciónFiltrada')},'FontSize', 16)
    hold on
end
axis([-7 7 1E-4 1])
a1= 1/sqrt(2*pi);
    b1=0;
    c1=sqrt(2);
    semilogy(AF(:,ii), a1*exp(-((AF(:,ii)-b1)/c1).^2),'Color','k', 'LineWidth', 3)

   
[ex, fex]  = pwelch(energia(:,1),[],[],[],120,'onesided') ; 
[ey, fey]  = pwelch(energia(:,2),[],[],[],120,'onesided') ; 
[ez, fez]  = pwelch(energia(:,3),[],[],[],120,'onesided') ; 

[m, id]=min(abs(fex-13.8))

figure; loglog(fex(1:id), ex(1:id),'x',...
    'MarkerSize',4)
hold on; loglog(fey(1:id), ey(1:id),'+',...
    'MarkerSize',4)
hold on; loglog(fez(1:id), ez(1:id),'s',...
    'MarkerSize',4)
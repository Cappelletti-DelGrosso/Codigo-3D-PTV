clear all
close all

direccion      = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\12-09-17\Superficie libre\';
dirparametros  = 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\01-09-17\Damero\Parámetros Montaje Completo.mat';
dirfloaters    = cd;
frecuencia = 120;

tic
[particulas, flot, frames, fc]=circulos2(direccion);
toc
% 2726 frames en 1 hora
cd(direccion)
save('Particulas', 'particulas')
cd(dirfloaters)

% imagenes(particulas, flot, direccion, frames, fc);

% cd ..
% cd('Correspondencia')
% [candidatos1, candidatos2]=correspondencia(particulas{200,1}', particulas{200,2}', im1, dirparametros, 1)
% cd(dirfloaters)


[trayectorias]=trayectoria(particulas);

largo3= cellfun(@(x) size(x,1), trayectorias);
for camara=1:2
    figure; hist(largo3((largo3(:,camara)>20),camara), sqrt(length(largo3(:,camara))))
    title(['Histograma largo trayectorias, camara ',num2str(camara)])
end

figure
for camara=1:2
    cont=0;
    for ii=1:size(trayectorias,1)
        
        if size(trayectorias{ii,camara},1)>50
            cont=cont+1;
            trayectorias2{cont, camara}=trayectorias{ii,camara};
            subplot(1,2,camara)
            plot(trayectorias2{cont, camara}(:,1), trayectorias2{cont, camara}(:,2))
            hold on
            daspect([1,1,1])
            axis([0 1024 0 1024])
%             pause
        end
    end
    
end

%Dura 9856 s= 3 horas
load('C:\Users\Nicolás\Desktop\Fmatlab.mat')
F=fLMedS;
tic
[curva, resultados]=nuevacorrespon(trayectorias2, dirparametros,F);
toc
%
cd(direccion)
save('Curva', 'curva')
cd(dirfloaters)

largo4 = [];
X=[];
Y=[];
Z=[];
cont=0;
for kk=1:length(curva)
    L=size(curva{kk},1);
    largo4 = [largo4; L];
    if L>50
        cont=cont+1;
        curva2{cont}=curva{kk};
        X=[X; curva{kk}(:,1)];
        Y=[Y; curva{kk}(:,2)];
        Z=[Z; curva{kk}(:,3)];
    end
end

cd ..
cd('Presentacion')
[R, centro]=rotacion(X,Y,Z);
cd(dirfloaters)

saltos=[];
vx=[];
vy=[];
vz=[];
ax=[];
ay=[];
az=[];
for kk=1:length(curva2)
    kk
    curva3{kk}(:,1) = curva2{kk}(:,4)/frecuencia ;
    curva3{kk}(:,2:4) = (R*((curva2{kk}(:,1:3)-centro)'))';
    vx = [vx; diff(curva3{kk}(:,1))*frecuencia];
    ax=[ax; diff(diff(curva3{kk}(:,1)))*frecuencia^2];
    vy = [vy; diff(curva3{kk}(:,2))*frecuencia];
    ay=[ay; diff(diff(curva3{kk}(:,2)))*frecuencia^2];
    vz = [vz; diff(curva3{kk}(:,3))*frecuencia];
    az=[az; diff(diff(curva3{kk}(:,3)))*frecuencia^2];
    saltos = [saltos; sqrt((vx).^2+(vy).^2+(vz).^2)/frecuencia];
end

cd(direccion)
save('Vel, ac, salt', 'vx', 'ax','vy', 'ay','vz', 'az', 'saltos')
cd(dirfloaters)

ver(curva3)

[PDFVX, VX]=hist(vx, sqrt(length(vx)));
[PDFAX, AX]=hist(ax, sqrt(length(ax)));
figure; plot(VX, PDFVX)
title('PDF Velocidad X')
figure; plot(AX, PDFAX)
title('PDF Aceleración X')

[PDFVY, VY]=hist(vy, sqrt(length(vy)));
[PDFAY, AY]=hist(ay, sqrt(length(ay)));
figure; plot(VY, PDFVY)
title('PDF Velocidad Y')
figure; plot(AY, PDFAY)
title('PDF Aceleración Y')

[PDFVZ, VZ]=hist(vz, sqrt(length(vz)));
[PDFAZ, AZ]=hist(az, sqrt(length(az)));
figure; plot(VZ, PDFVZ)
title('PDF Velocidad Z')
figure; plot(AZ, PDFAZ)
title('PDF Aceleración Z')
%%
S=[mean(vx), mean(vy),mean(vz); std(vx),std(vy),std(vz); mean(ax), mean(ay),mean(az); std(ax),std(ay),std(az)];
nombres=[string(' <V> '); string(' <V^2>^0.5 '); string(' <A> '); string(' <A^2>^0.5 ')];
[string(' '), string('     X          Y          Z');nombres, num2str(S,3)]
%%
[PDFsalt, salt]=hist(saltos, 50);
figure; semilogy(salt,PDFsalt)



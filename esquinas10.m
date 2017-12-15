function []=esquinas10(camara, direccion)
% camara = 2 ;   %camara a analizar
pix = [20E-3; 17E-3]; %tamaño del pixel del sensor
lado=25.4;
largo=9;
ancho=6;

codigos=cd;

% direccion='C:\Users\Nicolás\Desktop\07-06-2017\Damero\';
fondo = dir([direccion,'Fondo blanco\*C',num2str(camara),'S0001.tif']);
fc = double(imread([direccion,'Fondo blanco\',fondo.name]));

ajustesmedios = [];
archivos = dir([direccion,'Damero\*C',num2str(camara),'S0001.tif']);

Narch = numel(archivos)

cd(direccion)
P=['Puntos', num2str(camara)];
D=dir;
for kk=1:length(D)
    nombre=double(D(kk).name);
    if length(nombre)==length(P)
        if nombre==double(P)
            disp('Error: La carpeta ya existe')
            stop
        end
    end
end
    
mkdir(P)
cd(codigos)


dx = 8;     %Tamaño del pedacito a ajustar alrededor de un xcorner
dy = 8;
Lx = 20;      %Tamaño gaussiana con que correlacionamos
Ly = 20;
s = 4;      %Sigma de la gaussiana de blureado
cont=0;

for ii=1:Narch%Narch2%Narch1+1:Narch1+2
    ii
    archivos(ii).name
    im = imread([direccion,'Damero\',archivos(ii).name]);%-Narch1).name]);   
    im = double(im(:,:,1))-fc;
%     figure
%     imagesc(im)
%     colorbar
%     daspect([1,1,1])
    
    [centros2, maj]=xcorners(im, s, Lx, Ly, dx ,dy, 0, 0);   %Encontrar los xcorners
    
%     hold on
    ajustesmedios = [ajustesmedios; maj];
%     pause(1)
    %close all
    
    if size(centros2, 1)==largo*ancho
        cont=cont+1;
        cd('Numerar')
        [Vi(:,:,cont), n, m]=numerar(centros2, 0); %ordenar los xcorners
        
%         plot(Vi(1,:,cont), Vi(2,:,cont), 'g')
%         pause(3)
        cd([direccion,'\',P])
        filename = [archivos(ii).name,'.csv'] ;

        fid = fopen(filename, 'w');
        fprintf(fid, ['Imagen: ', archivos(ii).name, '\n']);
        fclose(fid);

        A=Vi(1:2,:,cont)';

        dlmwrite(filename, A,  '-append','delimiter',';');
        cd(codigos)
        
    else
        disp('Error: No se detectaron todos los puntos.')
    end
    close all
 end
 end    

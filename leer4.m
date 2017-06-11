function []=leer4(camara, direccion, comienzo, final1, final2)

%ejemplo: camara=1; direccion='C:\Users\Nicolás\Desktop\07-06-2017\Damero\'; comienzo=1; final1=80; final2=80;

puntos = dir([direccion,'\Puntos',num2str(camara),'\*C',num2str(camara),'S0001.tif.csv']);
n=9;
m=6;
pix = [20E-3; 17E-3]; %tamaño del pixel del sensor
lado=25.4;
Npuntos=length(puntos)
agregarN = final2-final1+1;

 [y, x] = meshgrid(1:m,1:n);
      H = lado*[x(:)'-round(n/2);y(:)'-round(m/2)];
rechazadas=[];
imagenesrechazadas=[];
for jj=1:agregarN 
    jj
    
    final    = final1+(jj-1) ;
    buenas=ones(1, final-comienzo+1);
    buenas(rechazadas)=0;
    cont=0;
    for kk=1:(final-comienzo+1)

        if buenas(kk)==1
            cont=cont+1;
            B=dlmread([direccion,'\Puntos',num2str(camara),'\',puntos(kk+comienzo-1).name],';',1,0);
            auxWi(:,:,cont)=[B'; ones(1,size(B,1))];          
        end

    end     

    codgo=cd;
    cd('Zhang')
    [ A3, R3, T3, k3, R4, T4, F3 ] = zhan6( H, auxWi );
    cd ..

    focal = [A3(1,1), A3(2,2)]*pix(camara)
    L=jj-length(rechazadas);

    if jj==1
        f(L,1)=focal(1);
        f(L,2)=focal(2);
        U0(L)=A3(1,3);
        V0(L)=A3(2,3); 
        A=A3;
            R=R3;
            T=T3;
            k=k3;
            F=F3;
            clear Vi
            Vi=auxWi;
            indice= comienzo:final;
            indice=indice(buenas>0.5);
            imagenesbuenas= char(puntos(indice).name);
    end

    if jj>1
        if abs(focal(1)-focal(2))>3 || abs(focal(1)-f(L-1,1))>3 || A3(1,3)<200 || A3(2,3)<200 || std(F3)>5 || A3(1,3)>1000 || A3(2,3)>1000 || abs(A3(1,3)-U0(L-1))>100 || abs(A3(2,3)-V0(L-1))>100
           
                abs(focal(1)-focal(2))
                abs(focal(1)-f(L-1,1))
                final-comienzo+1
                rechazadas=[rechazadas; final-comienzo+1];
                imagenesrechazadas=[imagenesrechazadas; puntos(final).name]
                fR(jj,1)=focal(1);
                fR(jj,2)=focal(2);
                U0R(jj)=A3(1,3);
                V0R(jj)=A3(2,3);
                %pause
      
        else
            f(L,1)=focal(1);
            f(L,2)=focal(2);
            U0(L)=A3(1,3);
            V0(L)=A3(2,3);
            A=A3;
            R=R3;
            T=T3;
            k=k3;
            F=F3;
            clear Vi
            Vi=auxWi;
            indice= comienzo:final;
            indice=indice(buenas>0.5);
            imagenesbuenas= char(puntos(indice).name);
        end
    end
end

clearvars -except Vi imagenesbuenas imagenesrechazadas A R T k F f U0 V0 camara H direccion
codigo=cd;
cd(direccion)
save(['Resultados Camara ', num2str(camara)])
cd(codigo)

end
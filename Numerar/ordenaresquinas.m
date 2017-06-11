function [esquina1, esquina2, esquina3, esquina4]=ordenaresquinas(esquinas, e1)

centro=[mean(esquinas(1,:)); mean(esquinas(2,:))];
esquina1 = esquinas(:,e1);

J=[];
for kk=1:4
    if kk ~=e1
    ip = (esquina1-centro)'*(esquinas(:,kk)-centro)/(norm(esquina1-centro)*norm(esquinas(:,kk)-centro)); %Producto interno y normalizo
    %acos(ip)*180/pi %Calculo el ángulo
        if acos(ip)<170*pi/180
            J=[J;kk];
        else
            K=kk;
        end
    end
end

esquina2=esquinas(:,J(1));
esquina3=esquinas(:,K);
esquina4=esquinas(:,J(2));

end
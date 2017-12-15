for camara=1:2
    figure; hist(largo3((largo3(:,camara)>20),camara), sqrt(length(largo3(:,camara))))
    title(['Histograma largo trayectorias, camara ',num2str(camara)])
end

resultados

[curva4]=floaters4('F:\09-11-17\Mediciones\SingleShuting 120 Hz Amplitud 15\1\', 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\02-11-17\Damero\Parámetros Montaje Completo.mat', 'C:\Users\Nicolás\Desktop\Labo 6\Mediciones\09-11-17\Superficie libre\', [120, 120], 1)
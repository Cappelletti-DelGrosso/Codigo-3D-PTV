# Codigo-3D-PTV
El script principal de calibración es el homónimo. Este solo necesita que se le ingrese la dirección de la carpeta
donde se hayan las imágenes de calibración dentro de una carpeta que debe llamarse "Damero" junto con su fondo en
otra carpeta que debe llamarse "Fondo blanco". El mismo detecta los puntos de los dameros (xcornes.m),
los numera (numerar.m) y los guarda como .csv (todo esto en esquinas10.m) en carpetas llamadas: Puntos1 y Puntos2 
para las cámaras 1 y 2 respectivamente. 

Luego da la posibilidad de revisar todo esto mediante la función (mirar.m)
y finalmente lee los .csv generados y los usa para calibrar (leer.4). Seguidamente, guarda los resultados de las 
calibraciones en la carpeta donde se hallan las imágenes de calibración con los nombres "Resultados Camara 1" y 
"Resultados Cámara 2". 

Finalmente se ejecuta una simulación (simular.m) que obtiene la mejor imagen en común y
obtiene para esta los parámetros extrínsecos y muestra la posición relativa de las cámaras respecto del damero con
estos parámetros. Además,grafica sobre los ccd virtuales las imágenes verdaderas elegidas como mejores. Finalmente,
utilizando las imágenes en común de ambas calibraciones triangula sus posiciones y evalúa sus errores. Mostrando
el histograma de errores en las distancias relativas de los puntos cuya std da el error en mm que se comete al
triangular y el histograma de los errores de ajuste de los planos triangulados.

El código de control sirve para asegurarse de que la calibración todavía funciona. Se toma una o más imágenes del
 damero y se la triangula con los parámetros ya conocidos y se evalúan sus errores.
 
 El código de flaters sirve para detectar los centros de los floaters en una filmación y recuperar la trayectoria.
 

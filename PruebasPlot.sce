//filename = uigetfile(["*.xls"], 'file selector')
//fullpathname1=strcat(filename)
//text1=readxls(fullpathname1);
//h=text1(1)



function resultado = graficar_segmentos(nombre_input)

//Acá elijo los márgenes del gráfico
ax=gca();
ax.data_bounds = [0, 0; 5, 10];  // [x_min, y_min; x_max, y_max]


text1 = readxls(nombre_input);

//disp(size(h))
[num_filas, num_columnas] = size(text1(1));

resultado = []
// Inicializar la variable resultado
//resultado = zeros(size(h));  // Inicializa resultado con la misma dimensión que text1
//
// Recorre cada fila de la matriz text1
for fila = 1:num_filas
    // Obtener la fila actual como un vector
    fila_actual = text1(1)(fila, :);
    
    // Realizar operaciones en la fila actual si es necesario
    // Por ejemplo, puedes mostrar la fila en la consola
    //disp(fila_actual);
    plot([fila_actual(1),fila_actual(2)], [fila_actual(3), fila_actual(4)]);
    // Sumar la fila actual a la variable resultado
    resultado = [resultado ; fila_actual];
end


endfunction

disp('Resultado final:');
nombre_input = 'Prueba importación.xls'
resultado = graficar_segmentos(nombre_input)
disp(resultado);





















////Acá elijo los márgenes del gráfico
//ax=gca();
//ax.data_bounds = [0, 0; 6, 6];  // [x_min, y_min; x_max, y_max]
//
////grafico los segmentos. El formato es plot([],[]). Entre más [] agrego
//// más segmentos se van a dibujar
//plot([5,5.5],[1,1.5],[1,2],[4,4.5], [3,3.5],[2.5,3.7]);


//function PruebaFilas = GetValues()
//    filas = readxls('Prueba importación.xls')
//    fila2 = filas(1)
//    PruebaFilas = fila2(2,:)
//    
//endfunction
//
//prueba = GetValues()
//disp(prueba)

//https://www.youtube.com/watch?v=JhEkBCtKv1o&ab_channel=VinodKumar

//filename = uigetfile(["*.xls"], 'file selector')
//fullpathname1=strcat(filename)
//text1=readxls(fullpathname1);
//h=text1(1)
//
//col1=h.value(:,1);
//col2=h.value(:,2);
//col3=h.value(:,3);
//col4=h.value(:,4);
//
//plot([col1, col4],[col2, col3])



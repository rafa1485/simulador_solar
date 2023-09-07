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

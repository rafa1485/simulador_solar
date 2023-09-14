function resultado = graficar_segmentos(nombre_input)

//Acá elijo los márgenes del gráfico
ax=gca();
ax.data_bounds = [0, 0; 10, 10];  // [x_min, y_min; x_max, y_max]


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
//    
//    a = fila_actual(2) - fila_actual(1)
//    o = fila_actual(4) - fila_actual(3)
//    
//    datoscatetos = [datoscatetos; [a, o]]
end

//disp(datoscatetos)
//disp('----------')
//paso por parámetros los valores de los catetos



endfunction

//disp('Resultado final:');
nombre_input = 'Prueba importación.xls'
resultado = graficar_segmentos(nombre_input)
disp('Resultado de la función graficar segmentos')
disp(resultado);




function cosdirectores = graficar_rayos(P, Vu, L)
//    funcprot(0);
    
    //acá empieza el rayo
    plot([P(1,1), P(1,2)], [P(2,1), P(2,2)])

    // Largo del vector
//    L = 3.459;
    // Vector unitario (por ejemplo, [0.6, 0.8] para ángulo 45 grados)
//  Vu = [0.866, -0.5];

    // Calcular el vector completo multiplicando el vector unitario por la magnitud
    vector = L * Vu;
    disp(vector)
    
    plot([P(1,2), P(1,2)+vector(1)], [P(2,2), P(2,2)+vector(2)], 'red')
//    disp(P(1,2))
//    disp(vector(1))
//    disp(P(2,2))    
//    disp(vector(2))
    
endfunction


//ejemplo con -30 grados 
P = [2, 2; 8, 8]
//plot(P)
angulo = -30;
Vu = [cosd(angulo), sind(angulo)]
L = 3.459

cosdirectores = graficar_rayos(P, Vu, L)


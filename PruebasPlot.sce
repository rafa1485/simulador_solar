global Pirx;
global Pfrx;
global Pfry;
global Piry;
global Pnx; 
global Pny;


function resultado = graficar_segmentos(nombre_input)

//Acá elijo los márgenes del gráfico
ax=gca();
ax.data_bounds = [0, 0; 10, 10];  // [x_min, y_min; x_max, y_max]

//cargo los datos del excel a la variable text1
text1 = readxls(nombre_input);

//disp(size(h))
[num_filas, num_columnas] = size(text1(1));

resultado = []

for fila = 1:num_filas
    // Obtener la fila actual como un vector
    fila_actual = text1(1)(fila, :);
    
    //Dibujo el segmento con los datos traídos del excel
    plot([fila_actual(1),fila_actual(2)], [fila_actual(3), fila_actual(4)]);

    global Pirx;
    global Pfrx;
    global Pfry;
    global Piry;


    Pirx = fila_actual(1);
    Pfrx = fila_actual(2);
    Pfry = fila_actual(4);
    Piry = fila_actual(3);

    // Sumar la fila actual a la variable resultado
    resultado = [resultado ; fila_actual];

end

endfunction


//disp('Resultado final:');
nombre_input = 'Prueba importación.xls'
resultado = graficar_segmentos(nombre_input)
//disp('Resultado de la función graficar segmentos')
//disp(resultado);




//function cosdirectores = graficar_rayos(P, Vu, L)
//    funcprot(0);
//    
//    //acá empieza el rayo
//    plot([P(1,1), P(1,2)], [P(2,1), P(2,2)])
//
//    // Calcular el vector completo multiplicando el vector unitario por la magnitud
//    vector = L * Vu;
//    //disp(vector)
//    
//    plot([P(1,2), P(1,2)+vector(1)], [P(2,2), P(2,2)+vector(2)], 'red')
//    cosdirectores = [] //puse esta linea porque sino me decía Undefined variable 'cosdire                         ctores' in function 'graficar_rayos'.
//    
//endfunction


//ejemplo con -30 grados 
//Posición inicial del rayo
P = [2, 2; 8, 8]
//plot(P)
angulo = -30;
//Vector unitario. Nos da la dirección del vector. 
Vu = [cosd(angulo), sind(angulo)]
//Largo necesario para que el rayo toque al segmento
//L = 3.459

//cosdirectores = graficar_rayos(P, Vu, L)








function matrices = sistemaecuaciones(Pfrx, Pirx, Pfry, Piry, rnx, rny)
    funcprot(0);
    //Defino la matriz M
    M = [1 0 -(Pfrx-Pirx)   0;
         0 1 -(Pfry-Piry)   0;
         1 0      0       -rnx;
         0 1      0       -rny]
    
    //X = [Prx; Pry; lambdaR; alphanR]
    
    global Pnx; 
    global Pny;
    Pnx = P(1,1); 
    Pny = P(2,1);
    
    b = [Pirx; Piry; Pnx; Pny] //Pirx; Piry; Pnx; Pny (Pnx=2; Pny=8)
        
//    disp(M)
//    disp('-------------')
//    disp(b)    
    matrices = linsolve(M,b);
    matrices = matrices*(-1)
//    disp('Resultado del sistema de ecuaciones: ')
//    disp(matrices)
    disp('Valor de Prx: ', matrices(1))
    disp('Valor de Pry: ', matrices(2))
    disp('Valor de lambda: ', matrices(3))
    disp('Valor de alpha: ', matrices(4))
    
    plot([P(1,2), P(1,2)+rnx*matrices(4)], [P(2,2), P(2,2)+rny*matrices(4)], 'red')
endfunction


//Vector unitario en x e y del rayo
rnx = cosd(angulo);
rny = sind(angulo);

matrices = sistemaecuaciones(Pfrx, Pirx, Pfry, Piry, rnx, rny)

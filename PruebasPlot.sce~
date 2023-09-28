clear;
clc;


global Pirx;
global Pfrx;
global Pfry;
global Piry;
global Pnx; 
global Pny;
global segmentos;
segmentos = [];

global segmentos_chocados;
segmentos_chocados = []

function resultado = graficar_segmentos(nombre_input)

//Acá elijo los márgenes del gráfico
ax=gca();
ax.data_bounds = [0, 0; 10, 10];  // [x_min, y_min; x_max, y_max]

//cargo los datos del excel a la variable text1
text1 = readxls(nombre_input);

//disp(size(h))
[num_filas, num_columnas] = size(text1(1));

resultado = []

//Listas 


for fila = 1:num_filas
    // Obtener la fila actual como un vector
    fila_actual = text1(1)(fila, :);
    
    //Dibujo el segmento con los datos traídos del excel
    plot([fila_actual(1),fila_actual(2)], [fila_actual(3), fila_actual(4)]);

    global Pirx;
    global Pfrx;
    global Pfry;
    global Piry;
    global segmentos;

    Pirx = fila_actual(1);
    Pfrx = fila_actual(2);
    Pfry = fila_actual(4);
    Piry = fila_actual(3);

    segmentos = [segmentos; Pirx, Pfrx, Piry, Pfry]
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
    
    global segmentos;
    global segmentos_chocados;
    
    [n_filas, n_columnas] = size(segmentos);
//    disp('numero de filas: ' , n_filas);
//    disp('numero de columnas: ' , n_columnas);    
    for fila = 1:n_filas
        //% Accede a la fila actual de la matriz
        fila_actual = segmentos(fila, :);
        
        //Defino la matriz M
        M = [1 0 -(fila_actual(2)-fila_actual(1))   0; //punto final del segmento en x y punto inicial en x. Ahora l oescribo en términos de fila_actual
             0 1 -(fila_actual(4)-fila_actual(3))   0; //punto final del segmento en y, y punto inicial en y. Ahora l oescribo en términos de fila_actual
             1 0      0       -rnx;
             0 1      0       -rny]
        
        global Pnx; 
        global Pny;
        //posicion inicial del rayo
        Pnx = P(1,1); 
        Pny = P(2,1);
        
        b = [fila_actual(1); fila_actual(3); Pnx; Pny] //Pirx; Piry; Pnx; Pny (Pnx=2; Pny=8)
            
        matrices = linsolve(M,b);
        matrices = matrices*(-1)
        

        //% Realiza operaciones con la fila actual, por ejemplo:
//        disp(fila_actual);
        disp('Valor de Prx: ', matrices(1))
        disp('Valor de Pry: ', matrices(2))
        disp('Valor de lambda: ', matrices(3))
        disp('Valor de alpha: ', matrices(4))
        disp('---------------------------')

        if matrices(3) < 1 && matrices(3) > 0
            //agrego a lista
            //el sistema de ecuaciones considera también la proyección de los segmentos. Entonces, vamos a encontrar
            //que el sist de ec va a ser resuelto con valores positivos.
            segmentos_chocados = [segmentos_chocados; fila_actual]
            plot([P(1,2), P(1,2)+rnx*matrices(4)], [P(2,2), P(2,2)+rny*matrices(4)], 'red')
        end        
    end
    
    disp(segmentos_chocados)
    
endfunction


//Vector unitario en x e y del rayo
rnx = cosd(angulo);
rny = sind(angulo);

matrices = sistemaecuaciones(Pfrx, Pirx, Pfry, Piry, rnx, rny)

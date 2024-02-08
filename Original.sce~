clear;
clc;


global Pirx;
global Pfrx;
global Pfry;
global Piry;
global Pnx; 
global Pny; 
global alpha;
alpha = 0;
//guarda todos los segmentos del excel
global segmentos;
segmentos = [];

global rayos;
rayos = [2, 8];

global segmentos_chocados;
segmentos_chocados = []

//esta matriz la pienso usar para guardar los valores de Prx, Pry, lambda, alpha. Para luego comparar cuál tiene alpha más chico. 
global variables_segmentos;
variables_segmentos = []

//acá guardo el valor del primer segmento chocado, para analizar el rebote del rayo
global segmento_rebote;
variables_rebote = [];

global segmento_evaluado;
segmento_evaluado = [];

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


global angulo;
angulo = -30;
//Vector unitario. Nos da la dirección del vector. 
global Vu;
Vu = [cosd(angulo), sind(angulo)]
//Largo necesario para que el rayo toque al segmento
//L = 3.459

//cosdirectores = graficar_rayos(P, Vu, L)








function matrices = sistemaecuaciones(Pfrx, Pirx, Pfry, Piry, rnx, rny)
    recorro_otra_vez = 1;

    //while recorro_otra_vez == 1
    for i = 1:5,
        funcprot(0);
        
        //estos son todos los segmentos que existen
        global segmentos;
        global segmentos_chocados;
        
        [n_filas, n_columnas] = size(segmentos);
        //[fila_rayo, columna_rayo] = size(rayos);
        disp('VALORES INICIALES DEL RAYO')
        disp('coordenada inicial', rayos)
        disp('versor director', [rnx, rny])
        
        //for fila = 1:fila_rayo
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
                Pnx = rayos(1); //P(1,1); 
                Pny = rayos(2); //P(2,1);
                
                b = [fila_actual(1); fila_actual(3); Pnx; Pny] //Pirx; Piry; Pnx; Pny (Pnx=2; Pny=8)
                    
                matrices = linsolve(M,b);
                matrices = matrices*(-1)
                
                global alpha;
                alpha = matrices(4);
                //% Realiza operaciones con la fila actual, por ejemplo:
        //        disp(fila_actual);
                disp('Valor de Prx: ', matrices(1))
                disp('Valor de Pry: ', matrices(2))
                disp('Valor de lambda: ', matrices(3))
                disp('Valor de alpha: ', alpha)
//                disp(rnx)
//                disp(rny)
                disp('---------------------------')
        
                global variables_segmentos;
                if matrices(3) < 1 && matrices(3) > 0 && alpha > 0.1 //acá tendría que agregar que la distancia no sea igual a la distancia anterior. Cosa de que no apunte al mismo segmento
                    //agrego a lista
                    //el sistema de ecuaciones considera también la proyección de los segmentos. Entonces, vamos a encontrar que el sist de ec va a ser resuelto con valores positivos.
                    segmentos_chocados = [segmentos_chocados; fila_actual]
                    //plot([rayos(1,1), rayos(1,1)+rnx*matrices(4)], [rayos(1,2), rayos(1,2)+rny*matrices(4)], 'red')
                    variables_segmentos = [variables_segmentos; matrices(1), matrices(2), matrices(3), matrices(4)] //es el mismo orden que arriba
                end        
            end
        //end
               
//        disp(segmentos_chocados)
//        disp(variables_segmentos)
        

//        if variables_segmentos == [] 
//           break; 
//        end
        
        //Menor valor de alpha (longitud)
        disp('Menor valor de alpha')
        disp(min(variables_segmentos(:, 4)))
        
        //fila completa donde está ese valor menor de alpha
        [filas, columnas] = find(variables_segmentos == min(variables_segmentos(:, 4)));

//        disp('REVISAR')        
//        
//        disp('Lista de segmentos donde impacta')
//        disp(variables_segmentos)
//        
//        disp('Coordenadas del menor valor de alfa dentro de la matriz variables_segmentos')
//        disp(filas, columnas)
//        
//        disp('Posiciòn inicial del rayo')
//        disp(rayos)
        
        impacto_rayo_x = rayos(1)+rnx*variables_segmentos(filas, 4)
        impacto_rayo_y = rayos(2)+rny*variables_segmentos(filas, 4)
        
        disp(impacto_rayo_x)
        disp(impacto_rayo_y)
        
        plot([rayos(1), impacto_rayo_x], [rayos(2), impacto_rayo_y], 'red');
//        variables_rebote = [variables_segmentos(filas, :)]
//        disp('Variables rebote: ', variables_rebote)
        //min(variables_segmentos(:, 4))
        //[filas, columnas] = find(variables_segmentos == min(variables_segmentos(:, 4)));
        //disp(filas) -------------
        
        
        //acá pongo el segmento que fue chocado para acceder a sus posiciones en x e y
//        disp('el segmento chocado por el rayo')
        global segmento_evaluado; 
        segmento_evaluado = segmentos_chocados(filas, :)
        disp(segmento_evaluado)
        
        
        // Sistema de ecuaciones para encontrar el punto que determina una recta normal a la
        // recta que pasa por el segmento con el punto donde inicia el rayo
        P = [1 0 -(segmento_evaluado(2)-segmento_evaluado(1)); //0.9 
             0 1 -(segmento_evaluado(4)-segmento_evaluado(3));
             (segmento_evaluado(1)-segmento_evaluado(2)) (segmento_evaluado(3)-segmento_evaluado(4)) 0];
        disp(P)
        
        T = [segmento_evaluado(1); 
             segmento_evaluado(3); 
             ((segmento_evaluado(2)-segmento_evaluado(1))*rayos(1)+(segmento_evaluado(4)-segmento_evaluado(3))*rayos(2))*(-1)];
        
        disp(T)
        solucion_sistema = linsolve(P, T)*(-1); 
        
        disp(solucion_sistema)
        
        // punto por donde pasa la perpendicular
//        disp('punto por donde pasa la perpendicular')
        punto_perpendicular = solucion_sistema([1,2])
//        disp(punto_perpendicular)  //esto es PX = [PXx; PXy]
        
        
        // Calculo del versor normal
        N = (rayos' - punto_perpendicular)
//        disp(N)
//        disp(norm(N))
        n = N / norm(N)
//        disp('versor normal')
//        disp(n)
        
        // Calculo del versos colineal
        vector_inicial_segmento = [segmento_evaluado(1), segmento_evaluado(3)]
        vector_final_segmento = [segmento_evaluado(2), segmento_evaluado(4)]
        disp(vector_inicial_segmento)
        disp(vector_final_segmento)
        
        J = vector_final_segmento - vector_inicial_segmento;
//        disp('Valor de J', J)
        j = J / norm(J)
//        disp('versor j', j)


        punto_donde_choca = [impacto_rayo_x, impacto_rayo_y]
        d1 = (punto_donde_choca-rayos)*j' //d = ()punto donde choca el rayo al segmento - punto inicial del rayo)*j
        d2 = (punto_donde_choca-rayos)*n
//        disp('D1', d1)        
//        disp('D2',d2)        
        RR = d1*j - d2*n'
//        disp('RR', RR)
        rr = RR/norm(RR)
//        disp('rr', rr)
        
        rayos = punto_donde_choca
        rnx = rr(1)
        rny = rr(2)
        
        // limpiamos las variables de trabajo
        segmentos_chocados = []
        //variables_segmentos = []
        segmento_evaluado = []
        variables_segmentos = [];

//        alpha = 0;
        disp('------------- FINAL ---------------')

    end
    
endfunction


//Vector unitario en x e y del rayo
global rnx;
global rny;
rnx = cosd(angulo);
rny = sind(angulo);

matrices = sistemaecuaciones(Pfrx, Pirx, Pfry, Piry, rnx, rny)

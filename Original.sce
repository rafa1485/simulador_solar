//Estos tres comandos son para limpiar cualquier resto que haya podido quedar en los gráficos, borrar
//las variables que hayan podido quedar de antes y puedan afectar al proceso de cálculos y para limpiar la consola.
clear;
clc;
clf;


//Variables que ayudan a dibujar los segmentos.
global Pirx; //punto inicial del segmento en el eje X
global Pfrx; //punto final del segmento en el eje X

global Piry; //punto inicial del segmento en el eje Y
global Pfry; //punto final del segmento en el eje Y

global Pnx; //punto en X del rayo
global Pny; //punto en Y del rayo

//alpha lo explico más adelante
global alpha; 
alpha = 0;

//global segmento_evaluado;


//guarda todos los segmentos del excel
global segmentos;
segmentos = [];

//rayos es la posición inicial del rayo. Se llama rayos porque en principio esto tiene que escalarse a varios rayos.
global rayos;
rayos = [2, 8];

//Lista que utilizo más adelante al momento de decidir cuál es el siguiente rebote
global segmentos_chocados;
segmentos_chocados = []

//En esta matriz voy a guardar los valores de Prx, Pry, lambda, alpha. Para luego comparar cuál tiene alpha más chico. 
global variables_segmentos;
variables_segmentos = []

//acá guardo el valor del primer segmento chocado, para analizar el rebote del rayo
global segmento_rebote; //--------------------------

variables_rebote = [];

//matriz para guardar el segmento que se está evaluando durante el ciclo for
global segmento_evaluado;
segmento_evaluado = [];

//Esta función lo que hace es:
    //Trae los datos del excel. 
        //DATO IMPORTANTE para que no reniegues al cuete. El excel tiene que estar en formato "Libro de excel 97-2003". NO funciona con formato xlsx.
        //Viste que cuando guardás un excel te da la opción a cambiar el formato de salida. Podés guardarlo como PDF, CSV, etc. Bueno, elegí el formato anterior.
    //Guarda los segmentos en una lista
    
function resultado = graficar_segmentos(nombre_input)

    //Acá elijo los márgenes del gráfico
    ax=gca();
    ax.data_bounds = [0, 0; 10, 10];  // [x_min, y_min; x_max, y_max]
    
    //cargo los datos del excel a la variable text1
    text1 = readxls(nombre_input); //nombre_input se define más abajo. Es básicamente el nombre del archivo excel.
    
    //con esta linea extraigo el tamaño del excel, en filas y columnas. 
    [num_filas, num_columnas] = size(text1(1));
    
    resultado = []
    
    //recorro las filas del excel
    for fila = 1:num_filas
        // Obtener la fila actual como un vector
        fila_actual = text1(1)(fila, :);
        
        //Dibujo el segmento con los datos traídos del excel
        plot([fila_actual(1),fila_actual(2)], [fila_actual(3), fila_actual(4)]);
    
        //si no declarás las variables acá no funciona nada. Cosas del scilab
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


//nombre del archivo. Si está en otra carpeta tenés que poner la ruta. Acá no pongo la ruta porque el excel y el código están en la misma carpeta. 
nombre_input = 'Prueba importación.xls'
resultado = graficar_segmentos(nombre_input)

//angulo inicial del rayo
global angulo;
angulo = -30;

//Vector unitario. Nos da la dirección del vector. 
global Vu;
Vu = [cosd(angulo), sind(angulo)]


function matrices = sistemaecuaciones(Pfrx, Pirx, Pfry, Piry, rnx, rny)
    //recorro 5 veces para agarrar como máximo 5 rebotes. Esto podés tocarlo tranqui, no se va a romper el programa. 
    for i = 1:5,
        funcprot(0);
        
        //estos son todos los segmentos que existen
        global segmentos;
        global segmentos_chocados;
        
        [n_filas, n_columnas] = size(segmentos);
        
        //estos disp son para imprimir por consola. Son datos de control más que nada. Para saber cómo va funcionando el programa y si los datos son coherentes.
        disp('VALORES INICIALES DEL RAYO')
        disp('coordenada inicial', rayos)
        disp('versor director', [rnx, rny])
        
        //acá empieza lo interesante. Los cálculos.
        for fila = 1:n_filas
            //% Accede a la fila actual de la matriz
            fila_actual = segmentos(fila, :);
            
            //Defino la matriz M. De esto hay foto para entenderlo mejor. Pedíselas a Rafa.
            M = [1 0 -(fila_actual(2)-fila_actual(1))   0; //punto final del segmento en x y punto inicial en x. Ahora lo escribo en términos de fila_actual
                 0 1 -(fila_actual(4)-fila_actual(3))   0; //punto final del segmento en y, y punto inicial en y. Ahora l oescribo en términos de fila_actual
                 1 0      0       -rnx;
                 0 1      0       -rny]
            
            global Pnx; 
            global Pny;
            //posicion inicial del rayo
            Pnx = rayos(1); //P(1,1); 
            Pny = rayos(2); //P(2,1);
            
            b = [fila_actual(1); fila_actual(3); Pnx; Pny] //Pirx; Piry; Pnx; Pny (Pnx=2; Pny=8)
                
            //resuelvo el sistema de ecuaciones. 
            matrices = linsolve(M,b);
            matrices = matrices*(-1) //multiplico por -1 porque sino los resultados dan al revés
            
            global alpha;
            alpha = matrices(4);
            
            //al resolver el sistema de ecuaciones tenemos como resultado una matriz de 4x1. 
            disp('Valor de Prx: ', matrices(1)) //Punto en X donde va a chocar el rayo al segmento
            disp('Valor de Pry: ', matrices(2)) //Punto en Y donde va a chocar el rayo al segmento
            disp('Valor de lambda: ', matrices(3)) //LAMBDA es un valor que nos va a decir si el rayo choca directamente sobre el segmento. 
                                                   //Debe estar entre 0 y 1. 0.5 es que chocó en la mitad al segmento            
            disp('Valor de alpha: ', alpha) //ALPHA es la distancia que debe recorrer el rayo desde su punto de origen (que se renueva en cada rebote) hasta el segmento.
            //Sobre lo anterior. Solo nos van a servir los datos cuando lambda esté entre 0 y 1, y cuando alpha sea la más chica. 

            //esto lo uso para separar el análisis de cada segmento.     
            disp('---------------------------')
    
            //acá está lo que te decía antes. De alpha y lambda. 
            //En el IF pongo que alpha sea mayor a 0.1 porque al analizarse cada segmento en cada ciclo, pasa que se analiza el mismo segmento desde donde parte el rayo. Entonces hay veces que la distancia es 0 o un número muy chico mayor a 0. Por ejemplo, a veces tira como resultado 1.85e-15. Entonces para evitar que se analice el mismo segmento desde donde parte el rayo agregamos esa condición. 
            global variables_segmentos;
            if matrices(3) < 1 && matrices(3) > 0 && alpha > 0.1 //acá tendría que agregar que la distancia no sea igual a la distancia anterior. Cosa de que no apunte al mismo segmento
                //agrego a lista
                //el sistema de ecuaciones considera también la proyección de los segmentos. Entonces, vamos a encontrar que el sist de ec va a ser resuelto con valores positivos.
                segmentos_chocados = [segmentos_chocados; fila_actual]
                //plot([rayos(1,1), rayos(1,1)+rnx*matrices(4)], [rayos(1,2), rayos(1,2)+rny*matrices(4)], 'red')
                variables_segmentos = [variables_segmentos; matrices(1), matrices(2), matrices(3), matrices(4)] //es el mismo orden que arriba
            else
                disp('La solución: ')
                disp(matrices)
                //esto se muestra en consola cuando no hay más segmentos donde el rayo pueda chocar.
                disp('No cumple las condiciones, por lo que no hay rayos que impacten en un espejo')
            end        
        end

        //Menor valor de alpha (longitud). Imprimo en consola, son datos de control. 
        disp('Menor valor de alpha')
        disp(min(variables_segmentos(:, 4)))
        
        //fila completa donde está ese valor menor de alpha
        [filas, columnas] = find(variables_segmentos == min(variables_segmentos(:, 4)));
        
        impacto_rayo_x = rayos(1)+rnx*variables_segmentos(filas, 4)
        impacto_rayo_y = rayos(2)+rny*variables_segmentos(filas, 4)
        
        disp(impacto_rayo_x)
        disp(impacto_rayo_y)
        
        //dibujo el rayo en rojo. En azul están los segmentos para poder diferenciar.
        plot([rayos(1), impacto_rayo_x], [rayos(2), impacto_rayo_y], 'red');



        global segmento_evaluado; 
        disp('el segmento chocado por el rayo')
        segmento_evaluado = segmentos_chocados(filas, :)
        disp(segmento_evaluado)
        
        // Lo que se hace de acá hasta la linea 144 son cálculos para encontrar hacia dónde debe rebotar el rayo. Para que se comporte correctamente.
        
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
        segmento_evaluado = []
        variables_segmentos = [];

        //acá se llegó al final del primer rebote
        disp('------------- FINAL ---------------')
        
    end
    
endfunction


//Vector unitario en x e y del rayo
global rnx;
global rny;
rnx = cosd(angulo);
rny = sind(angulo);

matrices = sistemaecuaciones(Pfrx, Pirx, Pfry, Piry, rnx, rny)

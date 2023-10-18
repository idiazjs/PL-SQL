SET SERVEROUTPUT ON

/*Práctica 1
Vamos a crear la tabla de multiplicar del 1 al 10
con los tres tipos de bucles: LOOP, WHILE, FOR*/


-- FOR
DECLARE BEGIN
    FOR i IN 1..10 LOOP
        FOR j IN 1..10 LOOP
            dbms_output.put_line(i
                                 || '*'
                                 || j
                                 || '='
                                 || i * j);
        END LOOP;
    END LOOP;
END;

--WHILE
DECLARE
    i INTEGER := 1;
    j INTEGER := 1;
BEGIN
    WHILE i <= 10 LOOP
        j := 1;
        WHILE j <= 10 LOOP
            dbms_output.put_line(i
                                 || '*'
                                 || j
                                 || '='
                                 || i * j);

            j := j + 1;
        END LOOP;

        i := i + 1;
    END LOOP;
END;

-- LOOP
DECLARE
    i INTEGER := 1;
    j INTEGER := 1;
BEGIN
    LOOP
        EXIT WHEN i > 10;
        j := 1;
        LOOP
            EXIT WHEN j > 10;
            dbms_output.put_line(i
                                 || '*'
                                 || j
                                 || '='
                                 || i * j);

            j := j + 1;
        END LOOP;

        i := i + 1;
    END LOOP;
END;

/*Práctica 2- 
Crear una variable llamada TEXTO de tipo VARCHAR2(100).
Poner alguna frase
Mediante un bucle, escribir la frase al revés, Usamos el bucle WHILE*/

DECLARE
    x   VARCHAR2(100) := 'DANIEL';
    y   VARCHAR2(100);
    tam INTEGER;
BEGIN
    tam := length(x);
    WHILE tam <> 0 LOOP
        y := y
             || substr(x, tam, 1);
        tam := tam - 1;
    END LOOP;

    dbms_output.put_line(y);
END;

/*Práctica 3
Usando la práctica anterior, si en el texto aparece el carácter "x" 
debe salir del bucle. Es igual en mayúsculas o minúsculas.
Debemos usar la cláusula EXIT.*/

DECLARE
    x   VARCHAR2(100) := 'DANxIEL';
    y   VARCHAR2(100);
    tam INTEGER;
BEGIN
    tam := length(x);
    WHILE tam <> 0 LOOP
        y := y
             || substr(x, tam, 1);
        EXIT WHEN substr(x, tam, 1) = 'X' OR substr(x, tam, 1) = 'x';

        tam := tam - 1;
        --EXIT WHEN substr(x, tam, 1)='X' OR substr(x, tam, 1)='x';
    END LOOP;

    dbms_output.put_line(y);
END;

/*Práctica 4
Debemos crear una variable llamada NOMBRE
Debemos pintar tantos asteriscos como letras tenga el nombre. Usamos un bucle FOR
Por ejemplo  Alberto --> ********/

DECLARE
    x   VARCHAR2(100) := 'DANIEL';
    y   VARCHAR2(100);
    tam INTEGER;
BEGIN
    tam := length(x);
    FOR i IN 1..tam LOOP
        y := y || '*';
    END LOOP;

    dbms_output.put_line(y);
END;

/*Práctica 5
Creamos dos variables numéricas, "inicio y fin"
Las inicializamos con algún valor:
Debemos sacar los números que sean múltiplos de 4 de ese rango*/

DECLARE
    INICIO NUMBER;
    FINAL NUMBER;
BEGIN
  INICIO:=10;
  FINAL:=200;
  FOR I IN INICIO..FINAL LOOP
    IF MOD(I,4)=0 THEN
        DBMS_OUTPUT.PUT_LINE(I);
    END IF;
   END LOOP;
END;
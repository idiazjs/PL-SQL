SET SERVEROUTPUT ON;
/*
1-Crear una función que tenga como parámetro un número de departamento y que 
devuelve la suma de los salarios de dicho departamento. La imprimimos por pantalla.

Si el departamento no existe debemos generar una excepción con dicho mensaje
*/

DECLARE
    i NUMBER;
BEGIN
    i := FUNCTION2(100);
    DBMS_OUTPUT.PUT_LINE('SUMA:' || i);
END;

-- FUNCIÓN

CREATE OR REPLACE FUNCTION FUNCTION2
(v_id IN DEPARTMENTS.DEPARTMENT_ID%TYPE)
RETURN NUMBER
AS
    v_sum NUMBER;
BEGIN
    SELECT SUM(SALARY)
    INTO v_sum
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = v_id;
    RETURN v_sum;
END FUNCTION2;


/*
2-Modificar el programa anterior para incluir un parámetro de tipo OUT por el 
que vaya el número de empleados afectados por la query. Debe ser visualizada en 
el programa que llama a la función. De esta forma vemos que se puede usar este 
tipo de parámetros también en una función
*/

DECLARE
    i NUMBER := 0;
    j NUMBER := 0;
BEGIN
    i := FUNCTION3(100,j);
    DBMS_OUTPUT.PUT_LINE('SUMA:' || i);
    DBMS_OUTPUT.PUT_LINE('USUARIOS AFECTADOS:' || j);
END;

-- FUNCIÓN

create or replace NONEDITIONABLE FUNCTION FUNCTION3
(v_id IN DEPARTMENTS.DEPARTMENT_ID%TYPE, v_cont OUT NUMBER)
RETURN NUMBER
AS
    v_sum NUMBER;
    v_aux_cont NUMBER;
BEGIN
    SELECT SUM(SALARY), COUNT(SALARY)
    INTO v_sum, v_cont
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = v_id;
    RETURN v_sum;
END FUNCTION3;


/*
3-Crear una función llamada CREAR_REGION,

- A la función se le debe pasar como parámetro un nombre de región y debe 
    devolver un número, que es el código de región que calculamos dentro de 
    la función
- Se debe crear una nueva fila con el nombre de esa REGION
- El código de la región se debe calcular de forma automática. Para ello se debe 
    averiguar cual es el código de región  más alto que tenemos en la tabla en 
    ese momento,  le sumamos 1 y el resultado lo ponemos como el código para la 
    nueva región que estamos creando.
- Si tenemos algún problema debemos generar un error

La función debe devolver el número que ha asignado a la región
*/

DECLARE
    i NUMBER := 0;
BEGIN   
    i:=FUNCTION4('SALES');
    DBMS_OUTPUT.PUT_LINE(i);
END;

-- FUNCTION

CREATE OR REPLACE NONEDITIONABLE FUNCTION FUNCTION4
(v_nom IN DEPARTMENTS.DEPARTMENT_NAME%TYPE)
RETURN NUMBER AS
    v_codmax DEPARTMENTS.DEPARTMENT_ID%TYPE;
    v_cont NUMBER := 0;
    ex_nom EXCEPTION;
    v_return NUMBER;
BEGIN
    -- VALIDAMOS QUE EL NOMBRE DEL DEPARTAMENTO NUEVO NO EXISTA
    SELECT COUNT(DEPARTMENT_NAME)
    INTO v_cont
    FROM DEPARTMENTS
    WHERE DEPARTMENT_NAME=v_nom;
    
    IF(v_cont <> 0) THEN
        RAISE ex_nom;
    END IF;
    
    -- DETECTAMOS EL CÓDIGO MÁS ALTO EN REGIONES
    SELECT MAX(DEPARTMENT_ID) 
    INTO v_codmax
    FROM DEPARTMENTS;
    
    -- INSERTAMOS EL NUEVO CAMPO A DEPARTAMENTOS
    INSERT INTO DEPARTMENTS VALUES (v_codmax+10,v_nom,null,null);
    v_return := v_codmax+10;
    RETURN v_return;
EXCEPTION
    WHEN ex_nom THEN
        RAISE_APPLICATION_ERROR(-20001,'EL DEPARTAMENTO YA EXISTE');  
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || SQLERRM);
END FUNCTION4;
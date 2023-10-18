SET SERVEROUTPUT ON;
/*
1-Crear una funci�n que tenga como par�metro un n�mero de departamento y que 
devuelve la suma de los salarios de dicho departamento. La imprimimos por pantalla.

Si el departamento no existe debemos generar una excepci�n con dicho mensaje
*/

DECLARE
    i NUMBER;
BEGIN
    i := FUNCTION2(100);
    DBMS_OUTPUT.PUT_LINE('SUMA:' || i);
END;

-- FUNCI�N

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
2-Modificar el programa anterior para incluir un par�metro de tipo OUT por el 
que vaya el n�mero de empleados afectados por la query. Debe ser visualizada en 
el programa que llama a la funci�n. De esta forma vemos que se puede usar este 
tipo de par�metros tambi�n en una funci�n
*/

DECLARE
    i NUMBER := 0;
    j NUMBER := 0;
BEGIN
    i := FUNCTION3(100,j);
    DBMS_OUTPUT.PUT_LINE('SUMA:' || i);
    DBMS_OUTPUT.PUT_LINE('USUARIOS AFECTADOS:' || j);
END;

-- FUNCI�N

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
3-Crear una funci�n llamada CREAR_REGION,

- A la funci�n se le debe pasar como par�metro un nombre de regi�n y debe 
    devolver un n�mero, que es el c�digo de regi�n que calculamos dentro de 
    la funci�n
- Se debe crear una nueva fila con el nombre de esa REGION
- El c�digo de la regi�n se debe calcular de forma autom�tica. Para ello se debe 
    averiguar cual es el c�digo de regi�n  m�s alto que tenemos en la tabla en 
    ese momento,  le sumamos 1 y el resultado lo ponemos como el c�digo para la 
    nueva regi�n que estamos creando.
- Si tenemos alg�n problema debemos generar un error

La funci�n debe devolver el n�mero que ha asignado a la regi�n
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
    
    -- DETECTAMOS EL C�DIGO M�S ALTO EN REGIONES
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
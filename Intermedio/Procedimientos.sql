SET SERVEROUTPUT ON;
-- INVOCAMOS EL PROCEDIMIENTO
DECLARE
 v_a NUMBER := 100;
 v_b NUMBER := 5;
BEGIN 
    MY_PROCEDURE(v_a,v_b); 
END;


----------------------------
-- CREAMOS EL PROCEDIMIENTO
CREATE OR REPLACE NONEDITIONABLE PROCEDURE MY_PROCEDURE 
(p_id EMPLOYEES.EMPLOYEE_ID%TYPE, p_impuesto_p NUMBER)
AS
    v_salario EMPLOYEES.SALARY%TYPE;
    v_imp NUMBER;
    E1 EXCEPTION;
BEGIN
    -- VALIDACIÃ“N DE DATOS ACEPTADOS
    IF p_impuesto_p>60 OR p_impuesto_p<0 THEN
        RAISE E1;
    END IF;
    -- CALCULANDO DATOS NECESARIOS
    SELECT SALARY
    INTO v_salario
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=p_id;
    v_imp := v_salario*p_impuesto_p/100;
    DBMS_OUTPUT.PUT_LINE(v_salario);
    DBMS_OUTPUT.PUT_LINE(v_imp);
EXCEPTION
    WHEN E1 THEN
        DBMS_OUTPUT.PUT_LINE('NO JALA EN EL RANGO DE IMPUESTOS ACEPTADOS');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR NO DEFINIDO: '||SQLCODE||' --> '||SQLERRM);  
END MY_PROCEDURE;

---------------------------------
/*
REGLAS DE LOS PARÁMETROS IN OUT IN-OUT

IN
    NO SE PUEDE MODIFICAR
    
OUT
    SI SE PUEDE MODIFICAR
    
IN-OUT
    SI SE PUEDE MDIFICAR


*/


DECLARE 
    x empleados%rowtype;
BEGIN
    x.nombre := 'uwuaa';
    update empleados 
    set nombre=x.nombre, area=x.area
    where id_empleado=15;
END;

    
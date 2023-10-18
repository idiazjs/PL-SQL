SET SERVEROUTPUT ON;

/*
1- Crear un procedimiento llamado visualizar que visualice el nombre y 
salario de todos los empleados.
*/

-- LLAMANDO EL PROCEDIMIENTO
BEGIN
    P6PR1();
END;
-- PROCEDIMIENTO

CREATE OR REPLACE NONEDITIONABLE PROCEDURE P6PR1 
AS
    CURSOR MCP6PR1 IS 
        SELECT * FROM EMPLOYEEES;
    v_emp EMPLOYEES%ROWTYPE;
BEGIN
    FOR i IN MCP6PR1 LOOP
        DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME || '      ' || i.SALARY);
    END LOOP;
END;

/*
2- Modificar el programa anterior para incluir un parámetro que pase el número 
de departamento para que visualice solo los empleados de ese departamento
*/

-- LLAMANDO EL PROCEDIMIENTO
DECLARE
    i INTEGER := 0;
BEGIN
    P6PR2(100,i);
    DBMS_OUTPUT.PUT_LINE('Usuarios recolectados: '||i);
END;
-- PROCEDIMIENTO

CREATE OR REPLACE NONEDITIONABLE PROCEDURE P6PR2
(v_dept IN EMPLOYEES.DEPARTMENT_ID%TYPE,
v_cont OUT NUMBER)
AS
    CURSOR MC(v_dept EMPLOYEES.DEPARTMENT_ID%TYPE) IS 
        SELECT * 
        FROM EMPLOYEES 
        WHERE DEPARTMENT_ID=v_dept;
    v_emp EMPLOYEES%ROWTYPE;
BEGIN
    OPEN MC(v_dept);
        LOOP
            FETCH MC INTO v_emp;
            EXIT WHEN MC%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_emp.FIRST_NAME || '      ' || v_emp.SALARY);
        END LOOP;
        v_cont := MC%ROWCOUNT;    
    CLOSE MC;
END P6PR2;

/*
Debe devolver el número de empleados en una variable de tipo OUT
3- crear un bloque por el cual se de formato a un nº de cuenta suministrado 
por completo, por ej , 11111111111111111111

Formateado a: 1111-1111-11-1111111111
Debemos usar un parámetro de tipo IN-OU
*/

-- LLAMANDO EL PROCEDIMIENTO
DECLARE
    i VARCHAR2(23) := '5566164862999';
BEGIN
    P6PR3(i);
    DBMS_OUTPUT.PUT_LINE(i);
END;
-- PROCEDIMIENTO

CREATE OR REPLACE NONEDITIONABLE PROCEDURE P6PR3
(v_data IN OUT VARCHAR2)
AS
    v_aux_data VARCHAR2(23) := v_data;
    v_dato CHAR;
BEGIN
    --v_tam := LENGTH(v_data);
    v_data := '';
    FOR i IN 1..LENGTH(v_aux_data) LOOP
        v_dato := SUBSTR(v_aux_data, i, 1);
        IF i=4 OR i=8 OR i=10 THEN
            v_data := v_data||v_dato||'-';
        ELSE
            v_data := v_data||v_dato;
        END IF;
    END LOOP;
END P6PR3;
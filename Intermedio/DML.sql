-- LENGUAJE DE MANIPULACION DE DATOS SIDU
SET SERVEROUTPUT ON

SELECT * FROM EMPLOYEES;
DESC EMPLOYEES;
DESC DEPARTMENTS;

-- SELECT VALIDO PARA CONSULTAS DE UNA FILA
-- DE LO CONTRARIO ERROR: ORA-01422
DECLARE
    v_nombre EMPLOYEES.FIRST_NAME%TYPE;
    v_salario EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME, SALARY
    INTO v_nombre, v_salario
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=100;
    dbms_output.put_line('El empleado '||v_nombre||' Tiene un ingreso de '||v_salario);
END;

-- ROWTYPE
-- RESUELVE EL ERROR: ORA-01422
DECLARE
    vrt_info_empleado EMPLOYEES%ROWTYPE;
BEGIN
    SELECT *
    INTO vrt_info_empleado
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=100;
    dbms_output.put_line(vrt_info_empleado.SALARY/2);
END;

/*PR�CTICA 3
REVISAR ERROR*/
DECLARE
    v_did EMPLOYEES.DEPARTMENT_ID%TYPE := 100;     
    v_nombre DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    v_cantidad NUMBER;
BEGIN
    SELECT d.DEPARTMENT_NAME, COUNT(e.DEPARTMENT_ID)
    INTO v_nombre, v_cantidad
    FROM EMPLOYEES e, DEPARTMENTS d
    WHERE e.DEPARTMENT_ID=v_did AND d.DEPARTMENT_ID=v_did;
END;

-- ANTES DE HACER IDU SE CREA UNA TABLA
CREATE TABLE TEST
(
    C1 NUMBER,
    C2 VARCHAR2(20)
);

-- INSERTS
DECLARE
    v_1 TEST.C1%TYPE;
    v_2 TEST.C2%TYPE;
BEGIN
    v_1 := 20;
    v_2 := 'UWU';
    INSERT INTO TEST (C1,C2) 
    VALUES (v_1,v_2);
    COMMIT; -- TRANSACCI�N FINALIZADA CORRECTAMENTE
END;

-- UPDATE 
DECLARE
    v_1 TEST.C1%TYPE;
    v_2 TEST.C2%TYPE;
BEGIN
    v_1 := 20;
    v_2 := 'UWU3';
    UPDATE TEST 
    SET C2=v_2 
    WHERE C1=v_1;
    COMMIT;
END;

-- DELETE

DECLARE
    v_1 TEST.C1%TYPE;
BEGIN
    v_1 := 30;
    DELETE FROM TEST
    WHERE c1=v_1;
END;





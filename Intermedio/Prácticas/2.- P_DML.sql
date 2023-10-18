SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

-- PRÁCTICA SELECT

/*PRÁCTICA 1
Crear un bloque PL/SQL que devuelva al salario máximo del departamento 100 
y lo deje  en una variable denominada salario_maximo y la visualice*/

DECLARE
    v_salario_max EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT MAX(SALARY)
    INTO v_salario_max
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID=100;
    dbms_output.put_line(v_salario_max);
END;

/*PRÁCTICA2
Visualizar el tipo de trabajo del empleado número 100*/

DECLARE
    v_t_trabajo EMPLOYEES.JOB_ID%TYPE;
BEGIN
    SELECT JOB_ID
    INTO v_t_trabajo
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=100;
    dbms_output.put_line(v_t_trabajo);
END;

/*PRÁCTICA 3
Crear una variable de tipo DEPARTMENT_ID y ponerla algún valor, por ejemplo 10.
Visualizar el nombre de ese departamento y el número de empleados que tiene, 
poniendo. Crear dos variables para albergar los valores.*/

DECLARE
    v_did EMPLOYEES.DEPARTMENT_ID%TYPE := 100;     
    v_nombre DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    v_cantidad NUMBER;
BEGIN
    SELECT COUNT(e.DEPARTMENT_ID)
    INTO v_cantidad
    FROM EMPLOYEES e
    WHERE e.DEPARTMENT_ID=v_did;
    
    SELECT d.DEPARTMENT_NAME
    INTO v_nombre
    FROM DEPARTMENTS d
    WHERE d.DEPARTMENT_ID=v_did;
    
    dbms_output.put_line('El departamento '
                                            ||v_nombre 
                                            ||' tiene '
                                            || v_cantidad 
                                            || ' empleados');
END;

/*PRÁCTICA 4
Mediante dos consultas recuperar el salario máximo y el salario mínimo de la 
empresa e indicar su diferencia*/

DECLARE
    v_salario EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT MAX(SALARY)
    INTO v_salario
    FROM EMPLOYEES;
    dbms_output.put_line('Salario máximo '||v_salario);
    
    SELECT MIN(SALARY)
    INTO v_salario
    FROM EMPLOYEES;
    dbms_output.put_line('Salario mínimo '||v_salario);
END;


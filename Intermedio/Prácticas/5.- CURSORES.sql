SET SERVEROUTPUT ON;
/*
1-Hacer un programa que tenga un cursor que vaya visualizando los salarios de 
los empleados. Si en el cursor aparece el jefe (Steven King) se debe generar 
un RAISE_APPLICATION_ERROR indicando que el sueldo del jefe no se puede ver.
*/
DECLARE
    CURSOR MC IS 
        SELECT e.FIRST_NAME
            ||' '
            ||e.LAST_NAME, 
            e.SALARY
        FROM 
            EMPLOYEES e;
            
    TYPE MTR IS RECORD(
        v_nombre VARCHAR2(50),
        v_salario EMPLOYEES.SALARY%TYPE
    );
    
    v_empleado MTR;
    ME EXCEPTION;
BEGIN
    OPEN MC;
    LOOP
        FETCH MC INTO v_empleado;
        EXIT WHEN MC%NOTFOUND;
        IF v_empleado.v_nombre<>'Steven King' THEN
            DBMS_OUTPUT.PUT_LINE(v_empleado.v_nombre 
                                    || '       '
                                    || v_empleado.v_salario);
        ELSE
            RAISE ME;
        END IF;
        
    END LOOP;
    CLOSE MC;
EXCEPTION
    WHEN ME THEN
         DBMS_OUTPUT.PUT_LINE('DATOS NO DISPONIBLES');
END;

-- AHORA CON RAISE_APPLICAION_ERROR
DECLARE
    CURSOR MC IS 
        SELECT e.FIRST_NAME
            ||' '
            ||e.LAST_NAME, 
            e.SALARY
        FROM 
            EMPLOYEES e;
            
    TYPE MTR IS RECORD(
        v_nombre VARCHAR2(50),
        v_salario EMPLOYEES.SALARY%TYPE
    );
    
    v_empleado MTR;
    ME EXCEPTION;
BEGIN
    OPEN MC;
    LOOP
        FETCH MC INTO v_empleado;
        EXIT WHEN MC%NOTFOUND;
        IF v_empleado.v_nombre<>'Steven King' THEN
            DBMS_OUTPUT.PUT_LINE(v_empleado.v_nombre 
                                    || '       '
                                    || v_empleado.v_salario);
        ELSE
            RAISE ME;
        END IF;
        
    END LOOP;
    CLOSE MC;
EXCEPTION
    WHEN ME THEN
         RAISE_APPLICATION_ERROR(-20001, 'DATO NO ACCESIBLE');
END;

---------------------------------------
/*
2-Hacemos un bloque con dos cursores. (Esto se puede hacer fácilmente con una 
sola SELECT pero vamos a hacerlo de esta manera para probar parámetros en 
cursores)
el primero de empleados
El segundo de departamentos que tenga como parámetro el MANAGER_ID
Por cada fila del primero, abrimos el segundo curso pasando el ID del MANAGER
Debemos pintar el Nombre del departamento y el nombre del MANAGER_ID
Si el empleado no es MANAGER de ningún departamento debemos poner 
“No es jefe de nada”
*/
DECLARE 
    CURSOR C_EMP IS
        SELECT * FROM EMPLOYEES;
    CURSOR C_DEPT(v_id EMPLOYEES.MANAGER_ID%TYPE) IS
        SELECT * FROM DEPARTMENTS WHERE MANAGER_ID=v_id;
    v_empleado EMPLOYEES%ROWTYPE;
    v_dept DEPARTMENTS%ROWTYPE;
BEGIN
    OPEN C_EMP;
    DBMS_OUTPUT.PUT_LINE('ID EMPLEADO'
                                        ||'     '
                                        ||'MANAGER ID EMPLEADO'
                                        ||'     '
                                        ||'MANAGER DEPARTMENT');
        LOOP
            FETCH C_EMP INTO v_empleado;
            EXIT WHEN C_EMP%NOTFOUND;
            IF v_empleado.MANAGER_ID=NULL THEN
                DBMS_OUTPUT.PUT_LINE('--------------------------');
            ELSE
                OPEN C_DEPT(v_empleado.MANAGER_ID);
                    LOOP
                        FETCH C_DEPT INTO v_dept;
                        EXIT WHEN C_DEPT%NOTFOUND;
                        DBMS_OUTPUT.PUT_LINE(v_empleado.EMPLOYEE_ID
                                            ||'     '
                                            ||v_empleado.MANAGER_ID
                                            ||'     '
                                            ||v_dept.DEPARTMENT_NAME);
                    END LOOP;
                CLOSE C_DEPT;
            END IF;
            
        END LOOP;
    CLOSE C_EMP;
END;

---------------------------------------
/*
Crear un cursor con parÃ¡metros que pasando 
el nÃºmero de departamento visualice el nÃºmero 
de empleados de ese departamento
*/

DECLARE
    CURSOR MCD IS 
        SELECT * FROM DEPARTMENTS;
    v_d DEPARTMENTS%ROWTYPE;
    v_count NUMBER;
BEGIN
    OPEN MCD;
        LOOP
            FETCH MCD INTO v_d;
            EXIT WHEN MCD%NOTFOUND;
            SELECT COUNT(e.EMPLOYEE_ID)
            INTO v_count
            FROM EMPLOYEES e
            WHERE e.DEPARTMENT_ID=v_d.DEPARTMENT_ID;
            DBMS_OUTPUT.PUT_LINE(v_d.DEPARTMENT_ID 
                                    || '       '
                                    || v_count);
        END LOOP;
    CLOSE MCD;
END;

---------------------------------------
/*
Crear un bucle FOR donde declaramos una subconsulta que nos devuelva 
el nombre de los empleados que sean ST_CLERCK. Es decir, no declaramos 
el cursor sino que lo indicamos directamente en el FOR.
*/

-- NO FUNCIONA, NO PUEDO ADQUIRIR MÁS DE UN DATO
-- POR LO QUE HARÉ USO DE UN CURSOR INTEGRADO
DECLARE
    v_totemp NUMBER;
    v_name EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT COUNT(EMPLOYEE_ID)
    INTO v_totemp
    FROM EMPLOYEES;
    FOR i IN 1..v_totemp LOOP
        SELECT FIRST_NAME
        INTO v_name
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID=i+99 AND JOB_ID='ST_CLERK'; --ESTO NO APLICA A LA ESTRUCTURA DISEÑADA
        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;
END;

---------------------------------------
-- ADEMÁS DE SER MÁS CORTO, PERMITE COMPARAR VALORES
BEGIN
    FOR i IN (SELECT * FROM EMPLOYEES) LOOP
        IF i.JOB_ID='ST_CLERK' THEN
            DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME);
        END IF;
    END LOOP;
END;

---------------------------------------
/*
5-Creamos un bloque que tenga un cursor para empleados. Debemos crearlo con FOR UPDATE.
Por cada fila recuperada, si el salario es mayor de 8000 incrementamos el salario un 2%
Si es menor de 800 lo hacemos en un 3%
Debemos modificarlo con la cláusula CURRENT OF
Comprobar que los salarios se han modificado correctamente.
*/

DECLARE
    CURSOR MCE IS SELECT * FROM EMPLOYEES FOR UPDATE;
    v_emp EMPLOYEES%ROWTYPE;
BEGIN
    FOR i IN MCE LOOP
        IF i.SALARY>8000 THEN
            UPDATE EMPLOYEES 
            SET EMPLOYEES.SALARY=i.SALARY+i.SALARY*0.02
            WHERE CURRENT OF MCE;
        ELSE
            UPDATE EMPLOYEES 
            SET EMPLOYEES.SALARY=i.SALARY+i.SALARY*0.03
            WHERE CURRENT OF MCE;
        END IF;        
    END LOOP;
END;


-----------------------------
-- PROBLEMA 2 CON OTRA PERSPECTIVA
SET SERVEROUTPUT ON
DECLARE
    DEPARTAMENTO DEPARTMENTS%ROWTYPE;
    jefe DEPARTMENTS.MANAGER_ID%TYPE;
    CURSOR C1 IS SELECT * FROM EMployees;
    CURSOR C2(j DEPARTMENTS.MANAGER_ID%TYPE)
    IS SELECT * FROM DEPARTMENTS WHERE MANAGER_ID=j;
begin
    for EMPLEADO in c1 loop
        open c2(EMPLEADO.employee_id) ;
            FETCH C2 into departamento;
            if c2%NOTFOUND then
                DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME ||' No es JEFE de NADA');
            ELSE
                DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME || 'ES JEFE DEL DEPARTAMENTO '|| DEPARTAMENTO.DEPARTMENT_NAME);
            END IF;
        CLOSE C2;
    END LOOP;
END;

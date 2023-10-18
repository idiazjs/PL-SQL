/*
1- Crear un bloque que inserte un nuevo departamento en la tabla DEPARTMENTS. 
Para saber el DEPARTMENT_ID que debemos asignar al nuevo departamento primero 
debemos averiguar el valor mayor que hay en la tabla DEPARTMENTS y sumarle uno 
para la nueva clave.
    o Location_id debe ser 1000
    o Manager_id debe ser 100
    o Department_name debe ser “INFORMATICA”
    o NOTA: en PL/SQL debemos usar COMMIT y ROLLBACK de la misma forma 
    que lo hacemos en SQL. Por tanto, para validar definitivamente un 
    cambio debemos usar COMMIT.
*/

DECLARE 
    v_maxid         DEPARTMENTS.DEPARTMENT_ID%TYPE;
    v_d_name        DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    v_d_managerid   DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    v_d_locationid  DEPARTMENTS.LOCATION_ID%TYPE;
    
BEGIN
    -- AVERIGUANDO CUAL ES EL MÁXIMO ID
    SELECT MAX(DEPARTMENT_ID)
    INTO v_maxid
    FROM DEPARTMENTS;
    DBMS_OUTPUT.put_line('ULTIMO DEPARTAMENTO REGISTRADO: '||v_maxid);
    
    -- INGRESANDO NUEVOS DATOS
    v_d_name := 'INFORMATICA';
    v_d_locationid := 1000;
    v_d_managerid := 100;
    
    INSERT INTO DEPARTMENTS
    VALUES (v_maxid+10, v_d_name, v_d_managerid, v_d_locationid);
    
    COMMIT;
END;

/*
2-Crear un bloque PL/SQL que modifique la LOCATION_ID del nuevo departamento 
a 1700. En este caso usemos el COMMIT dentro del bloque PL/SQL.
*/

BEGIN
    UPDATE DEPARTMENTS
    SET location_id=1700
    WHERE department_id=280;
    COMMIT;
END;

/*
3.- Por último hacer otro bloque PL/SQL que elimine ese departamento nuevo.
*/

BEGIN
    DELETE departments
    WHERE department_id=280;
END;
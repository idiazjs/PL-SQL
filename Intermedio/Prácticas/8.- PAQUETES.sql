SET SERVEROUTPUT ON;

/*
1- Crear un paquete denominado REGIONES que tenga los siguientes componentes:
PROCEDIMIENTOS:
         
         -  ALTA_REGION, con parámetro de código y nombre Región. Debe devolver 
         un error si la región ya existe. Inserta una nueva región en la tabla. 
         Debe llamar a la función EXISTE_REGION para controlarlo.

        - BAJA_REGION, con parámetro de código de región y que debe borrar una 
        región. Debe generar un error si la región no existe, Debe llamar a la 
        función EXISTE_REGION para controlarlo

        -  MOD_REGION: se le pasa un código y el nuevo nombre de la región 
        Debe modificar el nombre de una región ya existente. Debe generar un 
        error si la región no existe, Debe llamar a la función EXISTE_REGION 
        para controlarlo

FUNCIONES:
           CON_REGION. Se le pasa un código de región y devuelve el nombre

          EXISTE_REGION. Devuelve verdadero si la región existe. Se usa en los 
          procedimientos y por tanto es PRIVADA, no debe aparecer en la 
          especificación del paquete
*/
CREATE OR REPLACE 
PACKAGE PACK_REGIONES AS 
    -- FUNCIONES
        FUNCTION CON_REGION(v_idregion REGIONS.REGION_ID%TYPE) RETURN VARCHAR2;
    -- PROCEDIMIENTOS
        PROCEDURE ALTA_REGION (v_id_reg REGIONS.REGION_ID%TYPE, v_nom_reg REGIONS.REGION_NAME%TYPE);
        PROCEDURE BAJA_REGION(v_id_reg REGIONS.REGION_ID%TYPE);
        PROCEDURE MOD_REGION(v_id_reg REGIONS.REGION_ID%TYPE, v_nom_reg REGIONS.REGION_NAME%TYPE);

END PACK_REGIONES;
/  
CREATE OR REPLACE
PACKAGE BODY PACK_REGIONES AS
   
--F1
    FUNCTION CON_REGION(v_idregion REGIONS.REGION_ID%TYPE) RETURN VARCHAR2 
    AS
            v_region_name REGIONS.REGION_NAME%TYPE;
    BEGIN
        SELECT REGION_NAME
        INTO v_region_name
        FROM REGIONS
        WHERE REGION_ID = v_idregion;
        RETURN v_region_name;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002,'LA REGION NO EXISTE');
    END CON_REGION;
    
--F2
    FUNCTION EXISTE_REGION
    (v_id_reg REGIONS.REGION_ID%TYPE, v_nom_reg REGIONS.REGION_NAME%TYPE) 
    RETURN VARCHAR2 
    AS
        v_cont NUMBER;
    BEGIN
        -- BUSCANDO EXISTENCIA
        SELECT COUNT(*)
        INTO v_cont
        FROM REGIONS
        WHERE REGION_NAME=v_nom_reg OR REGION_ID=v_id_reg;
        
        IF v_cont <> 0 THEN
            RETURN 'EXISTE';
        ELSE
            RETURN '!EXISTE';
        END IF;
    END EXISTE_REGION;

--P1
    PROCEDURE ALTA_REGION
    (v_id_reg REGIONS.REGION_ID%TYPE, v_nom_reg REGIONS.REGION_NAME%TYPE) 
    AS
        v_valida VARCHAR2(100);
    BEGIN
        v_valida := EXISTE_REGION(v_id_reg, v_nom_reg);
        IF v_valida = 'EXISTE' THEN
            RAISE_APPLICATION_ERROR
            (-20001, 'EL ID O EL NOMBRE YA EXISTEN, PRUEBA NUEVAMENTE');
        ELSE
            INSERT INTO REGIONS VALUES (v_id_reg, v_nom_reg);
        END IF;
    END ALTA_REGION;
--P2
    PROCEDURE BAJA_REGION(v_id_reg REGIONS.REGION_ID%TYPE) 
    AS
        v_valida VARCHAR2(100);
    BEGIN
        v_valida := EXISTE_REGION(v_id_reg, '');
        IF v_valida = '!EXISTE' THEN
            RAISE_APPLICATION_ERROR
            (-20002, 'LA REGION NO SE PUEDE BORRAR PORQUE NO EXISTE');
        ELSE 
            DELETE FROM REGIONS 
            WHERE REGION_ID = v_id_reg;
        END IF;
    END BAJA_REGION;
--P3
    PROCEDURE MOD_REGION
    (v_id_reg REGIONS.REGION_ID%TYPE, v_nom_reg REGIONS.REGION_NAME%TYPE) 
    AS
        v_valida VARCHAR2(100);
    BEGIN
        v_valida := EXISTE_REGION(v_id_reg,''); 
        IF v_valida = '!EXISTE' THEN
            RAISE_APPLICATION_ERROR
            (-20002, 'LA REGION NO SE PUEDE MODIFICAR PORQUE NO EXISTE');
        ELSE
            UPDATE REGIONS
            SET REGION_NAME=v_nom_reg
            WHERE REGION_ID = v_id_reg;
        END IF;
    END MOD_REGION;  

END PACK_REGIONES;
---------------------------------------------------------------

-- PROBANDO EL PAQUETE
-- CON_REGION

DECLARE
    v_nom REGIONS.REGION_NAME%TYPE;
BEGIN 
    
    v_nom := PACK_REGIONES.CON_REGION(20);
    DBMS_OUTPUT.PUT_LINE(v_nom);
END;

-- ALTA_REGION
BEGIN 
    PACK_REGIONES.ALTA_REGION(5,'ATLANTA');
END;

-- BAJA_REGION
BEGIN 
    PACK_REGIONES.BAJA_REGION(5);
END;

-- BAJA_REGION
BEGIN 
    PACK_REGIONES.MOD_REGION(5,'Atlanta');
END;



-----------------------------------------------------------
/*
2-Crear un paquete denominado NOMINA que tenga sobrecargado la función 
CALCULAR_NOMINA de la siguiente forma:

-   CALCULAR_NOMINA(NUMBER): se calcula el salario del empleado restando un 
        15% de IRPF.
-   CALCULAR_NOMINA(NUMBER,NUMBER): el segundo parámetro es el porcentaje a 
    aplicar. Se calcula el salario del empleado restando ese porcentaje al 
    salario
-   CALCULAR_NOMINA(NUMBER,NUMBER,CHAR): el segundo parámetro es el porcentaje 
    a aplicar, el tercero vale ‘V’ . Se calcula el salario del empleado 
    aumentando la comisión que le pertenece y restando ese porcentaje al 
    salario siempre y cuando el empleado tenga comisión.
*/

CREATE OR REPLACE 
PACKAGE NOMINA AS 

  FUNCTION CALCULAR_NOMINA(v_emp_id EMPLOYEES.EMPLOYEE_ID%TYPE) RETURN NUMBER;
  FUNCTION CALCULAR_NOMINA(v_emp_id EMPLOYEES.EMPLOYEE_ID%TYPE, v_desc NUMBER) RETURN NUMBER;

END NOMINA;
/
CREATE OR REPLACE
PACKAGE BODY NOMINA AS

  FUNCTION CALCULAR_NOMINA
  (v_emp_id EMPLOYEES.EMPLOYEE_ID%TYPE) 
  RETURN NUMBER 
  AS
    v_nomina NUMBER;
    BEGIN
        SELECT SALARY
        INTO v_nomina
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID=v_emp_id;
        v_nomina := v_nomina-(v_nomina*0.15);
        RETURN v_nomina;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001,'USUARIO NO ENCONTRADO');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR NO DEFINIDO: '||SQLCODE||' --> '||SQLERRM);  
    END CALCULAR_NOMINA;
    
    FUNCTION CALCULAR_NOMINA
    (v_emp_id EMPLOYEES.EMPLOYEE_ID%TYPE, v_desc NUMBER) 
    RETURN NUMBER 
    AS
        v_nomina NUMBER;
    BEGIN
        SELECT SALARY
        INTO v_nomina
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID=v_emp_id;
        v_nomina := v_nomina-(v_nomina*v_desc);
        RETURN v_nomina;
        RETURN NULL;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001,'USUARIO NO ENCONTRADO');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR NO DEFINIDO: '||SQLCODE||' --> '||SQLERRM);  
    END CALCULAR_NOMINA;
END NOMINA;
---------------------------------------------------------------

-- PROBANDO EL PAQUETE

DECLARE
    v_nomina NUMBER;
BEGIN
    v_nomina := NOMINA.CALCULAR_NOMINA(100);
    DBMS_OUTPUT.PUT_LINE(v_nomina);
    v_nomina := NOMINA.CALCULAR_NOMINA(100,0.20);
    DBMS_OUTPUT.PUT_LINE(v_nomina);
END;

SET SERVEROUTPUT ON;

-- Llamando al paquete

BEGIN 
    DBMS_OUTPUT.PUT_LINE(PACK1.vp_num);
    PACK1.vp_num := 20;
    DBMS_OUTPUT.PUT_LINE(PACK1.vp_num);
END;

-- PAQUETE DECLARADO

CREATE OR REPLACE 
PACKAGE PACK1 AS 

vp_num NUMBER := 10;

END PACK1;


-----------------------------------------------------
-- Al crear un paquete con un body, lo debemos ejecutar por separado 
-- (cabecera y cuerpo) en un .sql para crear la estrucutura en el paquete.
-- CLICK DERECHO Y CRAR CUERPO PARA HACERO DIRECTAMENTE EN EL PAQUETE
CREATE OR REPLACE 
PACKAGE PACK2 AS 
    -- DECLARAMOS EL PROCEDIMIENTO
    PROCEDURE P_CONVERTIR (v_nom VARCHAR2, v_tipo_conv CHAR);
END PACK2;
/ 
-- PROGRAMAMOS EL CUERPO DEL PAQUETE
CREATE OR REPLACE PACKAGE BODY PACK2
AS
    -- FUNCIÓN QUE RETORNA UNA CADENA EN MAYÚSCULAS
    FUNCTION F_MAYUS(v_nom VARCHAR2)
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN UPPER(v_nom);
    END F_MAYUS;
    
    -- FUNCIÓN QUE RETORNA UNA CADENA EN MINÚSCULAS
    FUNCTION F_MINUS(v_nom VARCHAR2)
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN LOWER(v_nom);
    END F_MINUS;
    
    -- PROCEDIMIENTO DE CONVERSIÓN
    PROCEDURE P_CONVERTIR (v_nom VARCHAR2, v_tipo_conv CHAR)
    AS
    BEGIN
        IF v_tipo_conv='U' THEN
            DBMS_OUTPUT.PUT_LINE(F_MAYUS(v_nom));
        ELSIF  v_tipo_conv='L' THEN
            DBMS_OUTPUT.PUT_LINE(F_MINUS(v_nom));
        ELSE
            DBMS_OUTPUT.PUT_LINE('EL PARAMETRO DEBE SER U o L');
        END IF;
    END P_CONVERTIR;
END PACK2;

-----------------------------------------------------
-- PROBANDO EL PROCEDIMIENTO ANTERIOR
BEGIN
    PACK2.P_CONVERTIR('AAA','L');
    PACK2.P_CONVERTIR('aaa','U');
END;
-----------------------------------------------------
/*
    MODIFICAR EL PAQUETE ANTERIOR PARA PARA QUE SE USE COMO FUNCIÓN
*/
CREATE OR REPLACE 
PACKAGE PACK3 AS 
    PROCEDURE P_CONVERTIR (v_nom VARCHAR2, v_tipo_conv CHAR);
    FUNCTION P_CONVERTIR (v_nom VARCHAR2, v_tipo_conv CHAR) RETURN VARCHAR2;
END PACK3;
/
CREATE OR REPLACE
PACKAGE BODY PACK3 AS

  -- FUNCIÓN QUE RETORNA UNA CADENA EN MAYÚSCULAS
    FUNCTION F_MAYUS(v_nom VARCHAR2)
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN UPPER(v_nom);
    END F_MAYUS;

    -- FUNCIÓN QUE RETORNA UNA CADENA EN MINÚSCULAS
    FUNCTION F_MINUS(v_nom VARCHAR2)
    RETURN VARCHAR2
    AS
    BEGIN 
        RETURN LOWER(v_nom);
    END F_MINUS;

    -- PROCEDIMIENTO DE CONVERSIÓN
    PROCEDURE P_CONVERTIR (v_nom VARCHAR2, v_tipo_conv CHAR)
    AS
    BEGIN
        IF v_tipo_conv='U' THEN
            DBMS_OUTPUT.PUT_LINE(F_MAYUS(v_nom));
        ELSIF  v_tipo_conv='L' THEN
            DBMS_OUTPUT.PUT_LINE(F_MINUS(v_nom));
        ELSE
            DBMS_OUTPUT.PUT_LINE('EL PARAMETRO DEBE SER U o L');
        END IF;
    END P_CONVERTIR;
    
    -- PROCEDIMIENTO DE CONVERSIÓN
    FUNCTION P_CONVERTIR (v_nom VARCHAR2, v_tipo_conv CHAR) RETURN VARCHAR2
    AS
    BEGIN
        IF v_tipo_conv='U' THEN
            RETURN(F_MAYUS(v_nom));
        ELSIF  v_tipo_conv='L' THEN
            RETURN(F_MINUS(v_nom));
        ELSE
            DBMS_OUTPUT.PUT_LINE('EL PARAMETRO DEBE SER U o L');
        END IF;
    END P_CONVERTIR;
END PACK3;

-----------------------------------------------------
-- EJECUTANDO EL PROCEDIMIENTO ANTERIOR
DECLARE
    v_cadena VARCHAR2(100);
BEGIN
    v_cadena := PACK3.P_CONVERTIR('AAA','L');
    DBMS_OUTPUT.PUT_LINE(v_cadena);
    v_cadena := PACK3.P_CONVERTIR('aaa','U');
    DBMS_OUTPUT.PUT_LINE(v_cadena);
END;

-----------------------------------------------------
-- Usando esa función en SQL PURO

SELECT
    PACK3.P_CONVERTIR(FIRST_NAME,'L'),
    PACK3.P_CONVERTIR(FIRST_NAME,'U')
FROM
    EMPLOYEES;

-- Se demuestra el poder de los paquetes y de las funciones
-----------------------------------------------------

-- SOBRECARGA DE PROCEDIMIENTOS
/*
Consiste en llamar a dos procedimientos de la misma manera pero con diferentes 
tipos de argumentos para diferenciarlos
*/
CREATE OR REPLACE 
PACKAGE PACK4 AS 

  FUNCTION F_CONTAR_EMP (v_id NUMBER) RETURN NUMBER;
  FUNCTION F_CONTAR_EMP (v_dep VARCHAR2) RETURN NUMBER;

END PACK4;
/
CREATE OR REPLACE
PACKAGE BODY PACK4 AS

  FUNCTION F_CONTAR_EMP (v_id NUMBER) RETURN NUMBER AS
    v_cont NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_cont FROM EMPLOYEES WHERE DEPARTMENT_ID=v_id;
    RETURN v_cont;
  END F_CONTAR_EMP;

  FUNCTION F_CONTAR_EMP (v_dep VARCHAR2) RETURN NUMBER AS
    v_cont NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_cont
    FROM EMPLOYEES e, DEPARTMENTS d
    WHERE d.DEPARTMENT_NAME = v_dep
    AND e.DEPARTMENT_ID = d.DEPARTMENT_ID;
    RETURN v_cont;
  END F_CONTAR_EMP;

END PACK4;
-----------------------------------------------------
-- EJECUTANDO EL PROCEDIMIENTO ANTERIOR

DECLARE
    v_num NUMBER;
BEGIN
    v_num := PACK4.F_CONTAR_EMP(50);
    DBMS_OUTPUT.PUT_LINE(v_num);
    v_num := PACK4.F_CONTAR_EMP('Shipping');
    DBMS_OUTPUT.PUT_LINE(v_num);
END;
-- IS RECORD
SET SERVEROUTPUT ON;
DECLARE 
    TYPE t_mytype IS RECORD(
        v_numero NUMBER:=1999,
        v_ciudad COUNTRIES%ROWTYPE
    );
    v_miciudad t_mytype;
BEGIN
    SELECT * 
    INTO v_miciudad.v_ciudad
    FROM COUNTRIES
    WHERE COUNTRY_ID='AR';
    DBMS_OUTPUT.put_line(v_miciudad.v_ciudad.COUNTRY_ID);
    DBMS_OUTPUT.put_line(v_miciudad.v_ciudad.COUNTRY_NAME);
    DBMS_OUTPUT.put_line(v_miciudad.v_ciudad.REGION_ID);
    DBMS_OUTPUT.put_line(v_miciudad.v_numero);
END;
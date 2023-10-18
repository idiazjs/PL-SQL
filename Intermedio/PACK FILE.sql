/*
    REQUERIMOS TENER LOS SIGUIENTES PERMISOS OTORGADOS POR 'SYSTEM'
*/

GRANT CREATE ANY DIRECTORY TO HR;
GRANT EXECUTE ON SYS.UTL_FILE TO HR;

DESC UTL_FILE;

-----------------------------------------
-- Manejando el archivo my_file.txt

SET SERVEROUTPUT ON;

CREATE OR REPLACE NONEDITIONABLE PROCEDURE P_LEER_FILE AS
    v_text VARCHAR2(32767);
    v_file UTL_FILE.FILE_TYPE;
BEGIN  
    v_file := UTL_FILE.FOPEN('EXERCISES', 'my_file.txt', 'R');
    LOOP
        BEGIN
            -- OBTENIENDO DATOS POR LINEA
            UTL_FILE.GET_LINE(v_file,v_text);
            DBMS_OUTPUT.PUT_LINE(v_text);
            -- INSERTANDO EN FILE_DATA
            INSERT INTO FILE_DATA VALUES (v_text);
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN EXIT;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR NO DEFINIDO: '||SQLCODE||' --> '||SQLERRM);
        END;        
    END LOOP;
    UTL_FILE.FCLOSE(v_file);
END P_LEER_FILE;

-----------------------------------------
-- EJECUTANDO PROCEDIMIENTO

BEGIN
    P_LEER_FILE;
END;

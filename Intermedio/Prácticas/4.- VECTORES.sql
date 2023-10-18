SET SERVEROUTPUT ON;

DECLARE 
    TYPE tr_myrecord IS RECORD(
        v_nombre VARCHAR2(100),
        v_sal_empleados EMPLOYEES.SALARY%TYPE,
        v_cod_dept EMPLOYEES.DEPARTMENT_ID%TYPE
    );
    TYPE tt_mytype IS TABLE OF
        -- DESCUBRIMIENTO 1 SE PUEDE HACER UN TT DE UN TR
        tr_myrecord
    INDEX BY PLS_INTEGER;
    v_mis_empleados tt_mytype;
BEGIN
    FOR i IN 100..206 LOOP
        SELECT e.first_name||' '||e.last_name, e.salary, e.department_id
        INTO v_mis_empleados(i)
        FROM EMPLOYEES e
        WHERE EMPLOYEE_ID = i;
    END LOOP;
    
    -- DESCUBRIMIENTO 2 SE PUEDE USAR .FIRST Y .LAST
    FOR i IN v_mis_empleados.FIRST..v_mis_empleados.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(v_mis_empleados(i).v_nombre||'         '
                                ||v_mis_empleados(i).v_sal_empleados
                                ||'         '
                                ||v_mis_empleados(i).v_cod_dept
                                );
    END LOOP;
    
    -- DESCUBRIMIENTO 3 ESTRUCTURA DE 3 NIVELES DE DATOS VARIABLE.(FUNCIÓN).DATO_RAÍZ
    DBMS_OUTPUT.PUT_LINE(v_mis_empleados(v_mis_empleados.FIRST).v_nombre);
    DBMS_OUTPUT.PUT_LINE(V_MIS_EMPLEADOS(V_MIS_EMPLEADOS.LAST).V_NOMBRE);
    DBMS_OUTPUT.PUT_LINE(V_MIS_EMPLEADOS.COUNT);
    
    FOR i IN v_mis_empleados.FIRST..v_mis_empleados.LAST LOOP
        IF v_mis_empleados(i).v_sal_empleados<7000 THEN
            ---- DESCUBRIMIENTO 4 LA FUNCIÓN .DELETE
            V_MIS_EMPLEADOS.DELETE(i);
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_MIS_EMPLEADOS.COUNT);
    
    -- NO DATA FOUND PORQUE YA NO SON LOS VALORES ANTES RECONOCIDOS
    -- SE HAN MODIFICADO ALV
    FOR i IN v_mis_empleados.FIRST..v_mis_empleados.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(v_mis_empleados(i).v_nombre||'         '
                                ||v_mis_empleados(i).v_sal_empleados
                                ||'         '
                                ||v_mis_empleados(i).v_cod_dept
                                );
    END LOOP;
END;

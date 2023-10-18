SET SERVEROUTPUT ON
-- CASE THEN
DECLARE
    v VARCHAR2(10);
BEGIN
    v := 'C';
    CASE v
        WHEN 'A' THEN
            dbms_output.put_line('A');
        WHEN 'B' THEN
            dbms_output.put_line('B');
        ELSE
            dbms_output.put_line('NO DATA MATCH');
    END CASE;

END;

-- SEARCHED CASE
DECLARE
    v NUMBER;
BEGIN
    v := 201;
    CASE
        WHEN
            v <= 100
            AND v > 0
        THEN
            dbms_output.put_line('A');
        WHEN
            v <= 200
            AND v > 100
        THEN
            dbms_output.put_line('B');
        ELSE
            dbms_output.put_line('NO DATA MATCH');
    END CASE;

END;

-- IF THEN
DECLARE
    v2 VARCHAR2(10);
BEGIN
    v2 := 'D';
    IF v2 = 'A' THEN
        dbms_output.put_line('A');
    ELSIF v2 = 'B' THEN
        dbms_output.put_line('B');
    ELSIF v2 = 'C' THEN
        dbms_output.put_line('C');
    ELSE
        dbms_output.put_line('NO DATA MATCH');
    END IF;

END;

-- USER
DECLARE
    usuario VARCHAR2(40);
BEGIN
    usuario := user();
    dbms_output.put_line(usuario);
END;

-- LOOP
DECLARE
    v NUMBER;
BEGIN
    v := 0;
    LOOP
        v := v + 1;
        dbms_output.put_line(v);
        EXIT WHEN v = 1;
    END LOOP;

END;

-- IDENTIFICADORES
DECLARE
    x NUMBER := 1;
    y NUMBER := 100;
    z NUMBER := 0;
BEGIN
    << l1 >> LOOP
        EXIT l1 WHEN x > 5;
        dbms_output.put_line(x);
        y := 100;
        x := x + 1;
        << l2 >> LOOP
            EXIT l2 WHEN y > 105;
            dbms_output.put_line(y);
            y := y + 1;
        END LOOP l2;

    END LOOP l1;
END;

-- CONTINUE (NO LE VEO EL USO)
DECLARE
    x NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line('L1 --> ' || to_char(x));
        x := x + 1;
        CONTINUE WHEN x = 3; -- REINICIA EL BUCLE
        dbms_output.put_line('L2 --> ' || to_char(x));
        EXIT WHEN x = 5;
    END LOOP;
END;

-- FOR
DECLARE BEGIN
    FOR i IN REVERSE 1..15 LOOP
        dbms_output.put_line(i);
        EXIT WHEN i = 9;
    END LOOP;
END;

-- FOR CON STEP
DECLARE BEGIN
    FOR i IN 1..15 LOOP
        IF MOD(i, 3) = 0 THEN
            -- SOLO PASAN DE 3 EN 3 OSEA 5 VECES
            dbms_output.put_line(i);
        END IF;
    END LOOP;
END;

-- WHILE CON BOOL
DECLARE
    x BOOLEAN := false;
BEGIN
    WHILE x LOOP
        dbms_output.put_line('No jala por aca');
        x := true;
    END LOOP;
    WHILE NOT x LOOP --BASICAMENTE ES UN WHILE TRUE
        dbms_output.put_line('Si jala por aca');
        x := true;
    END LOOP;

END;

-- WHILE
DECLARE
    i INTEGER := 10;
BEGIN
    WHILE i > 1 LOOP
        dbms_output.put_line(i);
        i := i - 1;
    END LOOP;
END;

-- GOTO
DECLARE
    p VARCHAR2(30);
    n PLS_INTEGER := 98;
BEGIN
    FOR i IN 2..round(sqrt(n)) LOOP
        IF MOD(n, i) = 0 THEN
            p := 'NO PRIMO';
            GOTO imprimiendo;
        ELSE
            p := 'PRIMO';
        END IF;
    END LOOP;

    << imprimiendo >> dbms_output.put_line(to_char(n)
                                           || p);
END;


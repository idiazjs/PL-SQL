-- IS TABLE OF

DECLARE 
    TYPE t_mytype IS TABLE OF
        COUNTRIES%ROWTYPE
    INDEX BY PLS_INTEGER;
    v_miciudad t_mytype;
BEGIN
    SELECT * 
    INTO v_miciudad(1)
    FROM COUNTRIES
    WHERE COUNTRY_ID='AR';  
END;
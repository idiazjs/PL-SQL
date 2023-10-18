CREATE TABLE DIRECCIONES (
    TIPO VARCHAR2(50),
    CALLE VARCHAR2(100),
    NUMERO VARCHAR2(10),
    CIUDAD VARCHAR2(50),
    ESTADO VARCHAR2(50),
    CODIGO_POSTAL VARCHAR2(10)
);

/

DECLARE
    JSON_TEXT       CLOB;
    JSON_OBJ        JSON_OBJECT_T;
    DIRECCIONES_ARR JSON_ARRAY_T;
    DIRECCION_OBJ   JSON_OBJECT_T;
    TIPO            VARCHAR2(50);
    CALLE           VARCHAR2(100);
    NUMERO          VARCHAR2(10);
    CIUDAD          VARCHAR2(50);
    ESTADO          VARCHAR2(50);
    CODIGO_POSTAL   VARCHAR2(10);
BEGIN
 -- Aquí es donde insertas tu JSON
    JSON_TEXT := '{
        "nombre": "Juan Pérez",
        "edad": 30,
        "ocupacion": "Ingeniero de software",
        "direcciones": [
          {
            "tipo": "Casa",
            "calle": "Avenida Siempre Viva",
            "numero": "123",
            "ciudad": "Springfield",
            "estado": "Inexistente",
            "codigo postal": "98765"
          },
          {
            "tipo": "Casa de campo",
            "calle": "Calle Falsa",
            "numero": "456",
            "ciudad": "Shelbyville",
            "estado": "Inexistente",
            "codigo postal": "87654"
          }
        ]
    }';
    JSON_OBJ := JSON_OBJECT_T.PARSE(JSON_TEXT);
    DIRECCIONES_ARR := JSON_OBJ.GET_ARRAY('direcciones');
    FOR I IN 0 .. DIRECCIONES_ARR.GET_SIZE - 1 LOOP
        DIRECCION_OBJ := TREAT(DIRECCIONES_ARR.GET(I) AS JSON_OBJECT_T);
        TIPO := DIRECCION_OBJ.GET_STRING('tipo');
        CALLE := DIRECCION_OBJ.GET_STRING('calle');
        NUMERO := DIRECCION_OBJ.GET_STRING('numero');
        CIUDAD := DIRECCION_OBJ.GET_STRING('ciudad');
        ESTADO := DIRECCION_OBJ.GET_STRING('estado');
        CODIGO_POSTAL := DIRECCION_OBJ.GET_STRING('codigo postal');
        INSERT INTO DIRECCIONES VALUES (
            TIPO,
            CALLE,
            NUMERO,
            CIUDAD,
            ESTADO,
            CODIGO_POSTAL
        );
    END LOOP;
    COMMIT;
END;
/

SELECT
    *
FROM
    DIRECCIONES;
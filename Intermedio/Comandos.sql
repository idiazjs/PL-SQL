-- CAMBIA LA MALDITA COMA DECIMAL POR PUNTO DECIMAL :3
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';

-- vERIFICA EL ESTADO DEL LISTENER
LSNRCTL STATUS

-- MUESTRA LOS ULTIMOS ERRORES
SELECT * FROM USER_ERRORS;
-- FUNCTIONS

UPPER		DEF  	Convierte un VARCHAR2(n) a MAYÚSCULAS
			SXS  	UPPER(X);

LOWER		DEF  	Convierte un VARCHAR2(n) a MAYÚSCULAS
			SXS  	LOWER(X);

SUBSTR		DEF  	OBTIENE LOS CARACTERES N(3) A PARTIR DE 
					UNA POSISION(1)
			SXS  	SUBSTR(X,1,3);

LENGTH		DEF		OBTIENE EL TAMAÑO DE UN VARCHAR2
			SXS		LENGTH(X);

TO_DATE		DEF  	Convierte una cadena de caracteres a date
			SXS  	TO_DATE('10/10/1965');

TO_CHAR		DEF  	Obtiene el nómbre del apartado de una fecha
			SXS  	TO_CHAR(X,'DAY');

ABS			DEF  	Obtiene el valor absoluto
			SXS  	ABS(X);

FLOOR		DEF  	Obtiene el entero más grande del 
					NUMBER OR VARCHAR2(n)
			SXS		FLOOR(X);

LN			DEF  	Obtiene el logaritmo natural del 
					NUMBER OR VARCHAR2(n)
			SXS		LN(X);

MOD			DEF  	Obtiene el residuo de una división
			SXS  	MOD(X,2);

ROUND		DEF		REDONDEA UN DATO DECIMAL TO INTEGER
			SXS		ROUND(X);

SQRT		DEF		RAIZ CUADRADA DE INTEGER
			SXS		SQRT(X);

RANDOM		DEF		NÚMERO RANDOM CON DECIMAL
			SXS		dbms_random.value(1,10);



-- EXCEPTIONS

RAISE_APPLICATION_ERROR(-20001, 'La solicitud dio fin porque....');
-- RISE_ALPLICATION_ERROR (-20001 TO -20998)

TOO_MANY_ROWS		Se produce cuando el SELECT devuelve más
					de una fila

NO_DATA_FOUND		Se produce cuando el SELECT no devuelve
					ninguna fila

LOGIN_DENIED		Se produce cuando se intenta establecer
					una conexión con ORACLE con llaves no
					validas

NOT_LOGGED_ON		Se produce cuando intentamos acceder a
					la DB cuando no establecimos una conexión

PROGRAM_ERROR		Se produce cuando hay un problema interno 
					en la ejecución del programa.

VALUE_ERROR			Se produce cuando hay un error aritmético 
					o de conversión.

ZERO_DIVIDE			Se puede cuando hay una división entre 0
					
DUPVAL_ON_INDEX		Se crea cuando se intenta almacenar un 
					valor que crearía duplicados en la clave 
					primaria o en una columna con restricción 
					UNIQUE.

INVALID_NUMBER		Se produce cuando se intenta convertir una 
					cadena a un valor numérico.


/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' USING PigStorage('\t') 
        AS (f1:CHARARRAY, 
        f2:BAG{dict:TUPLE(letter:chararray)},
        f3:MAP[]);

letters = FOREACH lines GENERATE FLATTEN(f2) AS key1, FLATTEN(f3) AS key2;

letters_keys = FOREACH letters GENERATE key1, TOKENIZE(key2, ',') AS key2_b;

grouped = GROUP letters_keys BY key1 AS key1_1;

wordcount = FOREACH grouped GENERATE group, COUNT(key1_1);

dump wordcount
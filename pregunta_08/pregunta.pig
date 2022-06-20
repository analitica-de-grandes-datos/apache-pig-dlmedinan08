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

grouped = GROUP letters BY (key1, key2);

wordcount = FOREACH grouped GENERATE group, COUNT(letters);

STORE wordcount INTO 'output' USING PigStorage(',');
/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' USING PigStorage('\t') 
        AS (f1:CHARARRAY, 
        f2:CHARARRAY,
        f3:CHARARRAY);

letters = FOREACH lines GENERATE f1,  TOKENIZE(f2,',') AS key1, TOKENIZE(f3,',') AS key2;

wordcount = FOREACH letters GENERATE f1 AS f1, COUNT(key1) AS key1, COUNT(key2) AS key2;

ordered_data = ORDER wordcount BY f1, key1, key2;

STORE ordered_data INTO 'output' USING PigStorage(',');
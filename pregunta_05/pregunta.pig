/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' USING PigStorage('\t') 
        AS (f1:CHARARRAY, 
        f2:BAG{dict:TUPLE(letter:chararray)});

letters = FOREACH lines GENERATE FLATTEN(f2) AS letter;

grouped = GROUP letters BY letter;

wordcount = FOREACH grouped GENERATE group, COUNT(letters);

STORE wordcount INTO 'output' USING PigStorage(',');


/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' USING PigStorage('\t') 
        AS (f1:CHARARRAY, 
        f2:BAG{dict:TUPLE(letter:chararray)},
        f3:MAP[]);

letters = FOREACH lines GENERATE FLATTEN(f3) AS key;

grouped = GROUP letters BY key;

wordcount = FOREACH grouped GENERATE group, COUNT(letters);

STORE wordcount INTO 'output' USING PigStorage(',');
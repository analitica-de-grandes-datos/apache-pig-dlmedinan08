/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' USING PigStorage('\t') 
        AS (line:CHARARRAY, date:CHARARRAY, number:INT);

specific_columns = FOREACH lines GENERATE number;

ordered_data = ORDER specific_columns BY number asc;

top5 = LIMIT ordered_data 5;

STORE top5 INTO 'output' USING PigStorage(',');
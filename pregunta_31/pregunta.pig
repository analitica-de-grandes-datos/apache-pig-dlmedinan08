/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

persons = LOAD 'data.csv' USING PigStorage(',') 
        AS (f1:INT,
        f2:CHARARRAY,  
        f3:CHARARRAY,
        f4:CHARARRAY,
        f5:CHARARRAY);

dates = FOREACH persons GENERATE ToDate(f4, 'yyyy-MM-dd') AS birthday;

dates_2 = FOREACH dates GENERATE ToString(birthday, 'yyyy') AS year;

dates_3 = GROUP dates_2 BY year;

dates_4 = FOREACH dates_3 GENERATE group, COUNT(dates_2);

STORE dates_4 INTO 'output' USING PigStorage(',');

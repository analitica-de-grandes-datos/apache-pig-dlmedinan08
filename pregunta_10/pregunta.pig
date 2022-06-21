/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.csv' USING PigStorage(',') 
        AS (f1:INT,
        f2:CHARARRAY,  
        f3:CHARARRAY);

last_names = FOREACH lines GENERATE f3 AS last_name, SIZE(f3) AS length;

last_names_order = ORDER last_names BY length desc, last_name asc;

top5 = LIMIT last_names_order 5;

STORE top5 INTO 'output' USING PigStorage(',');
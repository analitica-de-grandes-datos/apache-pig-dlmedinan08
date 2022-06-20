/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') 
        AS (f1:INT,
        f2:CHARARRAY,  
        f3:CHARARRAY);

last_names_f = FILTER lines BY STARTSWITH(f3, 'D') OR STARTSWITH(f3, 'E') OR STARTSWITH(f3, 'F') OR STARTSWITH(f3, 'G') OR STARTSWITH(f3, 'H') OR STARTSWITH(f3, 'I') OR STARTSWITH(f3, 'J') OR STARTSWITH(f3, 'K');

last_names = FOREACH last_names_f GENERATE f3 AS last_name;

STORE last_names INTO 'output' USING PigStorage(',');
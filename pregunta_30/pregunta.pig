/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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

dates_2 = FOREACH dates GENERATE ToString(birthday, 'yyyy-MM-dd') AS full_date
                                , ToString(birthday, 'dd') AS full_day
                                , ToString(birthday, 'd') AS day
                                , LOWER(ToString(birthday, 'EEEEE')) AS week_day;

dates_3 = FOREACH dates_2 GENERATE full_date
                                , full_day
                                , day
                                , REPLACE(week_day, 'monday', 'lunes') AS week_day;

dates_4 = FOREACH dates_3 GENERATE full_date
                                , full_day
                                , day
                                , REPLACE(week_day, 'tuesday', 'martes') AS week_day;

dates_5 = FOREACH dates_4 GENERATE full_date
                                , full_day
                                , day
                                , REPLACE(week_day, 'wednesday', 'miercoles') AS week_day;

dates_6 = FOREACH dates_5 GENERATE full_date
                                , full_day
                                , day
                                , REPLACE(week_day, 'thursday', 'jueves') AS week_day;

dates_7 = FOREACH dates_6 GENERATE full_date
                                , full_day
                                , day
                                , REPLACE(week_day, 'friday', 'viernes') AS week_day;

dates_8 = FOREACH dates_7 GENERATE full_date
                                , full_day
                                , day
                                , REPLACE(week_day, 'saturday', 'sabado') AS week_day;

dates_9 = FOREACH dates_8 GENERATE full_date
                                , full_day
                                , day
                                , REPLACE(week_day, 'sunday', 'domingo') AS week_day;

dates_10 = FOREACH dates_9 GENERATE full_date
                                , full_day
                                , day
                                , SUBSTRING(week_day, 0, 3) AS week_day_s
                                , week_day;


--STORE dates_3 INTO 'output' USING PigStorage(',');

dump dates_10;
/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

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

dates_2 = FOREACH dates GENERATE ToString(birthday, 'yyyy-MM-dd') AS full_date, LOWER(ToString(birthday, 'MMM')) AS month, ToString(birthday, 'MM') AS month_2digit, ToString(birthday, 'M') AS month_1digit;

dates_3 = FOREACH dates_2 GENERATE full_date
                                , REPLACE(month, 'apr', 'abr') AS month
                                , month_2digit
                                , month_1digit;

dates_4 = FOREACH dates_3 GENERATE full_date
                                , REPLACE(month, 'jan', 'ene') AS month
                                , month_2digit
                                , month_1digit;

dates_5 = FOREACH dates_4 GENERATE full_date
                                , REPLACE(month, 'dec', 'dic') AS month
                                , month_2digit
                                , month_1digit;

dates_6 = FOREACH dates_5 GENERATE full_date
                                , REPLACE(month, 'aug', 'ago') AS month
                                , month_2digit
                                , month_1digit;

STORE dates_6 INTO 'output' USING PigStorage(',');
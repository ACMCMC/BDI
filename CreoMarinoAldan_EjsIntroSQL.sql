--Aldán Creo Mariño, BDI 2020/21

--Obtener las tormentas de la temporada 2005
    SELECT * FROM "tormentas" WHERE "temporada" = 2005;

    SELECT * FROM public."tormentas" WHERE 2005 BETWEEN EXTRACT(YEAR FROM "inicio") AND EXTRACT(YEAR FROM "fin"); --Alternativa. Así obtenemos las tormentas que sucedieron en 2005

    (SELECT * FROM "tormentas" WHERE "temporada" = 2005 UNION SELECT * FROM public."tormentas" WHERE 2005 BETWEEN EXTRACT(YEAR FROM "inicio") AND EXTRACT(YEAR FROM "fin")) EXCEPT (SELECT * FROM "tormentas" WHERE "temporada" = 2005 INTERSECT SELECT * FROM public."tormentas" WHERE 2005 BETWEEN EXTRACT(YEAR FROM "inicio") AND EXTRACT(YEAR FROM "fin")); --La diferencia entre la primera y la segunda consulta. Hacemos la UNION y a eso le restamos (EXCEPT) la intersección (INTERSECT). Esto son las tuplas que están solo en A o en B, pero no en las dos a la vez.

--Obtener los datos de la tormenta KATRINA de la temporada 2005
SELECT * FROM tormentas WHERE nombre = 'KATRINA' and temporada = 2005;

--Obtener el nombre y la velocidad del viento máxima (en metros por segundo), de las tormentas de la temporada 2008 que se habían iniciado antes del mes de febrero
SELECT nombre, viento_max*1000/3600 as velocidad FROM tormentas WHERE temporada = 2008 and 02 < EXTRACT(MONTH FROM inicio);

--Obtener las regiones afectadas por tormentas de la temporada 2012 que superaron los 200 km/h
SELECT DISTINCT pais, region FROM regiones_afectadas as ra cross join tormentas as t WHERE t.nombre = ra.nombre and t.temporada = ra.temporada and t.temporada = 2012 and viento_max > 200;

--Obtener los datos de todas las tormentas que afectaron al estado de “Florida” de “United States” después del 2000
SELECT * FROM tormentas WHERE (nombre, temporada) in (SELECT nombre, temporada FROM regiones_afectadas WHERE pais = 'United States' and region='Florida' and temporada >= 2000);

SELECT * FROM tormentas as t cross join regiones_afectadas as ra WHERE t.temporada=ra.temporada and t.nombre=ra.nombre and t.temporada>=2000 and pais='United States' and region='Florida'; --Versión alternativa

--Obtener el viento máximo que ha afectado algún estado de “Mexico”.
SELECT max(viento_max) FROM tormentas as t cross join regiones_afectadas as ra WHERE t.nombre = ra.nombre and t.temporada=ra.temporada and pais='Mexico';

--Obtener la fecha de fin del último huracán del la temporada 2005 que afectó a “Bahamas”
SELECT max(fin) FROM tormentas as t cross join regiones_afectadas as ra WHERE t.nombre=ra.nombre and t.temporada=ra.temporada and t.temporada=2005 and pais='Bahamas';

--Obtener el número de estados de cada país que ha afectado cada uno de los huracanes de la temporada 2010. Ordena los resultados de forma ascendente por huracán y de forma descendente por el número de estados afectados.
SELECT ra.nombre as huracan, ra.pais, count(*) as numero FROM tormentas as t cross join regiones_afectadas as ra WHERE t.nombre=ra.nombre and t.temporada=ra.temporada and t.temporada=2010 GROUP BY ra.nombre, ra.pais ORDER BY ra.nombre ASC, count(*) DESC;

--Obtener el número de huracanes y la velocidad máxima de un huracán que afectó a cada uno de los estados de “México”. Ordena el resultado de forma descendiente por velocidad.
SELECT ra.region, count(*), max(t.viento_max) as viento_max FROM tormentas as t cross join regiones_afectadas as ra WHERE t.nombre=ra.nombre and t.temporada=ra.temporada and pais='Mexico' GROUP BY ra.region ORDER BY viento_max DESC;

--Obtener los países que han sido afectados por más de 50 huracanes distintos. Ordena el resultado por el número de huracanes de forma descendiente.
SELECT pais, count(distinct (temporada, nombre)) as numero FROM regiones_afectadas GROUP BY pais HAVING count(distinct (temporada, nombre)) > 50 ORDER BY numero DESC;

SELECT pais, count(distinct (temporada, nombre)) as numero FROM regiones_afectadas GROUP BY pais HAVING (SELECT count(*) FROM regiones_afectadas GROUP BY temporada, nombre as nombreinner HAVING nombreinner = nombre) > 50 ORDER BY numero DESC;

--Obtener los estados de “United States” que hayan soportados vientos máximos de más de 280 km/h entre agosto del 2005 y febrero de 2009. Ordenar el resultado por el viento máximo soportado de forma descendiente.

--Para cada país que haya soportado huracanes en las temporadas 2005 y 2006, obtener el número de huracanes con vientos medios de más de 100 Km/h que han soportado en cada una de esas temporadas. Ordena el resultado de forma ascendente por país.

--Obtener la lista de países afectados por el huracán con el viento medio más alto.

--Obtener los datos de las tormentas que han afectado a Cuba en la temporada 2005.

--Obtener los nombres de los países que o bien hayan tenido más de tres huracanes en el 2005 o bien hayan soportado vientos máximos de más de 200 km/h en la temporada 2010. Anota los primeros con el texto “MasTresHuracane s” y los segundos con el texto “Mas200KM/H”. Ordena el resultado por país.

--Obtener los nombres de los países que nunca hayan sido afectados por ningún huracán.

--Temporada y valores de viento de las tormentas llamadas “KATRINA”, junto con las regiones de cada país que han sido afectadas. Ordena el resultado por temporada, país y región.

--Temporada y valores de viento de las tormentas llamadas “KATRINA”, junto con las regiones de cada país que han sido afectadas. Ordena el resultado por temporada, país y región. Incluye en el listado las tormentas que no han afectado a ninguna región.

--Obtén la lista de tormentas llamadas “KATRINA” que han afectado regiones de “Cuba”, incluyendo en el listado dichas regiones. Incluye también las tormentas “KATRINA” que no hayan afectado a regiones de “Cuba” y las regiones de “Cuba” que no hayan sido afectadas por tormentas “KATRINA”
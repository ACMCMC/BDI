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
SELECT distinct pais, region FROM regiones_afectadas as ra cross join tormentas as t WHERE t.nombre = ra.nombre and t.temporada = ra.temporada and t.temporada = 2012 and viento_max > 200;
SELECT pais, region FROM regiones_afectadas as ra inner join tormentas as t using(temporada, nombre) WHERE temporada=2012 and viento_max>200;



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
SELECT distinct region, viento_max FROM regiones_afectadas as ra cross join tormentas as t WHERE pais='United States' and t.viento_max>280 and inicio BETWEEN '2005-08-01' AND '2009-02-01' and ra.nombre=t.nombre and ra.temporada=t.temporada ORDER BY viento_max;



--Para cada país que haya soportado huracanes en las temporadas 2005 y 2006, obtener el número de huracanes con vientos medios de más de 100 Km/h que han soportado en cada una de esas temporadas. Ordena el resultado de forma ascendente por país.
--Divide y vencerás: Primero consultamos todos los de la temporada 2005
SELECT pais, count(distinct t.nombre) as temp2005 FROM tormentas as t, regiones_afectadas as ra WHERE t.nombre = ra.nombre and t.temporada = ra.temporada and t.temporada = 2005 and t.viento_medio > 100 GROUP BY ra.pais;
--Ahora lo repetimos para 2006 y lo juntamos en una tabla
SELECT t2005.pais, temp2005, temp2006 FROM (SELECT pais, count(distinct t.nombre) as temp2005 FROM tormentas as t, regiones_afectadas as ra WHERE t.nombre = ra.nombre and t.temporada = ra.temporada and t.temporada = 2005 and t.viento_medio > 100 GROUP BY ra.pais) as t2005 cross join (SELECT pais, count(distinct t.nombre) as temp2006 FROM tormentas as t, regiones_afectadas as ra WHERE t.nombre = ra.nombre and t.temporada = ra.temporada and t.temporada = 2006 and t.viento_medio > 100 GROUP BY ra.pais) as t2006 WHERE t2005.pais = t2006.pais;

--Podemos crear una función:
CREATE OR REPLACE FUNCTION tablaTemporada (IN temporada_input INTEGER) RETURNS TABLE (pais VARCHAR(75), temporada INTEGER) AS 'SELECT pais, count(distinct t.nombre) as temporada FROM tormentas as t, regiones_afectadas as ra WHERE t.nombre = ra.nombre and t.temporada = ra.temporada and t.temporada = temporada_input and t.viento_medio > 100 GROUP BY ra.pais;' LANGUAGE SQL;

SELECT t2005.pais, t2005.temporada, t2006.temporada FROM tablaTemporada(2005) as t2005 cross join tablaTemporada(2006) as t2006 WHERE t2005.pais = t2006.pais; --Es lo mismo que arriba



--Obtener la lista de países afectados por el huracán con el viento medio más alto.
SELECT distinct pais FROM regiones_afectadas as ra cross join tormentas as t WHERE t.nombre = ra.nombre and t.temporada = ra.temporada and viento_medio IN (SELECT max(viento_medio) FROM tormentas);



--Obtener los datos de las tormentas que han afectado a Cuba en la temporada 2005.
SELECT * FROM tormentas as t WHERE (t.nombre, t.temporada) in (SELECT ra.nombre, ra.temporada FROM regiones_afectadas as ra WHERE pais = 'Cuba') and t.temporada=2005; --Usando in
SELECT * FROM tormentas as t WHERE exists (SELECT * FROM regiones_afectadas as ra WHERE pais = 'Cuba' and ra.temporada=t.temporada and ra.nombre=t.nombre) and t.temporada=2005; --Usando exists
SELECT * FROM tormentas as t WHERE (t.nombre, t.temporada) = any (SELECT ra.nombre, ra.temporada FROM regiones_afectadas as ra WHERE pais = 'Cuba') and t.temporada=2005; --Usando any



--Obtener los nombres de los países que o bien hayan tenido más de tres huracanes en el 2005 o bien hayan soportado vientos máximos de más de 200 km/h en la temporada 2010. Anota los primeros con el texto “MasTresHuracanes” y los segundos con el texto “Mas200KM/H”. Ordena el resultado por país.
SELECT pais, 'MasTresHuracanes' as tipo FROM tormentas as t cross join regiones_afectadas as ra WHERE t.temporada = 2005 and ra.temporada=t.temporada and ra.nombre=t.nombre GROUP BY ra.pais HAVING count(pais) > 3; --Países con más de 3 huracanes
SELECT pais, 'Mas200KM/H' as tipo FROM tormentas as t cross join regiones_afectadas as ra WHERE ra.temporada=t.temporada and ra.nombre=t.nombre and t.temporada=2010 GROUP BY pais HAVING max(t.viento_max) > 200; --Países con vientos de más de 200KM/H en 2010

--UNIMOS LAS DOS CONSULTAS
(SELECT pais, 'MasTresHuracanes' as tipo FROM tormentas as t cross join regiones_afectadas as ra WHERE t.temporada = 2005 and ra.temporada=t.temporada and ra.nombre=t.nombre GROUP BY ra.pais HAVING count(distinct ra.nombre) > 3)
UNION ALL
(SELECT pais, 'Mas200KM/H' as tipo FROM tormentas as t cross join regiones_afectadas as ra WHERE ra.temporada=t.temporada and ra.nombre=t.nombre and t.temporada=2010 GROUP BY pais HAVING max(t.viento_max) > 200)
ORDER BY pais;



--Obtener los nombres de los países que nunca hayan sido afectados por ningún huracán.
SELECT pais FROM regiones GROUP BY pais HAVING not exists (SELECT pais FROM regiones_afectadas WHERE regiones_afectadas.pais=regiones.pais) ORDER BY pais;



--Temporada y valores de viento de las tormentas llamadas “KATRINA”, junto con las regiones de cada país que han sido afectadas. Ordena el resultado por temporada, país y región.
SELECT temporada, viento_max, viento_medio, pais, region FROM tormentas as t inner join regiones_afectadas as ra using (nombre, temporada) WHERE nombre='KATRINA' ORDER BY temporada, pais, region;



--Temporada y valores de viento de las tormentas llamadas “KATRINA”, junto con las regiones de cada país que han sido afectadas. Ordena el resultado por temporada, país y región. Incluye en el listado las tormentas que no han afectado a ninguna región.
SELECT temporada, viento_max, viento_medio, pais, region FROM tormentas as t left outer join regiones_afectadas as ra using (nombre, temporada) WHERE nombre='KATRINA' ORDER BY temporada, pais, region;



--Obtén la lista de tormentas llamadas “KATRINA” que han afectado regiones de “Cuba”, incluyendo en el listado dichas regiones. Incluye también las tormentas “KATRINA” que no hayan afectado a regiones de “Cuba” y las regiones de “Cuba” que no hayan sido afectadas por tormentas “KATRINA”
(SELECT pais, region, temporada, nombre, inicio, fin, viento_max, viento_medio FROM tormentas as t inner join regiones_afectadas as ra using (nombre, temporada) WHERE nombre='KATRINA' and pais='Cuba') --Tormentas 'KATRINA' de 'Cuba'
UNION
(SELECT null as pais, null as region, temporada, nombre, inicio, fin, viento_max, viento_medio FROM tormentas WHERE nombre='KATRINA' and (nombre, temporada) not in (SELECT nombre, temporada FROM tormentas inner join regiones_afectadas using (nombre, temporada) WHERE nombre='KATRINA' and pais='Cuba')) --Tormentas 'KATRINA', que no son de 'Cuba'
UNION
(SELECT pais, region, null as temporada, null as nombre, null as inicio, null as fin, null as viento_max, null as viento_medio FROM regiones WHERE pais='Cuba' GROUP BY (pais, region) HAVING (pais, region) not in (SELECT pais, region FROM tormentas inner join regiones_afectadas using (nombre, temporada) WHERE nombre='KATRINA')) --Regiones de 'Cuba' que no han sido afectadas por 'KATRINA'
ORDER BY temporada, pais, region;

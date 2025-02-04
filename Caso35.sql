--Aldán Creo Mariño, BDI 2020/21

--Consultar los datos de los socios con nombre Antonio
SELECT * FROM socios WHERE nombre LIKE '%Antonio%';


--Consultar el código, nombre y fecha de ingreso en el videoclub de los socios con apellido López
SELECT socio, nombre, fec_ingreso FROM socios WHERE nombre LIKE '% López%';


--Calcular cuántas personas se hicieron socias en el último mes del año 2004
SELECT count(*) FROM socios WHERE fec_ingreso BETWEEN '2004-12-01' AND '2004-12-31';


--Consultar los datos de los socios cuyo teléfono empieza por 99922 o por 99923 y viven en la Avenida de Madrid
SELECT * FROM socios WHERE (telefono LIKE '99922%' OR telefono LIKE '99923%') AND direccion LIKE 'Av. Madrid%'; --USANDO LIKE
SELECT * FROM socios WHERE telefono ~ '9992[23]' AND direccion LIKE 'Av. Madrid%'; --USANDO REGEX


--Consultar los datos de los socios ordenados por la fecha de ingreso
SELECT * FROM socios ORDER BY fec_ingreso;


--Consultar el código de socio, nombre y fecha de ingreso ordenados por la fecha de ingreso en orden ascendente y por el nombre en orden descendente
SELECT socio, nombre, fec_ingreso FROM socios ORDER BY fec_ingreso, nombre DESC;


--Calcular cuál es la duración mayor de las películas del videoclub
SELECT max(duracion) FROM peliculas;


--Consultar los datos de la película más larga
SELECT * FROM peliculas as peliculaFuera WHERE not exists (SELECT * FROM peliculas as peliculaComp WHERE peliculaComp.duracion > peliculaFuera.duracion );


--Cuál es el precio medio de una película en el videoclub
SELECT avg(precio) FROM peliculas;


--Cuántas películas están por encima del precio medio
SELECT count(*) FROM peliculas WHERE precio not in (SELECT precio FROM peliculas WHERE precio <= (SELECT avg(precio) FROM peliculas));


--Consultar el precio, el título y la duración de las películas que están por debajo del precio medio
SELECT precio, titulo, duracion FROM peliculas WHERE precio < (SELECT avg(precio) FROM peliculas);


--Consultar los préstamos que han tenido una duración superior a dos días
SELECT * FROM prestamos WHERE fec_entrega NOT BETWEEN fec_retirada AND fec_retirada + interval '2 days';


--Consultar los datos de las películas que han sido prestadas con una duración superior a dos días
SELECT * FROM peliculas WHERE pelicula in (SELECT pelicula FROM prestamos WHERE fec_entrega NOT BETWEEN fec_retirada AND fec_retirada + interval '2 days');


--Consultar los nombres de los socios que han alquilado la película 16
SELECT distinct nombre FROM socios inner join prestamos using (socio) WHERE pelicula=16;


--Seleccionar las películas ordenadas por país en orden descendente, tema en orden ascendente y precio en orden descendente
SELECT * FROM peliculas ORDER BY pais DESC, tema, precio DESC;


--Seleccionar las películas españolas en orden descendente por tema y en orden ascendente por clasificación
SELECT * FROM peliculas WHERE pais='España' ORDER BY tema DESC, clasificacion;


--Consultar los socios que han alquilado alguna de las películas prestadas al socio número 8
SELECT * FROM socios WHERE exists (SELECT * FROM socios as s2 inner join prestamos using(socio) WHERE exists (SELECT * FROM prestamos as p2 WHERE socio=8 and p2.pelicula=prestamos.pelicula) and s2.socio=socios.socio);


--Consultar cuántas películas ha retirado el socio número 4
SELECT count(*) FROM prestamos WHERE socio=4;


--Consultar cuántas películas distintas ha retirado el socio número 4
SELECT count(distinct pelicula) FROM prestamos WHERE socio=4;


--Consultar cuántas películas distintas ha retirado Carlos López Cano
SELECT count(distinct pelicula) FROM prestamos GROUP BY socio HAVING socio = ALL (SELECT socio FROM socios WHERE nombre LIKE 'Carlos L_pez Cano');
SELECT count(*) FROM (SELECT pelicula FROM prestamos inner join socios using(socio) WHERE nombre LIKE 'Carlos L_pez Cano' GROUP BY pelicula) as tpelis;
SELECT count(*) FROM (SELECT pelicula FROM prestamos WHERE socio = ALL (SELECT socio FROM socios WHERE nombre LIKE 'Carlos L_pez Cano') GROUP BY pelicula) as tpelis;


--Consultar los préstamos que aún no han sido devueltos
SELECT * FROM prestamos WHERE fec_entrega is null;


--Consultar los títulos de las películas que están fuera del videoclub
SELECT distinct titulo FROM prestamos inner join peliculas using (pelicula) WHERE fec_entrega is null;


--Consultar el nombre y número de teléfono de los socios que tienen alguna película en su casa
SELECT distinct nombre, telefono FROM socios WHERE exists (SELECT * FROM prestamos WHERE prestamos.socio=socios.socio and fec_entrega is null);


--Consultar los datos de las películas que ha retirado Miguel Armas Ruiz ordenadas por duración en orden descendente
SELECT * FROM peliculas WHERE exists (SELECT * FROM prestamos WHERE peliculas.pelicula=prestamos.pelicula and exists (SELECT * FROM socios WHERE socios.socio=prestamos.socio and socios.nombre='Miguel Armas Ruiz')) ORDER BY duracion DESC;


--Calcular cuánto dinero ha gastado Miguel Armas Ruiz desde que es socio del videoclub
SELECT sum(precio) FROM peliculas WHERE exists (SELECT * FROM prestamos WHERE peliculas.pelicula=prestamos.pelicula and exists (SELECT * FROM socios WHERE socios.socio=prestamos.socio and socios.nombre='Miguel Armas Ruiz'));


--Consultar los nombres y códigos de socios que han alquilado películas de suspense o acción no recomendadas para menores de 18 años ordenados por código de socio
SELECT nombre, socio as codigo FROM socios WHERE exists(SELECT * FROM prestamos WHERE prestamos.socio=socios.socio and exists(SELECT * FROM peliculas WHERE peliculas.pelicula=prestamos.pelicula and (peliculas.tema='Suspense' or peliculas.tema='Acción') and peliculas.clasificacion='NR18')) ORDER BY socio;


--Consultar cuántas películas ha sacado cada socio
SELECT socio, (SELECT count(*) FROM prestamos WHERE prestamos.socio=socios.socio) FROM socios; --Con consultas anidadas
SELECT socio, count(*) FROM socios inner join prestamos using(socio) GROUP BY socio; --Con grupos, no muestra los socios que no han sacado películas


--Consultar cuántas veces ha sido alquilada cada película
SELECT pelicula, (SELECT count(*) FROM prestamos WHERE prestamos.pelicula=peliculas.pelicula) FROM peliculas;
SELECT pelicula, count(*) FROM prestamos GROUP BY pelicula; --Con grupos


--Consultar el nombre, el código y el número de películas del socio que ha sacado más películas
CREATE OR REPLACE FUNCTION numPeliculas(codigo INTEGER) RETURNS INTEGER LANGUAGE SQL AS 'SELECT count(*) FROM prestamos WHERE prestamos.socio=codigo;';
SELECT nombre, socio as codigo, numPeliculas(s1.socio) as count FROM socios as s1 WHERE not exists (SELECT * FROM socios as s2 WHERE numPeliculas(s2.socio) > numPeliculas(s1.socio)); --Todos los socios para los cuales no hay otro socio que tiene más películas
SELECT nombre, socio as codigo, count(pelicula) FROM socios inner join prestamos using(socio) GROUP BY (nombre, socio) HAVING count(pelicula) = (SELECT max(count) FROM (SELECT count(*) FROM prestamos GROUP BY socio) as count); --El grupo (nombre, socio) que tiene el máximo de películas de todos los socios


--Consultar el nombre y código del socio junto con el dinero total gastado de aquellos socios que han gastado más de 10 euros en el videoclub
SELECT nombre, socio, gastado FROM (SELECT socio, sum(precio) as gastado FROM prestamos inner join peliculas using(pelicula) GROUP BY socio) as suma inner join socios using(socio) WHERE gastado>10;


--Consultar el título de la película más solicitada
SELECT titulo, peliculas.pelicula, count(*) FROM peliculas cross join prestamos WHERE peliculas.pelicula = prestamos.pelicula GROUP BY peliculas.pelicula HAVING not exists(SELECT p.pelicula FROM prestamos as p GROUP BY p.pelicula HAVING count(*)>count(prestamos.pelicula));


--Consultar los socios que han alquilado más de una vez la misma película
SELECT pelicula, socio, count(pelicula) FROM prestamos GROUP BY pelicula, socio HAVING count(*)>=2;


--Consultar cuántas películas hay de cada tema en el videoclub
SELECT tema, count(*) FROM peliculas GROUP BY tema;


--Agrupar las películas por precio mostrando el resultado en orden descendente
SELECT precio, count(*) FROM peliculas GROUP BY precio ORDER BY precio desc;


--Consultar los nombres de los socios que han alquilado alguna película ordenados por código de socio
SELECT * FROM socios WHERE exists (SELECT * FROM prestamos WHERE prestamos.socio=socios.socio) ORDER BY socio;


--Consultar los nombres de los socios que no han alquilado ninguna película
SELECT * FROM socios WHERE not exists (SELECT * FROM prestamos WHERE prestamos.socio=socios.socio);


--Consultar cuántas películas están fuera del videoclub
SELECT count(*) FROM prestamos WHERE fec_entrega is null;


--Consultar cuántos socios tienen películas por entregar
SELECT count(*) FROM socios WHERE exists (SELECT * FROM prestamos WHERE fec_entrega is null and prestamos.socio=socios.socio);


--Devolver el listado de las peliculas que nunca han sido prestadas
SELECT * FROM peliculas WHERE not exists (SELECT * FROM prestamos WHERE prestamos.pelicula=peliculas.pelicula);


--Obtener un listado de películas ordenado por el tiempo que han estado prestadas
SELECT pelicula, titulo, sum(tiempos_prestamos.tiempo_prestamo) as tiempo FROM peliculas inner join (SELECT prestamos.pelicula, prestamos.fec_entrega-prestamos.fec_retirada as tiempo_prestamo FROM prestamos WHERE prestamos.fec_entrega is not null) as tiempos_prestamos using(pelicula) GROUP BY pelicula ORDER BY tiempo desc;


--Obtener un listado de películas ordenado por el tiempo que tardaron en prestarse desde su compra
SELECT pelicula, titulo, (SELECT fec_retirada-fec_compra FROM (SELECT pelicula, fec_retirada FROM prestamos GROUP BY (pelicula, fec_retirada)) as pelis inner join (SELECT pelicula, min(fec_retirada) as fec_retirada FROM prestamos GROUP BY pelicula) as min_fec_retirada using(pelicula, fec_retirada) WHERE pelicula=peliculas.pelicula) as tiempo FROM peliculas ORDER BY tiempo;
SELECT pelicula, titulo, (SELECT min(fec_retirada) FROM prestamos WHERE pelicula=peliculas.pelicula)-fec_compra as tiempo FROM peliculas ORDER BY tiempo; --Forma simplificada


--Obtener un listado de socios ordenado por el tiempo que han tardado en alquilar su primera película desde que se registraron en el videoclub
SELECT nombre, (SELECT min(fec_retirada) FROM prestamos WHERE socio=socios.socio)-fec_ingreso as tiempo FROM socios ORDER BY tiempo desc;
SELECT nombre, (SELECT min(fec_retirada) FROM prestamos WHERE socio=socios.socio)-fec_ingreso as tiempo FROM socios WHERE exists(SELECT * FROM prestamos WHERE socio=socios.socio) ORDER BY tiempo desc; --Restringiendo a los que han alquilado alguna película


--Obtener un listado de los socios que más tardan en devolver las películas
SELECT socio, nombre, (SELECT avg(fec_entrega-fec_retirada) FROM prestamos WHERE socio=socios.socio and fec_entrega is not null) as devolucion FROM socios ORDER BY devolucion desc;


--Obtener para cada socio, el número de películas distintas que ha alquilado
SELECT socio, nombre, (SELECT count(*) FROM (SELECT pelicula FROM prestamos WHERE socio=socios.socio GROUP BY pelicula) as pelis_distintas) as peliculas FROM socios;


--Obtener los socios, ordenados por nombre, que no hayan alquilado ninguna película o que hayan devuelto todas las que han alquilado
SELECT * FROM socios WHERE not exists(SELECT * FROM prestamos WHERE socio=socios.socio and fec_entrega is null) ORDER BY nombre; --Sin indicar el motivo

(SELECT * FROM socios cross join (SELECT 'No alquiló' as tipo) as mensaje WHERE not exists(SELECT * FROM prestamos WHERE socio=socios.socio))
UNION
(SELECT * FROM socios cross join (SELECT 'Devolvió todas' as tipo) as mensaje WHERE exists(SELECT * FROM prestamos WHERE socio=socios.socio) and not exists(SELECT * FROM prestamos WHERE socio=socios.socio and fec_entrega is null)); --El conjunto de los socios s tal que existe un préstamo de s y no existe un préstamo de s sin devolver (por lo que están todos devueltos)
--Indicando el motivo, unimos las que no alquilaron con las que devolvieron todas


--Obtener para cada película el precio medio por día que ha sido prestada
SELECT pelicula, titulo, (SELECT avg(precio) FROM (SELECT (SELECT precio FROM peliculas as p_precio WHERE p_precio.pelicula=peliculas.pelicula)/(prestamos.fec_entrega-prestamos.fec_retirada) as precio FROM prestamos WHERE prestamos.pelicula=peliculas.pelicula) as precios_dia_por_alquiler) as precio_medio FROM peliculas; --Para cada película, obtenemos el precio de la película, lo dividimos por cada intervalo de fechas de préstamo en en que se ha devuelto la película, y eso es el precio de ese alquiler concreto, por lo que la media del precio es la media de los precios por alquiler


--Obtener los socios que más dinero se han gastado en el alquiler de películas españolas. En el listado deben aparecer también los socios que no han alquilado películas españolas
SELECT socio, nombre, CASE
    WHEN (SELECT sum(precio) FROM prestamos inner join peliculas using(pelicula) WHERE socio=socios.socio and pais='España')
        is not null THEN
    (SELECT sum(precio) FROM prestamos inner join peliculas using(pelicula) WHERE socio=socios.socio and pais='España')
    ELSE 0
    END
    as gasto FROM socios ORDER BY gasto desc;


--Obtener un informe de ingresos por cada tema, incluyendo los temas sobre los que no se ha alquilado ninguna película
SELECT tema, (SELECT sum(precio*(SELECT count(*) FROM prestamos WHERE pelicula=todas_peliculas.pelicula)) FROM peliculas as todas_peliculas WHERE todas_peliculas.tema=peliculas.tema) as ingresos FROM peliculas GROUP BY tema;


--Obtener un listado de películas ordenado por su precio por minuto, indicando si la película es 'Cara' (precio/minuto más de 0.035), 'Normal' (precio/minuto entre 0.025 y 0.035) o 'Barata' ( precio/minuto menor que 0.025)
SELECT pelicula, titulo, precminuto, CASE
    WHEN precminuto > 0.035 THEN 'Cara'
    WHEN precminuto < 0.025 THEN 'Barata'
    ELSE 'Normal'
    END
    as tipo
    FROM peliculas inner join (SELECT pelicula, precio/duracion as precminuto FROM peliculas) as tabla_peliculas_preciosminuto using(pelicula) ORDER BY precminuto desc;


--Aumentar en 0.25 el precio de las películas que cuestan menos de 3.50 euros
UPDATE peliculas SET precio=precio+0.25 WHERE precio<3.5;


--El socio 4 devuelve, el 15 de septiembre de 2005, las dos películas, códigos 11 y 16, que tenía
UPDATE prestamos SET fec_entrega='2005-09-15' WHERE (pelicula=11 or pelicula=16) and socio=4;


--El socio 5 saca la película 10 a fecha 15 de septiembre de 2005
INSERT INTO prestamos(pelicula, socio, fec_retirada, fec_entrega) VALUES (10, 5, '2005-09-15', NULL);


--El socio Salvador Ortega Rus se da de baja en el videoclub
DELETE FROM socios WHERE nombre='Ortega Rus';


--Añadir un nuevo campo en la tabla socios para mantener información de la fecha de nacimiento de los socios (mediante sentencia SQL)
ALTER TABLE socios ADD fec_nacimiento date;


--Eliminar la tabla socios de la base de datos (mediante sentencia SQL)
DROP TABLE socios;
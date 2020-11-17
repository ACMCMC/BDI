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
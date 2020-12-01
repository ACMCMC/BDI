--Aldán Creo Mariño, BDI 2020/21
 --1. Mostrar el número de modelo, la velocidad y el tamaño de disco duro de todos los PCs con un precio inferior a 1600.

SELECT modelo,
       velocidad,
       disco
FROM pcs
WHERE precio < 1600;

--2. Mostrar el número de modelo, la velocidad y el tamaño de disco duro de todos los PCs con un precio inferior a 2500, mostrando la velocidad en megahertz y el tamaño del disco duro en gigabytes.

SELECT modelo,
       velocidad as megahertz,
       disco as gigabytes
FROM pcs
WHERE precio < 2500;

--3. Mostrar el número de modelo, el tamaño de la memoria y de la pantalla de los ordenadores portátiles que cuesten más de 2000.

SELECT modelo,
       ram,
       pantalla
FROM portatiles
WHERE precio > 2000;

--4. Mostrar todos los datos de las impresoras a color.

SELECT *
FROM impresoras
WHERE color='c';

--5. Mostrar el número de modelo, la velocidad y el tamaño del disco duro de los PCs que tengan un disco compacto de 8x ó 12x y un precio menor de 2000.

SELECT modelo,
       velocidad,
       disco
FROM pcs
WHERE (cd='8x'
       or cd='12x')
    and precio < 2000;

--6. Mostrar los nombres de los fabricantes de impresoras láser.

SELECT fabricante
FROM productos
WHERE tipo='impresora'
    and exists
        (SELECT *
         FROM impresoras
         WHERE modelo=productos.modelo
             and tipo='laser')
GROUP BY fabricante; --También podemos usar distinct y ahorrarnos el group by, y podríamos hacer un natural join

--7. Mostrar los fabricantes de ordenadores personales cuyos modelos tengan una velocidad mínima de 200.

SELECT distinct fabricante
FROM productos
natural join pcs
WHERE tipo='pc'
    and velocidad >= 200;

--8. Mostrar, ordenados alfabéticamente por fabricante y por velocidad de menor a mayos, el fabricante y la velocidad de los ordenadores portátiles con un disco duro mayor de Gigabyte.

SELECT fabricante,
       velocidad
FROM portatiles
natural join productos
WHERE tipo='portatil'
    and disco>1
ORDER BY fabricante,
         velocidad;

--9. Mostrar las parejas de modelos de ordenadores personales que tienen la misma velocidad y memoria RAM (cada pareja debe aparecer una única vez en el listado)

SELECT p1.velocidad,
       p1.ram,
       p1.modelo,
       p2.modelo
FROM pcs as p1
cross join pcs as p2
WHERE p1.modelo<p2.modelo
    and p1.velocidad=p2.velocidad
    and p1.ram=p2.ram;

-------------------------------
--CÓMO SE HACE?
-------------------------------
 --10. Mostrar los tamaños de disco duro, ordenados de menor a mayor, que se presenten en dos o más ordenadores personales.

SELECT distinct disco
FROM pcs as pc1
WHERE
        (SELECT count(*)
         FROM pcs as pc2
         where pc1.disco=pc2.disco) > 1
ORDER BY disco asc; --Sin ORDER BY


SELECT disco
FROM pcs
GROUP BY disco
HAVING count(*) > 1;

--11. Mostrar la velocidad promedio de los portátiles que cuestan más de 2500.

SELECT avg(velocidad)
FROM portatiles
WHERE precio > 2500;

--12. Mostrar, agrupados y ordenados según su velocidad, el precio medio de los PCs.

SELECT velocidad,
       avg(precio) as precio_medio
FROM pcs
GROUP BY velocidad
ORDER BY velocidad;

--13. Mostrar los datos de la impresora más cara.

SELECT *
FROM impresoras as i1
WHERE not exists
        (SELECT *
         FROM impresoras as i2
         WHERE i2.precio > i1.precio);

--14. Mostrar los fabricantes, ordenados de forma descendente por número de productos, que producen al menos cinco modelo de PCs.

SELECT fabricante,
       count(*)
FROM productos
WHERE tipo='pc'
GROUP BY fabricante
HAVING count(*) >= 5
ORDER BY count(*) desc;

--15. Mostrar los datos de los portátiles cuya velocidad sea menor que la de cualquier ordenador personal.

SELECT *
FROM portatiles
WHERE velocidad < all
        (SELECT velocidad
         FROM pcs);--Con < all


SELECT *
FROM portatiles
WHERE not exists
        (SELECT *
         FROM pcs
         WHERE pcs.velocidad <= portatiles.velocidad);--Con not exists

--16. Mostrar, para los fabricantes ordenados, el precio de su PC más caro.

SELECT fabricante,
    (SELECT precio
     FROM
         (SELECT *
          FROM productos
          WHERE tipo='pc') as fabricantes_modelos_pc1
     inner join pcs as pc1 using(modelo)
     WHERE fabricantes_modelos_pc1.fabricante=productos.fabricante
         and not exists
             (SELECT *
              FROM
                  (SELECT *
                   FROM productos
                   WHERE tipo='pc') as fabricantes_modelos_pc2
              inner join pcs as pc2 using(modelo)
              WHERE pc2.precio > pc1.precio
                  and fabricantes_modelos_pc1.fabricante=fabricantes_modelos_pc2.fabricante)
     GROUP BY precio)
FROM productos
GROUP BY fabricante; --Usando not exists


SELECT fabricante,
    (SELECT max(precio)
     FROM
         (SELECT *
          FROM productos
          WHERE tipo='pc') as fabricantes_pcs
     inner join pcs using(modelo)
     WHERE fabricantes_pcs.fabricante=productos.fabricante)
FROM productos
GROUP BY fabricante; --Usando max()

--17. Mostrar los fabricantes de la impresora de color más barata.

SELECT fabricante,
       precio
FROM impresoras
inner join
    (SELECT *
     FROM productos
     WHERE tipo='impresora') as prod using(modelo)
WHERE color='c'
    and precio <= all
        (SELECT precio
         FROM impresoras
         WHERE color='c');

--18. Mostrar el número de modelo, el tipo (PC, portátil o impresora) y el precio de todos los productos elaborados por el fabricante B.

SELECT modelo,
       tipo,
       CASE
           WHEN tipo='pc' THEN
                    (SELECT distinct precio
                     FROM pcs
                     WHERE modelo=productos.modelo)
           WHEN tipo='impresora' THEN
                    (SELECT distinct precio
                     FROM impresoras
                     WHERE modelo=productos.modelo)
           WHEN tipo='portatil' THEN
                    (SELECT distinct precio
                     FROM portatiles
                     WHERE modelo=productos.modelo)
       END as precio
FROM productos
WHERE fabricante='B';--Usando case


SELECT modelo,
       tipo,
       precio
FROM (
          (SELECT modelo,
                  tipo,
                  precio,
                  fabricante
           FROM pcs
           inner join
               (SELECT *
                FROM productos
                WHERE tipo='pc') as prod using(modelo))
      UNION
          (SELECT modelo,
                  tipo,
                  precio,
                  fabricante
           FROM portatiles
           inner join
               (SELECT *
                FROM productos
                WHERE tipo='portatil') as prod using(modelo))
      UNION
          (SELECT modelo,
                  prod.tipo,
                  precio,
                  fabricante
           FROM impresoras
           inner join
               (SELECT *
                FROM productos
                WHERE productos.tipo='impresora') as prod using(modelo))) as prods
WHERE fabricante='B';--Usando uniones

--19. Mostrar, alfabéticamente, los nombres de los fabricantes de al menos 5 modelos diferentes de ordenadores personales o portátiles, con una velocidad mínima de 133

SELECT fabricante,
       count(*)
FROM (
          (SELECT velocidad,
                  fabricante
           FROM pcs
           inner join
               (SELECT *
                FROM productos
                WHERE tipo='pc') as prod using(modelo))
      UNION ALL
          (SELECT velocidad,
                  fabricante
           FROM portatiles
           inner join
               (SELECT *
                FROM productos
                WHERE tipo='portatil') as prod using(modelo))) as prods
WHERE velocidad > 133
GROUP BY fabricante
HAVING count(*) >=5
ORDER BY fabricante;

--20. Mostrar el precio promedio de los PCs y portátiles producidos por el fabricante A.

SELECT avg(precio)
FROM (
          (SELECT precio,
                  fabricante
           FROM pcs
           inner join
               (SELECT *
                FROM productos
                WHERE tipo='pc') as prod using(modelo))
      UNION ALL
          (SELECT precio,
                  fabricante
           FROM portatiles
           inner join
               (SELECT *
                FROM productos
                WHERE tipo='portatil') as prod using(modelo))) as prods
WHERE prods.fabricante='A';

--21. Mostrar los fabricantes del PC con el procesador más rápido entre todos los que tengan la menor capacidad de ram.

SELECT fabricante,
       modelo,
       velocidad,
       ram
FROM pcs as p1
inner join
    (SELECT *
     FROM productos
     WHERE tipo='pc') as prod using(modelo)
WHERE not exists
        (SELECT *
         FROM pcs as p2
         WHERE p2.ram<p1.ram
             or exists
                 (SELECT *
                  FROM pcs as p3
                  WHERE p3.ram=p1.ram
                      and p3.velocidad>p1.velocidad));--Usando exists y not exists


SELECT fabricante
FROM pcs as p1
inner join
    (SELECT *
     FROM productos
     WHERE tipo='pc') as prod using(modelo)
WHERE ram <= all
        (SELECT ram
         FROM pcs)
    and velocidad >= all
        (SELECT velocidad
         FROM pcs
         WHERE ram <= all
                 (SELECT ram
                  FROM pcs)); --Usando <= all

--22. Mostrar los fabricantes que proporcionen los tres tipos de impresoras (tinta, láser y térmica)

    (SELECT fabricante
     FROM
         (SELECT *
          FROM productos
          WHERE tipo='impresora') as prods
     inner join impresoras using(modelo)
     WHERE impresoras.tipo='tinta') INTERSECT
    (SELECT fabricante
     FROM
         (SELECT *
          FROM productos
          WHERE tipo='impresora') as prods
     inner join impresoras using(modelo)
     WHERE impresoras.tipo='laser') INTERSECT
    (SELECT fabricante
     FROM
         (SELECT *
          FROM productos
          WHERE tipo='impresora') as prods
     inner join impresoras using(modelo)
     WHERE impresoras.tipo='termica');--Usando intersect

--23. Para cada fabricante, mostrar el precio medio de sus impresoras, portátiles y pcs.

SELECT fabricante,
       tipo,
       avg(precio) as precio
FROM (
          (SELECT modelo,
                  tipo,
                  precio,
                  fabricante
           FROM pcs
           inner join
               (SELECT *
                FROM productos
                WHERE tipo='pc') as prod using(modelo))
      UNION
          (SELECT modelo,
                  tipo,
                  precio,
                  fabricante
           FROM portatiles
           inner join
               (SELECT *
                FROM productos
                WHERE tipo='portatil') as prod using(modelo))
      UNION
          (SELECT modelo,
                  prod.tipo,
                  precio,
                  fabricante
           FROM impresoras
           inner join
               (SELECT *
                FROM productos
                WHERE productos.tipo='impresora') as prod using(modelo))) as prods
GROUP BY fabricante,
         tipo
ORDER BY fabricante,
         tipo;

--24. Mostrar la velocidad, ram de modelo de pc con cd de 8x más barato ofertado por cada fabricante.

SELECT fabricante,
       velocidad,
       ram,
       disco,
       cd,
       precio,
       modelo
FROM pcs
inner join
    (SELECT *
     FROM productos
     WHERE tipo='pc') as prod using(modelo)
WHERE cd='8x'
    and not exists
        (SELECT *
         FROM pcs as pc2
         inner join
             (SELECT *
              FROM productos
              WHERE tipo='pc') as prod2 using(modelo)
         WHERE prod.fabricante=prod2.fabricante
             and cd='8x'
             and pc2.precio<pcs.precio);

--25. Mostrar una comprativa de pares PC-Portatil que tengan un precio similar (de no más de 100 euros de diferencia).
SELECT port.velocidad, port.ram, port.disco, port.pantalla, port.precio, port.modelo, pc.velocidad, pc.ram, pc.disco, pc.cd, pc.precio, pc.modelo FROM pcs as pc cross join portatiles as port WHERE pc.precio > port.precio-100 AND pc.precio < port.precio+100;

SELECT *
FROM impresoras;


SELECT *
FROM pcs;


SELECT *
FROM portatiles;


SELECT *
FROM productos;
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('nickname', 'contraseña', 'Nombre', 'Apellido1', 'Apellido2', 'ruta_a_la_foto.jpg', 'Biografía'); --T1

SELECT * FROM usuario WHERE nickname='nickname'; --T2

UPDATE usuario SET contrasena='contraseña', nombre='Nombre', apellido1='Apellido1', apellido2='Apellido2', foto_perfil='ruta_a_la_foto.jpg', biografia='Biografía' WHERE nickname='nickname'; --T3

DELETE FROM usuario WHERE nickname='nickname'; --T4

INSERT INTO bloquear(fecha, fecha_fin, motivo, nickname_usuario, nickname_moderador) VALUES ('1970-01-01 00:00:00', '1970-01-01 00:00:00', 'Motivo', 'nickname_usuario', 'nickname_moderador'); --T5

UPDATE bloquear SET fecha_fin=CURRENT_TIMESTAMP WHERE fecha_fin>CURRENT_TIMESTAMP and nickname_usuario='nickname'; --T6

INSERT INTO seguir(seguidor, seguido) VALUES ('nickname_seguidor', 'nickname_seguido'); --T7

DELETE FROM seguir WHERE seguidor='usuario que deja de seguir' and seguido='usuario al que dejar de seguir'; --T8

INSERT INTO dar_like(id_publicacion, nickname) VALUES (0, 'nickname'); --T9

DELETE FROM dar_like WHERE nickname='nickname' and id_publicacion=0;  --T10

INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES ('ID_publicacion', 'descripcion_publicacion', '1970-01-01 00:00:00', 'nickname_usuario'); --T11










SELECT nickname, CAST((SELECT count(*) FROM seguir WHERE seguido=nickname) AS FLOAT)/(SELECT count(*) FROM seguir WHERE seguidor=nickname) as popularidad FROM usuario WHERE exists(SELECT * FROM seguir WHERE seguidor=nickname); --T22. El número de seguidores del usuario entre el número de usuarios que sigue. Sólo lo calculamos para los usuarios que siguen a alguien, ya que si no tenemos un error de división por 0. (no tiene sentido calcular la popularidad de alguien que no sigue a nadie).

SELECT nickname, (SELECT count(*) FROM dar_like WHERE id_publicacion in (SELECT id_publicacion FROM publicacion WHERE publicacion.nickname=usuario.nickname) and dar_like.nickname in (SELECT seguidor FROM seguir WHERE seguir.seguido=usuario.nickname)) as num_likes FROM usuario; --T23. Para todos los usuarios, mostramos el número de likes en sus publicaciones, contando sólo los likes de sus seguidores.

SELECT nickname, (SELECT count(*) FROM publicacion WHERE publicacion.nickname=usuario.nickname and exists(SELECT * FROM historia WHERE historia.nickname=usuario.nickname and historia.fecha_publicacion BETWEEN publicacion.fecha_publicacion AND (publicacion.fecha_publicacion + INTERVAL '1 day'))) FROM usuario; --T24. Obtenemos el número de publicaciones de cada usuario en el que existe una historia de ese usuario publicada hasta 24 horas después de la publicación.

SELECT * FROM historia WHERE exists(SELECT * FROM dar_like WHERE dar_like.nickname=historia.nickname and dar_like.id_publicacion in (SELECT id_publicacion FROM publicacion WHERE publicacion.nickname in (SELECT nickname FROM moderador))); --T25. Seleccionamos todas las historias en las que existe al menos un registro de que el usuario de la historia le ha dado like a una publicación de un moderador.

SELECT * FROM chat WHERE chat.nickname1 in (SELECT nickname_usuario FROM bloquear WHERE fecha BETWEEN (CURRENT_TIMESTAMP - INTERVAL '1 week') AND CURRENT_TIMESTAMP) and chat.nickname1 in (SELECT nickname FROM publicacion)
UNION ALL
SELECT * FROM chat WHERE chat.nickname2 in (SELECT nickname_usuario FROM bloquear WHERE fecha BETWEEN (CURRENT_TIMESTAMP - INTERVAL '1 week') AND CURRENT_TIMESTAMP) and chat.nickname2 in (SELECT nickname FROM publicacion); -- T26. Seleccionamos los chats donde el usuario ha sido bloqueado entre una semana atrás y ahora, y tiene al menos una publicación. Esto lo hacemos cuando el usuario está en nickname 1, o en nickname2
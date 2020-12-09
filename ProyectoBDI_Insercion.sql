BEGIN;

INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('hugogs', 'mysecret', 'Hugo', 'Gómez', 'Sabucedo', 'hugo_gomez_sabucedo.jpg', 'Hola! Soy Hugo y soy un apasionado de las Bases de datos!');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('roquefi', 'contraseña1234', 'Roque', 'Fernández', 'Iglesias', 'roque_fernandez_iglesias.jpg', 'Buenas, soy Roque y me considero un gran informático. Algún día inventaré un sistema gestor de BBDD.');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('diegofp', 'micontraseñaoculta', 'Diego', 'Fernández', 'de Prada', 'diego_fernandez_de_prada.jpg', 'Mi nombre es Diego y digo que sí a cualquier base de datos que venga a mí.');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('aldancm', 'mipines1234', 'Aldán', 'Creo', 'Mariño', 'aldan_creo_marino.jpg', 'Hola! Soy Aldán y me hace feliz pensar en tuplas :)');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('ivandf', 'otracontraseña', 'Iván', 'Doce', 'Franco', 'ivan_doce_franco.jpg', 'Mi nombre es Iván y mi parte favorita de BDI es normalización.');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('carmentc', 'contraseñaoriginal', 'Carmen', 'Trigo', 'Cobas', 'carmen_trigo_cobas.jpg', 'Me llamo Carmen y la informática es mi pasión #BDIIsMyPassion.');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES('sarasc', 'nuevacontraseña', 'Sara', 'Soto', 'Carracedo', 'sara_soto_carracedo.jpg', 'Soy Sara y me encanta dar clase de Bases de Datos.');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('tanisga', 'mypassword1234', 'Tanis', 'Gemperle', 'Ares', 'tanis_gemperle_ares.jpg', 'Hola! Me llamo Tanis y mi sueño es trabajar gestionando bases de datos.');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('davidgd', '1234password', 'David', 'Gavilanes', 'de Dios', 'david_gavilanes_dedios.jpg', 'Mi nombre es David y lo que menos me gusta de BDI es SQL.'); 
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('elenafd', 'micontraseña', 'Elena', 'Fernández', 'del Sel', 'elena_fernandez_delsel.jpg', 'Hola! Me llamo Elena y adoro todo lo relacionado con las bases de datos!');

INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (0, '2020-12-09 14:56:25', 'diegofp');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (1, '2020-12-09 14:22:24', 'diegofp');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (0, '2020-12-05 15:30:39', 'roquefi');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (1, '2020-12-05 17:50:23', 'roquefi');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (2, '2020-12-05 18:55:12', 'roquefi');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (0, '2020-12-04 13:46:45', 'aldancm');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (1, '2020-12-05 12:20:23', 'aldancm');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (2, '2020-12-08 18:11:13', 'aldancm');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (0, '2020-12-08 15:47:57', 'hugogs');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (1, '2020-12-08 12:42:22', 'hugogs');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (2, '2020-12-09 15:00:54', 'hugogs');
INSERT INTO historia(id_historia, fecha_publicacion, nickname) VALUES (3, '2020-12-09 16:13:39', 'aldancm');

INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (0, 'roquefi', 'aldancm');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (0, 'roquefi', 'diegofp');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (0, 'roquefi', 'hugogs');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (2, 'aldancm', 'roquefi');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (2, 'aldancm', 'hugogs');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (1, 'diegofp', 'hugogs');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (1, 'aldancm', 'hugogs');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (1, 'diegofp', 'aldancm');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (1, 'diegofp', 'roquefi');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (0, 'aldancm', 'hugogs');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (0, 'aldancm', 'diegofp');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (0, 'aldancm', 'roquefi');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (2, 'roquefi', 'hugogs');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (2, 'roquefi', 'diegofp');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (1, 'roquefi', 'aldancm');
INSERT INTO ver_historia(id_historia, nickname_historia, nickname) VALUES (0, 'diegofp', 'roquefi');

INSERT INTO chat(fecha_creacion, nickname1, nickname2) VALUES ('2020-12-08 18:11:13', 'roquefi', 'hugogs');
INSERT INTO chat(fecha_creacion, nickname1, nickname2) VALUES ('2020-12-09 14:56:25', 'aldancm', 'hugogs');
INSERT INTO chat(fecha_creacion, nickname1, nickname2) VALUES ('2020-12-09 14:22:24', 'hugogs', 'diegofp');
INSERT INTO chat(fecha_creacion, nickname1, nickname2) VALUES ('2020-12-09 14:22:24', 'aldancm', 'diegofp');
INSERT INTO chat(fecha_creacion, nickname1, nickname2) VALUES ('2020-12-09 14:22:24', 'roquefi', 'diegofp');
INSERT INTO chat(fecha_creacion, nickname1, nickname2) VALUES ('2020-12-09 16:38:00', 'carmentc', 'elenafd');

INSERT INTO seguir(seguidor, seguido) VALUES ('hugogs', 'diegofp');
INSERT INTO seguir(seguidor, seguido) VALUES ('hugogs', 'aldancm');
INSERT INTO seguir(seguidor, seguido) VALUES ('hugogs', 'roquefi');
INSERT INTO seguir(seguidor, seguido) VALUES ('aldancm', 'roquefi');
INSERT INTO seguir(seguidor, seguido) VALUES ('aldancm', 'hugogs');
INSERT INTO seguir(seguidor, seguido) VALUES ('aldancm', 'diegofp');
INSERT INTO seguir(seguidor, seguido) VALUES ('diegofp', 'roquefi');
INSERT INTO seguir(seguidor, seguido) VALUES ('diegofp', 'hugogs');
INSERT INTO seguir(seguidor, seguido) VALUES ('diegofp', 'aldancm');
INSERT INTO seguir(seguidor, seguido) VALUES ('roquefi', 'aldancm');
INSERT INTO seguir(seguidor, seguido) VALUES ('roquefi', 'hugogs');
INSERT INTO seguir(seguidor, seguido) VALUES ('roquefi', 'diegofp');
INSERT INTO seguir(seguidor, seguido) VALUES ('roquefi', 'ivandf');
INSERT INTO seguir(seguidor, seguido) VALUES ('carmentc', 'elenafd');
INSERT INTO seguir(seguidor, seguido) VALUES ('elenafd', 'carmentc');
INSERT INTO seguir(seguidor, seguido) VALUES ('elenafd', 'aldancm');

INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (0, 'Una puesta de sol resplandeciente', '2020-12-09 14:56:25', 'hugogs');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (1, 'Mi gato comiendo pienso para gatos', '2020-12-09 14:22:24', 'hugogs');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (2, 'Yo jugando al RiskETSE', '2020-12-09 14:50:25', 'aldancm');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (3, 'Mi ordenador echando humo', '2020-12-09 14:56:25', 'roquefi');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (4, 'He hecho 10000 consultas a mi BD y esto ha pasado...', '2020-12-09 14:57:25', 'roquefi');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (5, 'Aquí, haciendo el proyecto de BDI', '2020-09-13 14:57:25', 'diegofp');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (6, 'Consejo: no dejes todo para última hora', '2020-12-09 23:59:59', 'carmentc');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (7, 'Os hace unas partidas al AmongETSE?', '2020-12-08 16:49:12', 'elenafd');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (8, 'He hecho galletas de Navidad.', '2020-12-09 15:34:44', 'ivandf');

INSERT INTO dar_like(id_publicacion, nickname) VALUES (0, 'aldancm');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (0, 'roquefi');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (0, 'diegofp');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (1, 'diegofp');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (1, 'roquefi');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (2, 'roquefi');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (2, 'diegofp');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (2, 'hugogs');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (3, 'aldancm');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (3, 'diegofp');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (4, 'hugogs');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (4, 'elenafd');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (5, 'aldancm');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (6, 'sarasc');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (7, 'hugogs');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (7, 'sarasc');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (7, 'diegofp');
INSERT INTO dar_like(id_publicacion, nickname) VALUES (8, 'roquefi');

INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (0, 'aldancm');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (0, 'roquefi');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (0, 'diegofp');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (1, 'diegofp');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (1, 'roquefi');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (2, 'roquefi');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (2, 'diegofp');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (2, 'hugogs');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (3, 'aldancm');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (3, 'diegofp');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (4, 'hugogs');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (4, 'elenafd');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (5, 'aldancm');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (6, 'sarasc');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (7, 'hugogs');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (7, 'aldancm');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (7, 'davidgd');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (7, 'roquefi');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (7, 'sarasc');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (7, 'diegofp');
INSERT INTO ver_publicacion(id_publicacion, nickname) VALUES (8, 'roquefi');

INSERT INTO comentar(fecha, texto, id_publicacion, nickname) VALUES('2020-12-08 17:01:15', 'Claro! A quien no le va a gustar un AmongETSE?', '7', 'hugogs');
INSERT INTO comentar(fecha, texto, id_publicacion, nickname) VALUES('2020-12-09 19:59:36', 'El mío ha petado trabajando en el RiskETSE. Enfin la hipocresía.', '3', 'aldancm');
INSERT INTO comentar(fecha, texto, id_publicacion, nickname) VALUES('2020-12-09 22:36:45', 'Seguro que están muy ricas!', '8', 'roquefi');
INSERT INTO comentar(fecha, texto, id_publicacion, nickname) VALUES('2020-11-29 22:18:20', 'I feel u sis!', '5', 'aldancm');
INSERT INTO comentar(fecha, texto, id_publicacion, nickname) VALUES('2020-12-09 20:20:40', 'Me has dejado con la intriga...', '4', 'elenafd');

INSERT INTO moderador(nickname) VALUES ('aldancm');
INSERT INTO moderador(nickname) VALUES ('hugogs');
INSERT INTO moderador(nickname) VALUES ('roquefi');
INSERT INTO moderador(nickname) VALUES ('carmentc');
INSERT INTO moderador(nickname) VALUES ('elenafd');

INSERT INTO bloquear(fecha, fecha_fin, motivo, nickname_usuario, nickname_moderador) VALUES ('2020-12-04 16:15:14', '2020-12-06 12:30:49', 'Contenido inapropiado.', 'davidgd', 'aldancm');
INSERT INTO bloquear(fecha, fecha_fin, motivo, nickname_usuario, nickname_moderador) VALUES ('2020-12-06 13:16:20', '2020-12-07 08:58:16', 'Spam de RiskETSE.', 'davidgd', 'hugogs');
INSERT INTO bloquear(fecha, fecha_fin, motivo, nickname_usuario, nickname_moderador) VALUES ('2020-12-03 23:14:56', '2020-12-09 14:25:12', 'Trato ofensivo a otros usuarios.', 'sarasc', 'roquefi');
INSERT INTO bloquear(fecha, fecha_fin, motivo, nickname_usuario, nickname_moderador) VALUES ('2020-12-07 11:26:26', '2020-12-07 21:54:23', 'Discurso de odio.', 'tanisga', 'elenafd');
INSERT INTO bloquear(fecha, fecha_fin, motivo, nickname_usuario, nickname_moderador) VALUES ('2020-12-05 16:45:13', '2020-12-09 19:30:23', 'Contenido inapropiado.', 'ivandf', 'aldancm');
INSERT INTO bloquear(fecha, fecha_fin, motivo, nickname_usuario, nickname_moderador) VALUES ('2020-12-08 09:46:09', '2020-12-09 15:19:45', 'Spam.', 'diegofp', 'roquefi');

COMMIT;





DELETE FROM usuario; --Borra todos los datos porque todas las tablas dependen de esta, y tenemos borrado en cascada

SELECT * FROM usuario; --Para ver los datos de las tablas
SELECT * FROM historia;
SELECT * FROM ver_historia;
SELECT * FROM chat;
SELECT * FROM seguir;
SELECT * FROM publicacion;
SELECT * FROM dar_like;
SELECT * FROM ver_publicacion;
SELECT * FROM comentar;
SELECT * FROM moderador;
SELECT * FROM bloquear;
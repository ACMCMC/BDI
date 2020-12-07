BEGIN;

INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('hugogs', 'mysecret', 'Hugo', 'Gómez', 'Sabucedo', 'hugo_gomez_sabucedo.jpg', 'Hola! Soy Hugo y soy un apasionado de las Bases de datos!');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('roquefi', 'contraseña1234', 'Roque', 'Fernández', 'Iglesias', 'roque_fernandez_iglesias.jpg', 'Buenas, soy Roque y me considero un gran informático. Algún día inventaré un sistema gestor de BBDD.');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('diegofp', 'micontraseñaoculta', 'Diego', 'Fernández', 'de Prada', 'diego_fernandez_de_prada.jpg', 'Mi nombre es Diego y digo que sí a cualquier base de datos que venga a mí.');
INSERT INTO usuario(nickname, contrasena, nombre, apellido1, apellido2, foto_perfil, biografia) VALUES ('aldancm', 'mipines1234', 'Aldán', 'Creo', 'Mariño', 'aldan_creo_marino.jpg', 'Hola! Soy Aldán y me hace feliz pensar en tuplas :)');

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

INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (0, 'Una puesta de sol resplandeciente', '2020-12-09 14:56:25', 'hugogs');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (1, 'Mi gato comiendo pienso para gatos', '2020-12-09 14:22:24', 'hugogs');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (2, 'Yo jugando al RiskETSE', '2020-12-09 14:56:25', 'aldancm');
INSERT INTO publicacion(id_publicacion, descripcion, fecha_publicacion, nickname) VALUES (3, 'Mi ordenador echando humo', '2020-12-09 14:56:25', 'roquefi');

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
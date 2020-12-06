CREATE TABLE usuario(nickname VARCHAR(30), contrasena VARCHAR(30), nombre VARCHAR(30), apellido1 VARCHAR(30), apellido2 VARCHAR(30), foto_perfil VARCHAR(60), biografia VARCHAR(140), PRIMARY KEY(nickname));

CREATE TABLE historia(id_historia INTEGER, fecha_publicacion TIMESTAMP, nickname VARCHAR(30), FOREIGN KEY(nickname) REFERENCES usuario(nickname), PRIMARY KEY(nickname, id_historia));

CREATE TABLE ver_historia(id_historia INTEGER, nickname_historia VARCHAR(30), nickname VARCHAR(30), FOREIGN KEY (id_historia, nickname_historia) REFERENCES historia(id_historia, nickname), FOREIGN KEY (nickname) REFERENCES usuario(nickname), PRIMARY KEY (id_historia, nickname));

CREATE TABLE chat(fecha_creacion TIMESTAMP, nickname1 VARCHAR(30), nickname2 VARCHAR(30), FOREIGN KEY(nickname1) REFERENCES usuario(nickname), FOREIGN KEY (nickname2) REFERENCES usuario(nickname), PRIMARY KEY (nickname1, nickname2));

CREATE TABLE seguir(seguidor VARCHAR(30), seguido VARCHAR(30), FOREIGN KEY (seguidor) REFERENCES usuario(nickname), FOREIGN KEY (seguidor) REFERENCES usuario(nickname), PRIMARY KEY (seguidor, seguido));

CREATE TABLE publicacion(id_publicacion INTEGER, descripcion VARCHAR(240), fecha_publicacion TIMESTAMP, nickname VARCHAR(30), FOREIGN KEY (nickname) REFERENCES usuario(nickname), PRIMARY KEY (id_publicacion));

CREATE TABLE dar_like(id_publicacion INTEGER, nickname VARCHAR(30), FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion), FOREIGN KEY (nickname) REFERENCES usuario(nickname));

CREATE TABLE ver_publicacion(id_publicacion INTEGER, nickname VARCHAR(30), FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion), FOREIGN KEY (nickname) REFERENCES usuario(nickname), PRIMARY KEY (id_publicacion, nickname));

CREATE TABLE comentar(fecha TIMESTAMP, texto VARCHAR(240), id_publicacion INTEGER, nickname VARCHAR(30), FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion), FOREIGN KEY (nickname) REFERENCES usuario(nickname), PRIMARY KEY (fecha, id_publicacion, nickname));

CREATE TABLE moderador(nickname VARCHAR(30), FOREIGN KEY (nickname) REFERENCES usuario(nickname), PRIMARY KEY (nickname));

CREATE TABLE bloquear(fecha TIMESTAMP, fecha_fin TIMESTAMP, motivo VARCHAR(240), nickname_usuario VARCHAR(30), nickname_moderador VARCHAR(30), FOREIGN KEY (nickname_usuario) REFERENCES usuario(nickname), FOREIGN KEY (nickname_moderador) REFERENCES moderador(nickname), PRIMARY KEY (fecha, nickname_usuario, nickname_moderador));

SELECT * FROM usuario;
SELECT * FROM historia;
SELECT * FROM ver_historia;
SELECT * FROM chat;
SELECT * FROM seguir;
SELECT * FROM publicacion;
SELECT * FROM dar_like;
SELECT * FROM ver_publicacion;
SELECT * FROM comentar;
SELECT * FROM moderador;

DROP TABLE usuario CASCADE;
DROP TABLE historia CASCADE;
DROP TABLE ver_historia CASCADE;
DROP TABLE chat CASCADE;
DROP TABLE seguir CASCADE;
DROP TABLE publicacion CASCADE;
DROP TABLE dar_like CASCADE;
DROP TABLE ver_publicacion CASCADE;
DROP TABLE comentar CASCADE;
DROP TABLE moderador CASCADE;
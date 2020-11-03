--Aldán Creo Mariño - BDI 2020/21

CREATE TABLE Participantes(numeroAsociado INTEGER, nombre VARCHAR(30), direccion VARCHAR(60), telefono NUMERIC(9,0), PRIMARY KEY (numeroAsociado));

CREATE TABLE Jugadores(numeroAsociado INTEGER, nivelJuego INTEGER, PRIMARY KEY (numeroAsociado), FOREIGN KEY (numeroAsociado) REFERENCES Participantes(numeroAsociado));

CREATE TABLE Arbitros(numeroAsociado INTEGER, PRIMARY KEY (numeroAsociado), FOREIGN KEY (numeroAsociado) REFERENCES Participantes(numeroAsociado));

CREATE TABLE Hoteles(nombre VARCHAR(15), direccion VARCHAR(60), telefono NUMERIC(9,0), PRIMARY KEY (nombre));

CREATE TABLE Salas(hotel VARCHAR(15), nombre VARCHAR(15), capacidad SMALLINT, PRIMARY KEY (hotel, nombre), FOREIGN KEY (hotel) REFERENCES Hoteles(nombre));

CREATE TABLE Partidas(codigoPartida INTEGER, fecha DATE, arbitro INTEGER, jugadorBlancas INTEGER, jugadorNegras INTEGER, salasHotel VARCHAR(15), salasNombre VARCHAR(15), entradasVendidas INTEGER, PRIMARY KEY (codigoPartida), FOREIGN KEY (arbitro) REFERENCES Arbitros(numeroAsociado), FOREIGN KEY (jugadorBlancas) REFERENCES Jugadores(numeroAsociado), FOREIGN KEY (jugadorNegras) REFERENCES Jugadores(numeroAsociado), FOREIGN KEY (salasHotel, salasNombre) REFERENCES Salas(hotel, nombre));
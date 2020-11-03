CREATE TABLE Medicos(numeroColegiado NUMERIC(5,0), nombrePropio VARCHAR(15), nombreAp1 VARCHAR(15), nombreAp2 VARCHAR(15), especialidad VARCHAR(15), anoEspecializacion DATE, PRIMARY KEY (numeroColegiado));

CREATE TABLE Pacientes(dni CHAR(9), nombrePropio VARCHAR(15), nombreAp1 VARCHAR(15), nombreAp2 VARCHAR(15), direccion VARCHAR(30), fechaNacimiento DATE, numeroColegiado NUMERIC(5,0), PRIMARY KEY(dni), FOREIGN KEY (numeroColegiado) REFERENCES Medicos(numeroColegiado));

CREATE TABLE EmpresaFarmaceutica(nombre VARCHAR(30), numeroTelefono NUMERIC(9,0), personaContacto VARCHAR(15), PRIMARY KEY (nombre));

CREATE TABLE Medicamento(nombre VARCHAR(30), nombreComercial VARCHAR(30), formula VARCHAR(30), cantidad SMALLINT, PRIMARY KEY (nombre, nombreComercial), FOREIGN KEY (nombre) REFERENCES EmpresaFarmaceutica(nombre));

CREATE TABLE Recetar(numeroColegiado NUMERIC(5,0), dni CHAR(9), nombreComercial VARCHAR(30), nombre VARCHAR(30), fecha DATE, cantidad SMALLINT, PRIMARY KEY (numeroColegiado, dni, nombreComercial, nombre, fecha), FOREIGN KEY (numeroColegiado) REFERENCES Medicos(numeroColegiado), FOREIGN KEY (dni) REFERENCES Pacientes(dni), FOREIGN KEY (nombreComercial, nombre) REFERENCES Medicamento(nombreComercial, nombre));
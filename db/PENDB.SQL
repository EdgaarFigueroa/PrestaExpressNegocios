DROP DATABASE IF EXISTS PEN;
CREATE DATABASE PEN;
USE PEN;
CREATE TABLE TipoUsuario(
	id_tus int PRIMARY KEY,
	nom_tus varchar(45) NOT NULL
);
INSERT INTO TipoUsuario VALUES
(1,'Cliente'),
(2,'Asesor'),
(3,'Gerente');

CREATE TABLE MontoPrestamo(
	id_mon int PRIMARY KEY AUTO_INCREMENT,
	mon_mon int NOT NULL
);
INSERT INTO MontoPrestamo (mon_mon) VALUES
	('1000'),
	('2000'),
	('3000'),
	('4000'),
	('5000'),
	('6000'),
	('7000'),
	('8000'),
	('9000'),
	('10000');
CREATE TABLE Usuario(
	id_usu int PRIMARY KEY AUTO_INCREMENT,
	id_tus int NOT NULL,
	nom_usu varchar(45) NOT NULL,
	pass_usu varchar(45) NOT NULL,
	FOREIGN KEY(id_tus)REFERENCES TipoUsuario(id_tus)
);

CREATE TABLE Zona(
	id_zon int PRIMARY KEY,
	nom_zon varchar(45) NOT NULL
);
CREATE TABLE Asesor(
	id_ase int PRIMARY KEY AUTO_INCREMENT,
	nom_ase varchar(45) NOT NULL,
	ema_ase varchar(45) NOT NULL,
	pass_ase varchar(45) NOT NULL,
	tel_ase int NOT NULL,
	id_zon int NOT NULL,
	FOREIGN KEY(id_zon)REFERENCES Zona(id_zon)
);
CREATE TABLE Cliente(
	id_cli int PRIMARY KEY AUTO_INCREMENT,
	id_ase int NOT NULL,
	nom_cli varchar(45) NOT NULL,
	ema_cli varchar(45) NOT NULL,
	pass_cli varchar(45) NOT NULL,
	din_cli varchar(120) NOT NULL,
	dih_cli varchar(120) NOT NULL,
	tel_cli int NOT NULL,
	FOREIGN KEY (id_ase)REFERENCES Asesor(id_ase)
);
CREATE TABLE Gerente(
	id_ger int PRIMARY KEY AUTO_INCREMENT,
	nom_ger varchar(45) NOT NULL,
	pass_ger varchar(45) NOT NULL,
	tel_ger int NOT NULL,
	ema_ger varchar(45) NOT NULL 
);
CREATE TABLE Prestamo(
	id_pre int PRIMARY KEY AUTO_INCREMENT,
	fec_ini DATE NOT NULL,
	fec_fin DATE NOT NULL,
	id_mon int NOT NULL,
	id_cli int NOT NULL,
	FOREIGN KEY(id_mon)REFERENCES MontoPrestamo(id_mon),
	FOREIGN key(id_cli)REFERENCES Cliente(id_cli)	
);

CREATE TABLE HistorialPagosContinuos(
	id_pag int PRIMARY KEY AUTO_INCREMENT,
	id_pre int NOT NULL,
	fec_pag DATE NOT NULL,
	mon_pag int NOT NULL,
	com_pag VARCHAR(200) DEFAULT NULL,
	FOREIGN KEY(id_pre)REFERENCES Prestamo(id_pre)
);

CREATE TABLE Jerarquia(
	id_jer int PRIMARY KEY AUTO_INCREMENT,
	id_ger int NOT NULL,
	id_ase int NOT NULL,
	FOREIGN KEY(id_ger)REFERENCES Gerente(id_ger),
	FOREIGN KEY(id_ase)REFERENCES Asesor(id_ase)
);










/*
esta funcion talves se cancela 
CREATE FUNCTION getAsesorRoute(route VARCHAR(50)) RETURNS INT
    BEGIN
        RETURN(SELECT id_zon FROM Zona WHERE nom_zon like route% LIMIT 1)
    END$$
*/


INSERT INTO zona VALUES
	('45','PALMAS');

INSERT INTO asesor (nom_ase,ema_ase,pass_ase,tel_ase,id_zon) VALUES 
    ('MARIO','mario@gmail.com','contraseña','55667','45');

INSERT INTO cliente (id_ase,nom_cli,ema_cli,pass_cli,din_cli,dih_cli,tel_cli) VALUES
  	('1','MARIO','mario@gmail.com','contraseña','Las flores','las flores reyes','55555');

INSERT INTO Prestamo (id_tpp,fec_ini,id_mon) VALUES
	(1,'2017-09-08',1),
	(2,'2017-09-08',1),
	(2,'2017-09-08',1),
	(1,'2017-09-08',1);

INSERT INTO HistorialPagosContinuos(id_pre,fec_pag,mon_pag,com_pag)VALUES
	(2,'2017-09-08',135,"me pago a tiempo"),
	(3,'2017-09-08',146,"me pago a tiempo"),
	(4,'2017-09-08',150,"me pago a tiempo");

SELECT MontoPrestamo.mon_mon,Cliente.nom_cli,Prestamo.fec_ini FROM MontoPrestamo INNER JOIN Prestamo ON MontoPrestamo.id_mon = Prestamo.id_mon INNER JOIN Cliente on Prestamo.id_cli = Cliente.id_cli where Cliente.id_cli = 1; 
SELECT Cliente.nom_cli as "nombre", MontoPrestamo.mon_mon, HistorialPagosContinuos.mon_pag, HistorialPagosContinuos.fec_pag,Prestamo.fec_ini FROM MontoPrestamo INNER JOIN Prestamo ON MontoPrestamo.id_mon = Prestamo.id_mon INNER JOIN Cliente ON Cliente.id_cli = Prestamo.id_cli INNER JOIN HistorialPagosContinuos ON Prestamo.id_pre = HistorialPagosContinuos.id_pre where Cliente.id_cli = 1;

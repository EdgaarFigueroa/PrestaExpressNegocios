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

INSERT INTO Prestamo (fec_ini,fec_fin,id_mon,id_cli) VALUES
	(LOCALTIMESTAMP(),'2017-09-08',1,1),
	('2017-09-08','2018-10-22',2,1),
	('2017-09-08','2017-09-08',2,1),
	('2017-09-08','2017-09-08',3,1);

INSERT INTO HistorialPagosContinuos(id_pre,fec_pag,mon_pag,com_pag)VALUES
	(2,'2017-09-08',135,"me pago a tiempo"),
	(3,'2017-09-08',146,"me pago a tiempo"),
	(4,'2017-09-08',150,"me pago a tiempo");

SELECT MontoPrestamo.mon_mon,Cliente.nom_cli,Prestamo.fec_ini FROM MontoPrestamo INNER JOIN Prestamo ON MontoPrestamo.id_mon = Prestamo.id_mon INNER JOIN Cliente on Prestamo.id_cli = Cliente.id_cli where Cliente.id_cli = 1; 
SELECT Cliente.nom_cli as "nombre", MontoPrestamo.mon_mon, HistorialPagosContinuos.mon_pag, HistorialPagosContinuos.fec_pag,Prestamo.fec_ini FROM MontoPrestamo INNER JOIN Prestamo ON MontoPrestamo.id_mon = Prestamo.id_mon INNER JOIN Cliente ON Cliente.id_cli = Prestamo.id_cli INNER JOIN HistorialPagosContinuos ON Prestamo.id_pre = HistorialPagosContinuos.id_pre where Cliente.id_cli = 1;

SELECT Cliente.nom_cli AS "Cliente", asesor.nom_ase AS "Asesor", MontoPrestamo.mon_mon AS "Monto Prestado", HistorialPagosContinuos.mon_pag AS "Pagos", HistorialPagosContinuos.fec_pag AS "Fecha del pago", Prestamo.fec_ini AS "Fecha del Prestamo" 
        FROM MontoPrestamo INNER JOIN Prestamo ON MontoPrestamo.id_mon = Prestamo.id_mon INNER JOIN HistorialPagosContinuos ON HistorialPagosContinuos.id_pre = Prestamo.id_pre INNER JOIN Cliente ON Prestamo.id_cli = Cliente.id_cli INNER JOIN Asesor ON Cliente.id_ase = Asesor.id_ase  
        

SELECT HistorialPagosContinuos.fec_pag, HistorialPagosContinuos.mon_pag


CREATE PROCEDURE getPrestamosUsuario(IN id_cli INT)
    BEGIN
       DROP TEMPORARY TABLE IF EXISTS Tempprestamoincliente;
       CREATE TEMPORARY TABLE Tempprestamoincliente AS (SELECT id_pre FROM PrestamoenCliente WHERE id_cli = id);
    END$$
CREATE PROCEDURE getHistorialpago(IN id_cli int)
    BEGIN
        CALL getPrestamosUsuario(id_cli);
        SELECT Cliente.nom_cli AS "Cliente",asesor.nom_ase AS "Asesor", MontoPrestamo.mon_mon AS "Monto Prestado", HistorialPagosContinuos.mon_pag AS "Pagos", HistorialPagosContinuos.fec_pag AS "Fecha del pago", Prestamo.fec_ini AS "Fecha del Prestamo" 
        FROM MontoPrestamo INNER JOIN Prestamo ON MontoPrestamo.id_mon = Prestamo.id_mon INNER JOIN PrestamoenCliente ON Prestamo.id_pre = PrestamoenCliente.id_pre INNER JOIN Cliente ON Cliente.id_cli = PrestamoenCliente.id_cli INNER JOIN 
        ASESOR ON Asesor.id_ase = Cliente.id_ase INNER JOIN HistorialPagosContinuos ON Prestamo.id_pre = HistorialPagosContinuos.id_pre where Prestamo.id_pre IN(SELECT * FROM Tempprestamoincliente);
    END$$
 SELECT DATEDIFF((SELECT fec_fin FROM prestamo where id_pre = 5), CURDATE());
 SELECT(MontoPrestamo.mon_mon-SUM(HistorialPagosContinuos.mon_pag)) FROM MontoPrestamo INNER JOIN Prestamo ON MontoPrestamo.id_mon = Prestamo.id_mon INNER JOIN HistorialPagosContinuos ON Prestamo.id_pre = HistorialPagosContinuos.id_pre WHERE Prestamo.id_pre = 1; 

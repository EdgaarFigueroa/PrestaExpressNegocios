USE pen;
DELIMITER $$

DROP FUNCTION IF EXISTS getNombreCliente$$
DROP FUNCTION IF EXISTS getNombreAsesor$$
DROP FUNCTION IF EXISTS getClientePassword$$
DROP FUNCTION IF EXISTS getAsesorRoute$$

DROP PROCEDURE IF EXISTS registrarCliente$$
DROP PROCEDURE IF EXISTS registrarAsesor$$
DROP PROCEDURE IF EXISTS registrarGerente$$
DROP PROCEDURE IF EXISTS ModificarCliente$$
DROP PROCEDURE IF EXISTS ConsultarAsesor$$

DROP PROCEDURE IF EXISTS getPrestamosUsuario$$
DROP PROCEDURE IF EXISTS getHistorialpago$$
DROP TRIGGER IF EXISTS cliente_AI;
DROP TRIGGER IF EXISTS asesor_AI;
DROP TRIGGER IF EXISTS gerente_AI;

CREATE FUNCTION getNombreCliente(id_cliente MEDIUMINT) RETURNS VARCHAR(45)
    BEGIN
        RETURN(SELECT nom_cli FROM Cliente WHERE id_cli = id_cliente);
    END$$
CREATE FUNCTION getNombreAsesor(id_asesor MEDIUMINT) RETURNS VARCHAR(45)
    BEGIN
        RETURN(SELECT nom_ase FROM Asesor WHERE id_ase = id_asesor);
    END$$

CREATE FUNCTION getClientePassword(id_cliente MEDIUMINT) RETURNS VARCHAR(500)
    BEGIN
        RETURN(SELECT pass_cli FROM Cliente WHERE id_cli = id_cliente);
    END$$

CREATE PROCEDURE registrarCliente(IN nombre VARCHAR(45), IN email VARCHAR(45), IN password VARCHAR(45), IN dir_neg VARCHAR(120), IN dir_casa VARCHAR(120),IN telefono int)
    BEGIN
        INSERT INTO cliente(nom_cli,ema_cli,pass_cli,din_cli,dih_cli,tel_cli) VALUES
        (nombre,email,password,dir_neg,dir_casa,telefono);  
    END$$

CREATE PROCEDURE registrarAsesor(IN nombre VARCHAR(45), IN email VARCHAR(45), IN password VARCHAR(45), IN telefono int , IN zona Varchar(120))
    BEGIN 
        INSERT INTO asesor(nom_ase,ema_ase,pass_ase,tel_ase,id_zon)VALUES
        (nombre,email,password,telefono,zone);
    END$$
CREATE PROCEDURE registrarGerente(IN nombre VARCHAR(45), IN email VARCHAR(45), IN password VARCHAR(45), IN telefono int)
    BEGIN
        INSERT INTO asesor(nom_ger,ema_ger,pass_ger,tel_ger)VALUES
        (nombre,email,password,telefono);
    END$$

CREATE PROCEDURE ModificarCliente(IN id_cliente INT, IN newpassword VARCHAR(500))
    BEGIN
        UPDATE ModificarCliente SET pass_cli = newpassword WHERE id_cli = id_cliente;
    END$$
CREATE PROCEDURE ConsultarAsesor(IN id_asesor INT)
    BEGIN
        Select asesor.nom_ase AS 'Nombre', asesor.ema_ase AS 'Email', asesor.tel_ase AS 'Telefono', Zona.nom_zon AS 'Zona' FROM  asesor INNER JOIN Zona ON asesor.id_zon = Zona.id_zon WHERE id_ase = id_asesor;
    END$$
CREATE PROCEDURE getPrestamosUsuario(IN id_cli INT)
    BEGIN
       DROP TEMPORARY TABLE IF EXISTS Tempprestamoincliente;
       CREATE TEMPORARY TABLE Tempprestamoincliente AS (SELECT id_pre FROM PrestamoenCliente WHERE id_cli = id);
    END$$
CREATE PROCEDURE getHistorialpago(IN id_cli int)
    BEGIN
        CALL getPrestamosUsuario(id_cli);
        SELECT Cliente.nom_cli AS "Cliente",asesor.nom_ase AS "Asesor", MontoPrestamo.mon_mon"Monto Prestado", HistorialPagosContinuos.mon_pag AS "Pagos", HistorialPagosContinuos.fec_pag AS "Fecha del pago", Prestamo.fec_ini AS "Fecha del Prestamo" 
        FROM MontoPrestamo INNER JOIN Prestamo ON MontoPrestamo.id_mon = Prestamo.id_mon INNER JOIN Cliente ON Cliente.id_cli = Prestamo.id_cli INNER JOIN 
        ASESOR ON Asesor.id_ase = Cliente.id_cli INNER JOIN HistorialPagosContinuos ON Prestamo.id_pre = HistorialPagosContinuos.id_pre where Prestamo.id_pre IN(SELECT * FROM Tempprestamoincliente);
    END$$
CREATE PROCEDURE addPrestamo(IN id_cliente INT, IN id_prestamo INT)
    BEGIN
        INSERT INTO PrestamoenCliente(id_cli,id_pre) VALUES(id_cliente,id_prestamo);
    END$$

CREATE TRIGGER cliente_AI AFTER INSERT ON cliente FOR EACH ROW 
INSERT INTO usuario(id_tus,nom_usu,pass_usu)VALUES('1',NEW.nom_cli,NEW.pass_cli);

CREATE TRIGGER asesor_AI AFTER INSERT ON asesor FOR EACH ROW 
INSERT INTO usuario(id_tus,nom_usu,pass_usu)VALUES('2',NEW.nom_ase,NEW.pass_ase);

CREATE TRIGGER gerente_AI AFTER INSERT ON cliente FOR EACH ROW 
INSERT INTO usuario(id_tus,nom_usu,pass_usu)VALUES('1',NEW.nom_ger,NEW.pass_ger);
DELIMITER ;





--Garantindo que seja um banco restaurado do zero, sem nenhuma alteração
USE master
GO
RESTORE DATABASE StackOverflow2010
FROM disk = 'E:\ToBeRestored\StackOverflow2010.bak'
WITH STATS
,MOVE 'StackOverflow2010' TO 'D:\MSSQL\Data\StackOverflow2010.mdf'
,MOVE 'StackOverflow2010_log' TO 'D:\MSSQL\Log\StackOverflow2010_log.ldf'
,REPLACE
GO
 
--Alterando a durabilidade das transações para que os inserts sejam mais rápidos.
ALTER DATABASE StackOverflow2010 SET DELAYED_DURABILITY = FORCED
GO
 
USE StackOverflow2010
GO
-- Criação de uma tabela para exemplos de crescimento da base de dados
DROP TABLE IF EXISTS dbo.TesteBackup
CREATE TABLE dbo.TesteBackup
(
 id INT IDENTITY
 ,valor CHAR(8000) NOT NULL DEFAULT REPLICATE('A',8000)
)
GO
 
/******************* SEGUNDA FEIRA *******************/ 
 
--Backup Full Segunda-Feira (Propositalmente, não foi utilizado o Backup Compression)
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_FULL_Segunda.bak' WITH STATS
GO
 
--Inserção de 20000 registros para simular carga de dados
INSERT INTO dbo.TesteBackup DEFAULT VALUES
GO 20000
 
EXEC sys.sp_spaceused TesteBackup
--name rows	reserved	data index_size	unused
--TesteBackup	20000   160072 KB	160000 KB	8 KB 64 KB
 
--Backup do tipo Differential de Segunda Feira
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_DIFF_Segunda.bak' WITH DIFFERENTIAL, STATS
GO
 
 
/******************* TERÇA FEIRA *******************/ 
--Backup Full Terça-Feira 
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_FULL_Terca.bak' WITH STATS
GO
 
--Inserção de 20000 registros para simular carga de dados
INSERT INTO dbo.TesteBackup DEFAULT VALUES
GO 20000
 
EXEC sys.sp_spaceused TesteBackup
--name rows	reserved	data index_size	unused
--TesteBackup	40000   320200 KB	320000 KB	8 KB 192 KB
 
--Backup do tipo Differential de Terça-Feira
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_DIFF_Terca.bak' WITH DIFFERENTIAL, STATS
GO
 
/******************* QUARTA FEIRA *******************/
--Backup Full Quarta-Feira (Propositalmente, não foi utilizado o Backup Compression)
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_FULL_Quarta.bak' WITH STATS
GO
--Inserção de 20000 registros para simular carga de dados
INSERT INTO dbo.TesteBackup DEFAULT VALUES
GO 20000
 
EXEC sys.sp_spaceused TesteBackup
--name rows	reserved	data index_size	unused
--TesteBackup	60000   480264 KB	480000 KB	8 KB 256 KB
 
 
--Backup do tipo Differential de Quarta-Feira
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_DIFF_Quarta.bak' WITH DIFFERENTIAL, STATS
GO
 
/******************* QUINTA FEIRA *******************/
--Backup Full Quinta-Feira (Propositalmente, não foi utilizado o Backup Compression)
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_FULL_Quinta.bak' WITH STATS
GO
--Inserção de 20000 registros para simular carga de dados
INSERT INTO dbo.TesteBackup DEFAULT VALUES
GO 20000
 
EXEC sys.sp_spaceused TesteBackup
--name rows	reserved	data index_size	unused
--TesteBackup	80000	640264 KB	640000 KB	8 KB 256 KB
 
 
--Backup do tipo Differential de Quinta-Feira
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_DIFF_Quinta.bak' WITH DIFFERENTIAL, STATS
GO
 
/******************* SEXTA FEIRA *******************/
--Backup Full Sexta-Feira (Propositalmente, não foi utilizado o Backup Compression)
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_FULL_Sexta.bak' WITH STATS
GO
--Inserção de 20000 registros para simular carga de dados
INSERT INTO dbo.TesteBackup DEFAULT VALUES
GO 20000
 
EXEC sys.sp_spaceused TesteBackup
--name rows	reserved	data index_size	unused
--TesteBackup	100000  800328 KB	800000 KB	8 KB 320 KB
 
 
--Backup do tipo Differential de Sexta-Feira
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_DIFF_Sexta.bak' WITH DIFFERENTIAL, STATS
GO
 
/******************* SÁBADO *******************/
--Backup Full Sábado (Propositalmente, não foi utilizado o Backup Compression)
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_FULL_Sabado.bak' WITH STATS
GO
--Inserção de 20000 registros para simular carga de dados
INSERT INTO dbo.TesteBackup DEFAULT VALUES
GO 20000
 
EXEC sys.sp_spaceused TesteBackup
--name rows	reserved	data index_size	unused
--TesteBackup	120000  960328 KB	960000 KB	8 KB 320 KB
 
--Backup do tipo Differential de Sabado
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_DIFF_Sabado.bak' WITH DIFFERENTIAL, STATS
GO
 
/******************* DOMINGO *******************/
--Backup Full Domingo (Propositalmente, não foi utilizado o Backup Compression)
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_FULL_Domingo.bak' WITH STATS
GO
--Inserção de 20000 registros para simular carga de dados
INSERT INTO dbo.TesteBackup DEFAULT VALUES
GO 20000
 
EXEC sys.sp_spaceused TesteBackup
--name rows	reserved	data index_size	unused
--TesteBackup	140000	1120328 KB	1120000 KB	8 KB 320 KB
 
--Backup do tipo Differential de Domingo
BACKUP DATABASE StackOverflow2010 TO DISK = 'E:\Backup\StackOverflow2010_DIFF_Domingo.bak' WITH DIFFERENTIAL, STATS
GO
USE ticket;
--Для одной из таблиц своей базы данных создать
--1.	Триггер журнала аудита
--GO
--drop table if exists audit_airports;
--CREATE TABLE audit_airports (
--recId INT PRIMARY KEY identity, 
--recdate DATETIME, 
--airportId_old INT, 
--airportId_new INT NULL,
--airport_old varchar(50),
--airport_new varchar(50) null
--);

--drop trigger if exists modify_airports;
--go
--create TRIGGER modify_airports  ON airport AFTER UPDATE, DELETE
--AS
--BEGIN
--DECLARE @airportId_old INT, @airportId_new INT
--DECLARE @airport_old varchar(50), @airport_new varchar(50)
--SET @airportId_old = (SELECT airportId FROM deleted)
--SET @airportId_new = (SELECT airportId FROM inserted) 
--SET @airport_old = (SELECT airport FROM deleted) 
--SET @airport_new = (SELECT airport FROM inserted) 
-- INSERT INTO audit_airports VALUES 
--(GETDATE(), @airportId_old, @airportId_new, @airport_old, @airport_new)
--END

--insert into airport values ('Manchester')
--update airport set airport ='Gomel' where airport like 'Manchester';
--select * from audit_airports;
--2.	Триггер для реализации бизнес-правил
--drop table if exists sale_flight_pause;
--CREATE TABLE sale_flight_pause (
--recId INT PRIMARY KEY identity, 
--flightId INT constraint fk_flight
--            references flight
--            on update cascade on delete cascade,
--days int
--);
--GO
--drop trigger if exists date_pause;
--go
--create TRIGGER date_pause ON log AFTER INSERT
--AS
--BEGIN
--DECLARE @flightId int
--DECLARE @saleDate  date
--DECLARE @flightDate date
--DECLARE @dateDiffDay int
--SET  @flightId = (SELECT flightId FROM inserted) 
--SET @saleDate=(SELECT saleDate FROM inserted)
--SET @flightDate=convert(date,(SELECT flightDate FROM inserted))
--set @dateDiffDay = DATEDIFF(day, @saleDate ,@flightDate)

--insert into sale_flight_pause values
--(@flightId, @dateDiffDay)
--END
--select * from sale_flight_pause
--3.	Триггер для обеспечения целостности
--drop trigger if exists log_integrity
--GO
--create TRIGGER log_integrity ON log AFTER INSERT, UPDATE 
--AS
--BEGIN
--IF ((
--	SELECT flight.flightId FROM flight, inserted
--		WHERE flight.flightId = inserted.flightId) IS NULL
--	or (SELECT client.clientId from client, inserted
--		where client.clientId = inserted.clientId) IS NULL)
--BEGIN
--ROLLBACK TRANSACTION
--PRINT '-------------rollback----------'
--END
--ELSE PRINT '-------------commit-------------'
--END
--go
--insert into log values(getdate(),4,GETDATE(),22)
--4.	Триггер для запрещения удаления триггеров
drop trigger if exists prevent_drop_triggers ON DATABASE
GO
CREATE TRIGGER prevent_drop_triggers
ON DATABASE FOR DROP_TRIGGER
AS PRINT 'For trigger deleting you have to disable "prevent_drop_triggers" '
ROLLBACK

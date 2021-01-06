use ticket;
--1.	Создать таблицу «Архив» и с помощью запроса внести в нее
--данные о продажах  за все годы, предшествующие текущему.  Вывести созданную таблицу.  
--DROP TABLE IF EXISTS archive
--CREATE TABLE archive(
--copyId int IDENTITY(1,1) NOT NULL,
--	saleId int NOT NULL,
--	saleDate date NOT NULL,
--	flightId int NOT NULL,
--	flightDate datetime NOT NULL,
--	clientId int NOT NULL,);
--INSERT INTO archive (saleId, saleDate, flightId, flightDate, clientId)
--SELECT *
--FROM log
--WHERE year(saleDate) != year(getDate());
--select * from archive;
--2.	В таблицу «Клиенты»  добавить поле «Сумма»  и с помощью запроса внести в это поле
--сумму всех покупок клиентом. Вывести таблицу «Клиенты».
--ALTER TABLE client
--DROP COLUMN purchiseSum;
--ALTER TABLE client
--ADD purchiseSum smallmoney;
--update client 
--set purchiseSum = (
--	select sum(B.cost) from(
--select flight.flightId, flight.cost from (select * from log where clientId = client.clientId) as T
--join flight on T.flightId = flight.flightId
--) B
--); 
--select * from client;
--3.	Проиндексировать таблицу «Клиенты» по полям «Фамилия» и «Адрес».
--create index multi_colomn_index
--on client (lastName, address);
--4.	Удалить из таблицы «Журнал продаж» данные о продажах за все годы, предшествующие текущему. 
--delete from log where year(saleDate) != year(getDate());
--5.	Удалить из таблицы «Клиенты» данные клиентов, не покупавших билеты в этом году.
delete from client where(
select count(*) from log
where log.clientId = client.clientId 
	and year(saleDate) = year(getDate())) < 1
;

use ticket;
--1.	Создать представление, содержащее  полную информацию о продажах за прошлый месяц.
-- С помощью созданного представления определить рейс, на который продано максимальное количество билетов.
--go
--DROP view IF EXISTS sales
--go
--create view sales
--as select * from log
--where month(saleDate) = month(dateAdd(m, -1, getDate()))
--	and year(saleDate) = year(getDate());
--go
--    select flightId from(
--     SELECT flightId, COUNT(*) mycount
--    FROM sales
--    GROUP BY flightId)as Y
--    where mycount = (select max(mycount)
--    from (SELECT COUNT(*) mycount
--    FROM sales
--    GROUP BY flightId) as T );			
--2.	Создать представление, содержащее полную информацию обо всех рейсах,на которые были проданы билеты 
--на следующий месяц. С помощью созданного представления определить рейс,приносящий максимальную выручку.
--drop view if exists nextMonthFlights;
--go
--create view nextMonthFlights
--as select log.*, flight.cost, flight.sourceAirportId, flight.destAirportId from log
--join flight on log.flightId = flight.flightId 
--	and month(flightDate) = month(dateAdd(m, 1, getDate()))
--	and year(flightDate) = year(getDate());
--go
--select flightId from(
--select flightId, sum(cost) mycount from nextMonthFlights
--group by flightId) as X
--where mycount = (select max(mycount) from (select sum(cost) mycount from nextMonthFlights
--group by flightId)as Y);
--3.	Создать представление, содержащее информацию о  среднем количестве билетов, продаваемых на рейс.
--С помощью созданного представления определить рейс, средняя загрузка которого минимальна.
--drop view if exists averageSoldTickets;
--go
--create view averageSoldTickets as 
--select flightId, avg(convert(float, frequency)) averageTicketsNumber
--from(
--	select flightId, flightDate, count(*) frequency from log
--	group by flightId, flightDate
--) A 
--group by flightId;
--go
--select top 1 * from averageSoldTickets
--order by averageTicketsNumber;
--4.	Создать представление, содержащее  информацию о рейсах, совершаемых в аэропорт «Минск1» и из него.
--С помощью созданного представления определить аэропорт, полеты в который из Минска наиболее часты.
drop view if exists minskInfo;
go
create view minskInfo
as select flight.flightId, flight.cost, airport.airport sourceAirport, secondAirport.airport arrivingAirport from flight
join airport on flight.sourceAirportId = airport.airportId
	and (flight.sourceAirportId = (select airportId from airport where airport like 'Minsk1')
	or flight.destAirportId = (select airportId from airport where airport like 'Minsk1'))
join (select * from airport) secondAirport on flight.destAirportId = secondAirport.airportId
and (flight.sourceAirportId = (select airportId from airport where airport like 'Minsk1')
	or flight.destAirportId = (select airportId from airport where airport like 'Minsk1'));

go
select * from minskInfo;

select arrivingAirport from(
select arrivingAirport, count(*) myCount from minskInfo
group by arrivingAirport) A
where myCount = (select max(myCount)
from (SELECT COUNT(*) mycount from minskInfo group by arrivingAirport) B);
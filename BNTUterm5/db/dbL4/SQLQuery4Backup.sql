use ticket;
--1.	Список аэропортов, в которые осуществляются полеты из аэропорта Минск.
--select airport from airport 
--where airportId in(
--select destAirportId from flight where sourceAirportId = (select airportId from airport where airport = 'Minsk1'));
--2.	Список пассажиров на рейс Минск-Париж на сегодня.
--select * from client where clientId in(
--	select clientId from log where flightId = (select top 1 flightId from flight where 
--			sourceAirportId = (select airportId from airport where airport='Minsk1')
--			and destAirportId = (select airportId from airport where airport='vnukovo')
--			and flightId in(select flightId from log where datePart(d, flightDate) = datePart(d, getDate()))
--		)
--		and datePart(d, flightDate) = datePart(d, getDate())
--);
--3.	Список рейсов, на которые приобретал билет пассажир Иванов.
--select * from flight
--where exists(select * from log
--		where log.flightId = flight.flightId
--			and clientId = (select clientId from client where lastName = 'Varabei'));
--4.	Список номеров рейсов и цену билета в аэропорты Берлин, Париж, Амстердам из Минска.
--select flightNumber, cost from flight where
--	sourceAirportId = (select airportId from airport where airport like 'Minsk1') and
--	destAirportId in (select airportId from airport where airport in('Paris','Berlin','Amsterdam'));
--5.	Номер рейса, на который продано максимальное количество билетов на прошлой неделе.
select flightNumber from flight where
	flightId = (select flightId from(
	SELECT flightId, COUNT(*) mycount 
	FROM log 
	where datePart(ww, saleDate) = datePart(ww, dateAdd(ww, -1, getDate()))
	GROUP BY flightId )as Y
	where mycount = (select max(mycount) 
	from (SELECT COUNT(*) mycount 
	FROM log 
	where datePart(ww, saleDate) = datePart(ww, dateAdd(ww, -1, getDate()))
	GROUP BY flightId) as T ));
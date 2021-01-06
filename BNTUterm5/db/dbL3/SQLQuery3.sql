use ticket;
--1.	Подсчитать количество клиентов, обслуженных кассой за прошедший месяц.
--select * from log;
--select count(*) from (
--SELECT clientId FROM log
--where month(saleDate) = month(dateAdd(m, -1, getDate()))
--group by clientId
--) T;
--2.	Подсчитать количество билетов, проданных на рейс с кодом 5, вылетающий завтра.
--select count(saleId) from log where flightId = 5 and convert(date,flightDate) =convert(date,getDate()+1);
--3.	Найти клиента, купившего  максимальное количество билетов за прошедший месяц.
select top 1 clientId, count(*) as facingNumber from log 
where month(saleDate) = month(dateAdd(m, -1, getDate())) and
year(saleDate) = year(getDate())
group by clientId
order by facingNumber DESC;
--4.	Найти рейс с самой высокой ценой.
--select * from flight where cost=(select max(cost) from flight);
--5.	Определить среднюю стоимость билета на рейсы, вылетающие из аэропорта с кодом 1.
--select avg(cost) from flight where sourceAirportId = 1;
--6.	Определить среднее количество билетов, приобретенных одним клиентом в прошлом месяце.
--select avg(avgCount) avarageNumberOfBoughtTicketsByOneClient
--from(select count(*) avgCount from log
--where  month(saleDate) = month(dateAdd(m, -1, getDate()))
--and year(saleDate) = year(getDate())
--group by clientId) T;
--7.	Определить суммарную стоимость билетов, проданных за месяц.
select sum(cost), sum(cost) from flight, log
where saleDate <= getDate() and saleDate >= dateAdd(m, -1, getDate()) and log.flightId = flight.flightId;



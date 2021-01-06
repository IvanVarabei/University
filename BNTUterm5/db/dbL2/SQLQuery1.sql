use ticket;
--select TOP 75 PERCENT * from log; 
--select top 3 flightId from flight where cost > 200;
--select flightId from log where clientId = 3 and month(saleDate) = month(dateAdd(m, -1, getdate()));
--select cost from flight where sourceAirportId = 1 and destAirportId in(3, 4, 7);
--select * from log where saleDate >= DATEADD(day,-7, GETDATE());
--select * from log where datepart(ww, saleDate) = datepart(ww, dateAdd(ww, -1, getdate()));
select * from client where phone is null or phone ='';
--select * from client where lastName like 'Va%';

Note: All the data were exported to different CSV files before analysis

-- Getting the Driver's Uber ID and Supply Hour
select driveruuid, cast(year+'-'+month+'-'+day as date) week_date
, sum(((cast(split_part("timeonline_days__hours__minutes",':',1) as decimal(6,2))*24*60)+
  (cast(split_part("timeonline_days__hours__minutes",':',2) as decimal(6,2))*60)+ 
  cast(split_part("timeonline_days__hours__minutes",':',3) as decimal(6,2)))/60) supply_hours
, sum(((cast(split_part("timeontrip_days__hours__minutes",':',1) as decimal(6,2))*24*60)+ 
(cast(split_part("timeontrip_days__hours__minutes",':',2) as decimal(6,2))*60)+ 
cast(split_part("timeontrip_days__hours__minutes",':',3) as decimal(6,2)))/60) trip_hours
from uberdata_new.new_driver_performance_weekly
where "driveruuid" != '00000000-0000-0000-0000-000000000000'
and country = 'ghana'
and cast(year+'-'+month+'-'+day as date) <'2022-11-07'
group by country, driveruuid,cast(year+'-'+month+'-'+day as date);


--Distance Driven (KM)
 select  driveruuid,cast(year+'-'+month+'-'+day as date), sum(nt.tripdistance) as Km
 from uberdata_new.new_trip_activity_weekly nt
 where nt.driveruuid notnull
 and nt.country = 'ghana'
 and cast(year+'-'+month+'-'+day as date) < '2022-11-07'
 group by nt.driveruuid, cast(year+'-'+month+'-'+day as date)
 
 -- Acceptance and cancellatio nrate 
 select driveruuid, cast(year+'-'+month+'-'+day as date), sum(uq.acceptancerate) , sum(uq.cancellationrate)
 from uberdata_new.new_driver_quality_weekly Uq
 Where cast(year+'-'+month+'-'+day as date) < '2022-11-07'
 and driveruuid notnull
 and country = 'ghana'
 group by driveruuid , cast(year+'-'+month+'-'+day as date)
 
 
 
 -- Validating some driver's data 
 select cast(year+'-'+month+'-'+day as date), driveruuid, sum(cancellationrate)
 from uberdata_new.new_driver_quality_weekly Uq
 Where cast(year+'-'+month+'-'+day as date) < '2022-11-07'
 and driveruuid = '02671632-5f0f-4c90-9f12-3e2c4bfb6047'
 and country = 'ghana'
 group by cast(year+'-'+month+'-'+day as date), driveruuid 
 
 select cast(year+'-'+month+'-'+day as date), driveruuid, sum(cancellationrate)
 from uberdata_new.new_driver_quality_weekly Uq
 Where cast(year+'-'+month+'-'+day as date) < '2022-11-07'
 and driveruuid = '0063547a-f1c8-45b4-8c0e-ea4df483dc48'
 and country = 'ghana'
 group by cast(year+'-'+month+'-'+day as date), driveruuid 
 
 
 
 
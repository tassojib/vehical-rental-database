-- query 1

select
  b.id,
  u.name,
  v.vehicle_name,
  b.start_date,
  b.end_date,
  b.status
from
  bookings as b
  inner join users as u on b.user_id = u.id
  inner join vehicles as v on b.vehicle_id = v.id;



-- query 2

SELECT *
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.id
);


-- query 3

SELECT *
FROM vehicles
WHERE availability_status = 'available'
  AND type = 'car';


-- query 4
select
  vehicle_name,
  count(b.id) as total_bookings
from
  vehicles v
  inner join bookings b on v.id = b.vehicle_id
group by
  vehicle_name
  having count(b.id)>2;

-- Retrieve all successful bookings:
select * from booking_cleaned where booking_status = 'Success';

-- Find the average ride distance for each vehicle type:
select vehicle_type, avg(ride_distance) from booking_cleaned 
group by vehicle_type;

-- Get the total number of cancelled rides by customers:
select count(*) from booking_cleaned where Booking_Status = 'Canceled by Customer';

-- List the top 5 customers who booked the highest number of rides:

with cte as (select customer_id, count(booking_id) as cnt from booking_cleaned
where Booking_Status = 'Success'
group by customer_id
),
cte2 as (select a.*, rank() over (partition by customer_id order by cnt desc) as rnk from cte a)
select * from cte2 where rnk <=5;
;

-- Get the number of rides cancelled by drivers due to personal and car-related issues:
select count(*) from booking_cleaned where canceled_rides_by_driver = 'Personal & Car related issue';

-- Find the maximum and minimum driver ratings for Prime Sedan bookings:
select min(driver_ratings), max(driver_ratings) from booking_cleaned
where vehicle_type = 'Prime Sedan';

-- Retrieve all rides where payment was made using UPI:
select * from booking_cleaned where Payment_Method = 'UPI';

-- Find the average customer rating per vehicle type:
select vehicle_type, avg(Customer_Rating) from booking_cleaned group by vehicle_type;

-- Calculate the total booking value of rides completed successfully:
select sum(booking_value) from booking_cleaned where Booking_Status = 'Success';

-- List all incomplete rides along with the reason:
select incomplete_rides, incomplete_rides_reason from booking_cleaned where incomplete_rides = 'Yes';
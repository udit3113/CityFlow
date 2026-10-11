SELECT COUNT(*)
FROM bookings;

SELECT "Booking Status", COUNT(*)
FROM bookings
GROUP BY "Booking Status";

SELECT COUNT(*)
FROM bookings
WHERE "Booking Status" = 'Completed';

SELECT "Vehicle Type", COUNT(*)
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Vehicle Type";

SELECT "Vehicle Type", AVG("Booking Value")
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Vehicle Type";

SELECT "Vehicle Type", AVG("Booking Value") AS avg_booking_value
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Vehicle Type"
ORDER BY avg_booking_value DESC;

SELECT "Vehicle Type", AVG("Booking Value") AS avg_booking_value
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Vehicle Type"
ORDER BY avg_booking_value DESC
LIMIT 3;

SELECT "Vehicle Type", SUM("Booking Value") AS total_booking_value
From bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Vehicle Type"
ORDER BY total_booking_value DESC;

SELECT "Vehicle Type", MAX("Booking Value") AS max_booking_value , MIN("Booking Value") AS min_booking_value
FROM bookings
WHERE "Booking Status" = 'Completed'
Group by "Vehicle Type"
ORDER BY max_booking_value , min_booking_value DESC;

SELECT count(*)
FROM bookings
WHERE "Booking Status" = "Completed"
AND "Vehicle TYPE" = "Go Sedan";


SELECT COUNT(*)
FROM bookings
WHERE "Booking Status" = 'Completed'
AND (
    "Vehicle Type" = 'Bike'
    OR "Vehicle Type" = 'eBike'
);

SELECT COUNT(*)
FROM bookings
WHERE "Booking Status" = 'Completed'
AND "Booking Value" > 1000;

select count(*)
from bookings
where "Booking Status" = 'Completed'
AND "Booking Value" > 500
AND "Booking Value" <= 1000;

SELECT COUNT(*)
FROM bookings
WHERE "Booking Status" = 'Completed'
AND "Booking Value" BETWEEN 500 AND 1000;

SELECT COUNT(*)
FROM bookings
WHERE "Booking Status" = 'Completed'
AND "Booking Value" = 500;

Select count(*)
from bookings
where "Booking Status" = 'Completed'
And "Vehicle Type" in ('Bike' , 'eBike' , 'Auto');

Select count(*)
From bookings
where "booking status" = 'Completed'
And "Vehicle Type" Not in ('Bike' , 'eBike' , 'Auto');

Select DISTINCT "Pickup Location"
from bookings
where "Pickup location" Like '%Nagar%';

select count(*)
from bookings
where "Pickup Location" Like '%Nagar%'; 

select count(*)
from bookings
where "Reason for cancelling by Customer" IS NOT NULL;
 
SELECT "Booking Value",
CASE
    WHEN "Booking Value" > 1000 THEN 'High'
    WHEN "Booking Value" >= 500 THEN 'Medium'
    ELSE 'Low'
END AS value_category

from bookings ;

SELECT
CASE
WHEN "Booking Value" > 1000 ThEN 'High'
WhEN "Booking Value" >= 500 THeN 'Medium'
WHEN "Booking Value" IS NULL THEN 'Missing'
ELSE 'Low'
END AS value_category,
    COUNT(*) AS booking_count
FROM bookings
GROUP BY value_category;



SELECT
    CASE
        WHEN "Booking Value" IS NULL THEN 'Missing'
        WHEN "Booking Value" > 1000 THEN 'High'
        WHEN "Booking Value" >= 500 THEN 'Medium'
        ELSE 'Low'
    END AS value_category,

    COUNT(*) AS booking_count,

    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bookings),
        2
    ) AS percentage

FROM bookings

GROUP BY value_category;

SELECT
    "Pickup Location",
    COUNT(*) AS booking_count
FROM bookings
GROUP BY "Pickup Location"
ORDER BY booking_count DESC
LIMIT 1;

SELECT
    "Pickup Location",
    COUNT(*) AS booking_count
FROM bookings
GROUP BY "Pickup Location"
HAVING COUNT(*) > 500
ORDER BY booking_count desc;


SELECT "Pickup Location", COUNT(*) AS booking_count
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Pickup Location"
HAVING COUNT(*) > 500
ORDER BY booking_count DESC;

SELECT "Vehicle Type", COUNT(*) AS booking_count
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Vehicle Type"
LIMIT 1;

SELECT COUNT(*) AS booking_count
FROM bookings
WHERE "Booking Status" = 'Completed'
  AND "Booking Value" > 1000;

  
SELECT "Date", COUNT(*) AS booking_count
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Date"
ORDER BY booking_count DESC
LIMIT 1;

SELECT strftime('%H', "Time") AS hour,
       COUNT(*) AS booking_count
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY strftime('%H', "Time")
ORDER BY booking_count DESC
LIMIT 1;

SELECT
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bookings) AS cancellation_percentage
FROM bookings
WHERE "Reason for cancelling by Customer" IS NOT NULL;

Select 
      count(*) * 100.0 /(select count(*) from bookings) as cancellation_percentage 
from bookings
where "Driver Cancellation Reason" is not null; 

SELECT
    COUNT(CASE WHEN "Reason for cancelling by Customer" IS NOT NULL THEN 1 END) AS cancelled_by_customer,
    COUNT(CASE WHEN "Driver Cancellation Reason" IS NOT NULL THEN 1 END) AS cancelled_by_driver
FROM bookings;

SELECT "Pickup Location",
       COUNT(*) AS customer_cancellations
FROM bookings
WHERE "Reason for cancelling by Customer" IS NOT NULL
GROUP BY "Pickup Location"
ORDER BY customer_cancellations DESC
LIMIT 1;

SELECT "Pickup Location",
       COUNT(*) AS driver_cancellations
FROM bookings
WHERE "Driver Cancellation Reason" IS NOT NULL
GROUP BY "Pickup Location"
ORDER BY driver_cancellations DESC
LIMIT 1;

Select "Pickup Location",
    count(case when "Reason for cancelling by Customer" is not null then 1 end) as cancelled_by_customer,
    count(case when "Driver Cancellation Reason" is not null then 1 end) as cancelled_by_driver
from bookings
group by "Pickup Location"
order by (cancelled_by_customer + cancelled_by_driver ) DESC
limit 1;
      
select "Pickup Location", sum("Booking Value") as booking_value
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
order by booking_value DESC
limit 1;

select "Pickup Location", Avg("Booking Value") as booking_value
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
order by booking_value DESC
limit 1;

select "Pickup Location", avg("Ride Distance") as ride_distance
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
order by ride_distance desc 
limit 1;


select "Pickup Location", count(*) as long_rides
from bookings
where "Booking Status" = 'Completed'
and "Ride Distance" > 20
group by "Pickup Location"
order by long_rides DESC
limit 1; 

select "Pickup Location" , Avg("Customer Rating") as customer_rating
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
order by customer_rating DESC
limit 1; 

select "Pickup Location" , Avg("Driver Ratings") as driver_rating
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
order by driver_rating DESC
limit 1; 

Select "Pickup Location" , count(*) as completed_rides , Sum("Booking Value") as booking_value
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location";

select "Pickup Location" , AVG("Booking Value") AS booking_value
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
order by booking_value desc;

SELECT "Pickup Location", count(*) as total_bookings , 
count(Case when " Reason for cancelling by Customer" is not null or "Driver Cancellation Reason" is not null then 1 end) as cancelled_bookings
from bookings

group by "Pickup Location";

SELECT
    "Pickup Location",
    COUNT(*) AS total_bookings,

    COUNT(
        CASE
            WHEN "Reason for cancelling by Customer" IS NOT NULL
              OR "Driver Cancellation Reason" IS NOT NULL
            THEN 1
        END
    ) AS cancelled_bookings

FROM bookings

GROUP BY "Pickup Location";

SELECT
    "Pickup Location",
    total_bookings,
    cancelled_bookings,
    cancelled_bookings * 100.0 / total_bookings AS cancellation_rate
FROM (
    SELECT
        "Pickup Location",
        COUNT(*) AS total_bookings,

        COUNT(
            CASE
                WHEN "Driver Cancellation Reason" IS NOT NULL
                THEN 1
            END
        ) AS cancelled_bookings

    FROM bookings
    GROUP BY "Pickup Location"
)
ORDER BY cancellation_rate DESC
LIMIT 1;


SELECT  
      "Pickup Location",
      completed_rides,
      long_rides,
      long_rides * 100.0 / completed_rides as long_rides_rate
From(
    select
        "Pickup Location",
        count(*) as completed_rides,

        count(
            CASE
                when "Ride Distance" > 20 
                then 1 
            END
        ) as long_rides 

    from bookings
    where "Booking Status" = 'Completed'
    group by "Pickup Location"
)
order by long_rides_rate desc
limit 1; 

select "Pickup Location", Avg("Booking Value") as booking_value , count(*) as completed_rides
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
HAVING completed_rides >= 500
order by booking_value DESC
limit 1;


select 
      "Pickup Location",
      completed_rides,
      high_value_rides,
      high_value_rides * 100.0 / completed_rides as high_value_rate
from(
    SELECT
        "Pickup Location",
        count(*) as completed_rides,

        count(
            CASE 
                when "Booking Value" > 1000 
                then 1
            END
        ) as high_value_rides 

    from bookings
    where "Booking Status" = 'Completed'
    GROUP BY "Pickup Location"
)
ORDER BY high_value_rate DESC 
limit 1;

select "Pickup Location" , Avg("Ride Distance") as avg_distance , Avg("Booking Value") as avg_booking_value , count(*) as completed_rides
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
having completed_rides >= 500 and avg_distance > 20
order by avg_distance desc
limit 1;
 
select 
      "Pickup Location",
      total_bookings,
      cancelled_bookings,
      cancelled_bookings * 100.0 / total_bookings as cancellation_rate
from(
    select
        "Pickup Location",
        count(*) as total_bookings,

        count(
            CASE
                when "Reason for cancelling by Customer" is not null 
                   OR "Driver Cancellation Reason" is not null 
                then 1
            END
        ) as cancelled_bookings

    from bookings
    group by "Pickup Location"
)
where total_bookings >= 700
order by cancellation_rate DESC
limit 1;

select
     "Pickup Location",
     high_value_rides,
     completed_rides,
     high_value_rides * 100.0 / completed_rides as high_value_ride_percent
from(
    SELECT
        "Pickup Location",
        count(*) as completed_rides,

        count(
            CASE
                when "Booking Value" > 1000
                then 1
            END
        ) as high_value_rides

    from bookings
    where "Booking Status" = 'Completed' 
    group by "Pickup Location"
    having completed_rides >= 500 
)

order by high_value_ride_percent DESC
limit 1;


 select 
      "Pickup Location",
      total_bookings,
      cancelled_bookings,
      cancelled_bookings * 100.0 / total_bookings as cancellation_rate
from(
    select
        "Pickup Location",
        count(*) as total_bookings,

        count(
            CASE
                when "Driver Cancellation Reason" is not null 
                then 1
            END
        ) as cancelled_bookings

    from bookings
    group by "Pickup Location"
)
where total_bookings >= 700
order by cancellation_rate DESC
limit 1;

select "Pickup Location" , Avg("Ride Distance") as ride_distance , Avg("Booking Value") as avg_booking_value , count(*) as completed_rides 
from bookings
where "Booking Status" = 'Completed'
group by "Pickup Location"
having ride_distance > 20
order by avg_booking_value DESC
limit 1;

SELECT "Pickup Location",
       COUNT(*) AS completed_rides,
       SUM("Booking Value") AS total_booking_value,
       AVG("Booking Value") AS avg_booking_value
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Pickup Location"
HAVING COUNT(*) >= 500
ORDER BY avg_booking_value DESC
LIMIT 1;

SELECT
    "Pickup Location",
    total_bookings,
    completed_rides,
    avg_ride_distance,
    cancelled_bookings,
    cancelled_bookings * 100.0 / total_bookings AS cancellation_rate
FROM (
    SELECT
        "Pickup Location",
        COUNT(*) AS total_bookings,

        COUNT(
            CASE
                WHEN "Booking Status" = 'Completed'
                then 1
            END
        ) as completed_rides,

        Avg(
            case
                when "Booking Status" = 'Completed'
                then "Ride Distance"
            END
        ) as avg_ride_distance,
        
        COUNT(
            CASE
                WHEN "Driver Cancellation Reason" IS NOT NULL
                  or "Cancelled Rides by Customer" is not null 
                THEN 1
            END
        ) AS cancelled_bookings 

    FROM bookings
    GROUP BY "Pickup Location"
    Having completed_rides >= 500  and avg_ride_distance > 20
)
ORDER BY cancellation_rate DESC
LIMIT 1;

SELECT
    "Pickup Location",
    total_bookings,
    completed_rides,
    driver_cancellation,
    driver_cancellation * 100.0 / total_bookings AS driver_cancellation_rate
FROM (
    SELECT
        "Pickup Location",
        COUNT(*) AS total_bookings,
        
        count(
            case
                when "Booking Status" = 'Completed'
                then 1
            END
        ) as completed_rides,

        COUNT(
            CASE
                WHEN "Driver Cancellation Reason" is not NULL
                then 1
            END
        ) AS driver_cancellation 

    FROM bookings
    GROUP BY "Pickup Location"
    HAVING total_bookings >= 700 and completed_rides >= 500
)
ORDER BY driver_cancellation_rate DESC
LIMIT 1;
     

SELECT "Pickup Location",
       COUNT(*) AS completed_rides,
       SUM("Booking Value") AS total_booking_value,
       SUM("Booking Value") / COUNT(*) AS value_per_completed_ride
FROM bookings
WHERE "Booking Status" = 'Completed'
GROUP BY "Pickup Location"
HAVING completed_rides >= 500
ORDER BY value_per_completed_ride DESC
LIMIT 1;

SELECT hour,
       total_bookings,
       cancelled_by_driver,
       cancelled_by_driver * 100.0 / total_bookings AS cancellation_rate_by_driver
FROM (
    SELECT strftime('%H', "Time") AS hour,
            COUNT(*) AS total_bookings,
            COUNT(CASE
                WHEN "Cancelled Rides by Driver" IS NOT NULL
                THEN 1
            END) AS cancelled_by_driver

    FROM bookings
    WHERE "Pickup Location" = 'Nehru Place'
    GROUP BY hour 
    having count(*) >= 30
)
ORDER BY cancellation_rate_by_driver DESC
LIMIT 1;

SELECT "Driver Cancellation Reason",
       COUNT(*) AS cancellation_count
FROM bookings
WHERE "Pickup Location" = 'Nehru Place' 
    AND "Cancelled Rides by Driver" IS NOT NULL
GROUP BY "Driver Cancellation Reason"
ORDER BY cancellation_count DESC;

select strftime('%H' , "Time") as hour , count(*) as cancellation_count
from bookings
where "Pickup Location" = 'Nehru Place' and "Driver Cancellation Reason" = 'More than permitted people in there' and "Cancelled Rides by Driver" is not NULL
group by hour
order by cancellation_count desc
limit 1;

select strftime('%H' , "Time") as hour , count(*) as cancellation_count
from bookings
where "Pickup Location" = 'Nehru Place' and "Cancelled Rides by Driver" is not NULL
group by hour
order by cancellation_count desc
limit 1;

SELECT "Driver Cancellation Reason",
       COUNT(*) AS cancellation_count
FROM bookings
WHERE "Pickup Location" = 'Nehru Place' and strftime('%H' , "Time") = '11' AND "Cancelled Rides by Driver" IS NOT NULL
GROUP BY "Driver Cancellation Reason"
ORDER BY cancellation_count DESC;


select
    "Pickup Location",
    cancelled_ride_by_driver,
    total_bookings,
    cancelled_ride_by_driver * 100.0 / total_bookings as cancellation_rate_by_driver
from(
    select "Pickup Location",
           count(*) as total_bookings,

           count(case
                when "Cancelled Rides by Driver" is not null 
                then 1
            end) as cancelled_ride_by_driver 

    from bookings
    where strftime('%H', "Time") = '11'
    group by "Pickup Location"
    having count(*) >= 30
)
order by cancellation_rate_by_driver DESC
limit 1;

SELECT hour,
       total_bookings,
       cancelled_by_driver,
       cancelled_by_driver * 100.0 / total_bookings AS cancellation_rate_by_driver
from(
    select strftime('%H' , "TIME") AS hour,
           count(*) as total_bookings,

           count(CASE
                when "Cancelled Rides by Driver" is not NULL
                then 1
            end) as cancelled_by_driver
    from bookings
    group by hour
)
order by hour;


SELECT hour,
       total_bookings,
       "Pickup Location",
       cancelled_by_driver,
       cancelled_by_driver * 100.0 / total_bookings AS cancellation_rate_by_driver
from(
    select strftime('%H' , "TIME") AS hour,
           "Pickup Location",
           count(*) as total_bookings,

           count(CASE
                when "Cancelled Rides by Driver" is not NULL
                then 1
            end) as cancelled_by_driver
    from bookings
    where "Pickup Location" = 'Nehru Place'  
    group by hour
    having total_bookings >= 30
    
)
order by hour;

sELECT hour 
       total_bookings,
       "Pickup Location",
       cancelled_by_driver,
       cancelled_by_driver * 100.0 / total_bookings AS cancellation_rate_by_driver
from(
    select strftime('%H' , "TIME") AS hour,
           "Pickup Location",
           count(*) as total_bookings,

           count(CASE
                when "Cancelled Rides by Driver" is not NULL
                then 1
            end) as cancelled_by_driver
    from bookings
    where hour = '11' 
    group by "Pickup Location" 
    having total_bookings >= 30
    
)
order by "Pickup Location";


SELECT "Pickup Location",
       COUNT(*) AS total_bookings,
       COUNT(CASE
             WHEN "Cancelled Rides by Driver" IS NOT NULL
             THEN 1
       END) AS cancelled_by_driver,
       COUNT(CASE
             WHEN "Cancelled Rides by Driver" IS NOT NULL
             THEN 1
       END) * 100.0 / COUNT(*) AS cancellation_rate_by_driver
FROM bookings
WHERE strftime('%H', "Time") = '11'
GROUP BY "Pickup Location"
HAVING COUNT(*) >= 30
ORDER BY cancellation_rate_by_driver DESC;

SELECT COUNT(*)
FROM (
    SELECT "Pickup Location",
           COUNT(*) AS total_bookings,
           COUNT(CASE
                 WHEN "Cancelled Rides by Driver" IS NOT NULL
                 THEN 1
           END) AS cancelled_by_driver,
           COUNT(CASE
                 WHEN "Cancelled Rides by Driver" IS NOT NULL
                 THEN 1
           END) * 100.0 / COUNT(*) AS cancellation_rate_by_driver
    FROM bookings
    WHERE strftime('%H', "Time") = '11'
    GROUP BY "Pickup Location"
    HAVING COUNT(*) >= 30
)
WHERE cancellation_rate_by_driver > 17.41; 

sELECT hour,
       total_bookings,
       "Pickup Location",
       cancelled_by_driver,
       cancelled_by_driver * 100.0 / total_bookings AS cancellation_rate_by_driver
from(
    select strftime('%H' , "TIME") AS hour,
           "Pickup Location",
           count(*) as total_bookings,

        count(CASE
            when "Cancelled Rides by Driver" is not NULL
            then 1
            end) as cancelled_by_driver,
        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
            END) * 100.0 / COUNT(*) AS cancellation_rate_by_driver
    from bookings
    where strftime('%H', "Time") = '11' 
    group by "Pickup Location" 
    having total_bookings >= 30    
)
Where cancellation_rate_by_driver > 17.41;

sELECT hour,
       total_bookings,
       "Pickup Location",
       cancelled_by_driver,
       cancelled_by_driver * 100.0 / total_bookings AS cancellation_rate_by_driver
from(
    select strftime('%H' , "TIME") AS hour,
           "Pickup Location",
           count(*) as total_bookings,

        count(CASE
            when "Cancelled Rides by Driver" is not NULL
            then 1
            end) as cancelled_by_driver
    from bookings
    where "Pickup Location" = 'Nehru Place' 
    group by "hour" 
    having total_bookings >= 30    
)
order by hour;

select Avg(cancellation_rate_by_driver)
from(
    sELECT hour,
       total_bookings,
       "Pickup Location",
       cancelled_by_driver,
       cancelled_by_driver * 100.0 / total_bookings AS cancellation_rate_by_driver
    from(
        select strftime('%H' , "TIME") AS hour,
           "Pickup Location",
            count(*) as total_bookings,

            count(CASE
               when "Cancelled Rides by Driver" is not NULL
               then 1
               end) as cancelled_by_driver
        from bookings
        where "Pickup Location" = 'Nehru Place' 
        group by "hour" 
        having total_bookings >= 30    
    )
);

sELECT hour,
       total_bookings,
       "Pickup Location",
       cancelled_by_driver,
       avg_cancellation_rate_by_driver,
       cancelled_by_driver * 100.0 / total_bookings AS cancellation_rate_by_driver
from(
    select strftime('%H' , "TIME") AS hour,
           "Pickup Location",
           count(*) as total_bookings,

        count(CASE
            when "Cancelled Rides by Driver" is not NULL
            then 1
            end) as cancelled_by_driver,
        AVG(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
            END)  AS avg_cancellation_rate_by_driver
    from bookings
    where "Pickup Location" = 'Nehru Place'
    group by hour 
    having total_bookings >= 30    
)
Where cancellation_rate_by_driver > avg_cancellation_rate_by_driver;


WITH hourly_rates AS (
    SELECT
        strftime('%H', "Time") AS hour,
        "Pickup Location",
        COUNT(*) AS total_bookings,

        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) AS cancelled_by_driver,

        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) * 100.0 / COUNT(*) AS cancellation_rate_by_driver

    FROM bookings

    WHERE "Pickup Location" = 'Nehru Place'

    GROUP BY hour

    HAVING COUNT(*) >= 30
),

with_average AS (
    SELECT *,
           AVG(cancellation_rate_by_driver) OVER ()
           AS avg_hourly_cancellation_rate
    FROM hourly_rates
)

SELECT *
FROM with_average
WHERE cancellation_rate_by_driver > avg_hourly_cancellation_rate;


WITH hourly_rates AS (
    SELECT
        strftime('%H', "Time") AS hour,
        "Pickup Location",
        COUNT(*) AS total_bookings,

        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) AS cancelled_by_driver,

        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) * 100.0 / COUNT(*) AS cancellation_rate_by_driver

    FROM bookings

    WHERE "Pickup Location" = 'Nehru Place'

    GROUP BY hour

    HAVING COUNT(*) >= 50
),

with_average AS (
    SELECT *,
           AVG(cancellation_rate_by_driver) OVER ()
           AS avg_hourly_cancellation_rate
    FROM hourly_rates
)

SELECT *
FROM with_average
WHERE cancellation_rate_by_driver > avg_hourly_cancellation_rate;

select "Pickup Location",
       total_bookings,
       completed_rides,
       driver_cancellation,
       driver_cancellation * 100.0 / total_bookings as driver_cancellation_rate
from(
    SELECT
        "Pickup Location",
        count(*) as total_bookings,
        count(
            case when "Cancelled Rides by Driver" is not null 
            then 1 
        end) as driver_cancellation , 
        
        COUNT(CASE WHEN "Booking Status" = 'Completed'
            THEN 1
        END) AS completed_rides

    from bookings
    group by "Pickup Location"
    having total_bookings >= 800 and driver_cancellation > 175
)
order by driver_cancellation_rate desc;

select "Pickup Location",
       total_bookings,
       completed_rides,
       driver_cancellation,
       driver_cancellation * 100.0 / total_bookings as driver_cancellation_rate,
       completed_rides * 100.0 / total_bookings as completion_rate
from(
    SELECT
        "Pickup Location",
        count(*) as total_bookings,
        count(
            case when "Cancelled Rides by Driver" is not null 
            then 1 
        end) as driver_cancellation , 
        
        COUNT(CASE WHEN "Booking Status" = 'Completed'
            THEN 1
        END) AS completed_rides

    from bookings
    group by "Pickup Location"
    having total_bookings >= 800 
)
order by completion_rate asc;

select "Pickup Location",
       total_bookings,
       completed_rides,
       cancelled_by_customer,
       cancelled_by_driver,
       incomplete_rides,
       no_driver_found,
       non_completed_rides,
       (total_bookings - completed_rides) * 100.0 / total_bookings as non_completion_rate,
       cancelled_by_driver * 100.0 / non_completed_rides as non_completion_rate_by_driver
from(
    SELECT
        "Pickup Location",
        count(*) as total_bookings,
        count(
            case when "Cancelled Rides by Customer" is not NULL
            then 1 
        end) as cancelled_by_customer,
        count(
            case when "Cancelled Rides by Driver" is not null 
            then 1
        end) as cancelled_by_driver,
        count(
            case when "Incomplete Rides" is not null 
            then 1 
        end) as incomplete_rides,
        count(
            case when "Booking Status" = 'Completed'
            then 1
        end) as completed_rides ,
        COUNT(
            CASE WHEN "Booking Status" = 'No Driver Found'
            THEN 1
        END) AS no_driver_found,
        count(
            case when "Booking Status" != 'Completed'
            then 1
        end) as non_completed_rides
    from bookings
    where "Pickup Location" = 'Vinobapuri'
    group by "Pickup Location"
)
;

select "Pickup Location",
       reason_count,
       cancelled_by_driver,
       "Driver Cancellation Reason",
       reason_count * 100.0 / 176 as driver_cancellation_rate
from(
    SELECT
        "Pickup Location",
        "Driver Cancellation Reason",
        count(*) as reason_count,
        count(
            case when "Cancelled Rides by Driver" is not NULL
            then 1
        end) as cancelled_by_driver
    from bookings
    WHERE "Pickup Location" = 'Vinobapuri' AND "Booking Status" = 'Cancelled by Driver'
    group by "Driver Cancellation Reason"
)
;

SELECT
    "Driver Cancellation Reason",
    COUNT(*) AS cancellation_count,
    COUNT(*) * 100.0 / 27000 AS percentage
FROM bookings
WHERE "Booking Status" = 'Cancelled by Driver'
GROUP BY "Driver Cancellation Reason"
ORDER BY percentage DESC;


select *,
       (vinobapuri_percentage - platform_percentage) as difference
from(
    select vinobapuri_count,
           platform_count,
           cancelled_by_driver,
           "Driver Cancellation Reason",
            platform_count * 100.0 / 27000 as platform_percentage,
            vinobapuri_count * 100.0 / 176 as vinobapuri_percentage
    from(
        SELECT
            "Driver Cancellation Reason",
            count(*) as platform_count, 
            count(
                case when "Cancelled Rides by Driver" is not NULL
                then 1
            end) as cancelled_by_driver,
            COUNT(
                CASE WHEN "Pickup Location" = 'Vinobapuri'
                THEN 1
            END) AS vinobapuri_count
        from bookings
        WHERE "Booking Status" = 'Cancelled by Driver'
        group by "Driver Cancellation Reason"
    )
)
order by difference;

       
select "Pickup Location",
       total_bookings,
       driver_cancellation,
       driver_cancellation * 100.0 / total_bookings as driver_cancellation_rate
from(
    select "Pickup Location",
            count(*) as total_bookings,
            count(
               case when "Cancelled Rides by Driver" is not NULL
               then 1
            end) as driver_cancellation
    from bookings
    group by "Pickup Location"
    having total_bookings >= 500
)
order by driver_cancellation_rate DESC
limit 10;


select "Pickup Location",
       total_bookings,
       driver_cancellation,
       completed_rides,
       driver_cancellation * 100.0 / total_bookings as driver_cancellation_rate,
       completed_rides * 100.0 / total_bookings as completion_rate
from(
    select "Pickup Location",
            count(*) as total_bookings,
            count(
               case when "Cancelled Rides by Driver" is not NULL
               then 1
            end) as driver_cancellation,
            count(
               case when "Booking Status" = 'Completed'
               then 1 
            end) as completed_rides
    from bookings
    group by "Pickup Location"
    having total_bookings >= 500
)
order by completion_rate asc
limit 10;

select "Pickup Location",
       "Vehicle Type",
       driver_cancellation,
       driver_cancellation * 100.0 / 176 as driver_cancellation_rate
from(
    select "Pickup Location",
           "Vehicle Type",
            count(
               case when "Cancelled Rides by Driver" is not NULL
               then 1
            end) as driver_cancellation
            
    from bookings
    WHERE "Pickup Location" = 'Vinobapuri' 
    group by "Vehicle Type"
)
order by driver_cancellation desc;

SELECT 
    SUM(driver_cancellation) AS top_5_driver_cancellations,
    SUM(driver_cancellation) * 100.0 / 27000 AS top_5_percentage
FROM (
    select "Pickup Location",
           driver_cancellation
    from(
        select "Pickup Location",
                count(
                   case when "Cancelled Rides by Driver" is not NULL
                   then 1
                end) as driver_cancellation
                
        from bookings 
        group by "Pickup Location"
        ORDER BY driver_cancellation DESC
        LIMIT 5
    )
);

select "Pickup Location",
       total_bookings,
       completed_rides,
       driver_cancellation,
       driver_cancellation * 100.0 / total_bookings as driver_cancellation_rate,
       completed_rides * 100.0 / total_bookings as completion_rate
from(
    select "Pickup Location",
            count(*) as total_bookings,
            count(
               case when "Cancelled Rides by Driver" is not NULL
               then 1
            end) as driver_cancellation,
            count(
               case when "Booking Status" = 'Completed'
               then 1 
            end) as completed_rides
    from bookings
    group by "Pickup Location"
    having total_bookings >= 500
)
order by driver_cancellation_rate desc;


select "Pickup Location",
       driver_cancellation,
       customer_cancellation,
       total_bookings,
       driver_cancellation * 100.0 / total_bookings as driver_cancellation_rate,
       customer_cancellation * 100.0 / total_bookings as customer_cancellation_rate
from(
    select "Pickup Location",
            count(*) as total_bookings,
            count(
               case when "Cancelled Rides by Driver" is not NULL
               then 1
            end) as driver_cancellation,
            count(
               case when "Cancelled Rides by Customer" is not NULL
               then 1 
            end) as customer_cancellation
    from bookings
    group by "Pickup Location"
    having total_bookings >= 500
)
order by driver_cancellation_rate desc, customer_cancellation_rate desc;

WITH result AS (
    SELECT
        "Pickup Location",
        total_bookings,
        driver_cancellation,
        customer_cancellation,

        driver_cancellation * 100.0 / total_bookings
            AS driver_cancellation_rate,

        customer_cancellation * 100.0 / total_bookings
            AS customer_cancellation_rate

    FROM (
        SELECT
            "Pickup Location",
            COUNT(*) AS total_bookings,

            COUNT(
                CASE
                    WHEN "Cancelled Rides by Driver" IS NOT NULL
                    THEN 1
                END
            ) AS driver_cancellation,

            COUNT(
                CASE
                    WHEN "Cancelled Rides by Customer" IS NOT NULL
                    THEN 1
                END
            ) AS customer_cancellation

        FROM bookings
        GROUP BY "Pickup Location"
        HAVING COUNT(*) >= 500
    )
),

benchmarked AS (
    SELECT
        *,
        AVG(driver_cancellation_rate) OVER ()
            AS avg_driver_rate,

        AVG(customer_cancellation_rate) OVER ()
            AS avg_customer_rate

    FROM result
)

SELECT
    "Pickup Location",
    total_bookings,
    driver_cancellation,
    customer_cancellation,
    driver_cancellation_rate,
    customer_cancellation_rate,
    driver_cancellation_rate + customer_cancellation_rate AS combined_cancellation_rate,
    avg_driver_rate,
    avg_customer_rate

FROM benchmarked

WHERE driver_cancellation_rate > avg_driver_rate
  AND customer_cancellation_rate > avg_customer_rate

ORDER BY driver_cancellation_rate DESC;

select "Pickup Location",
       total_bookings,
       driver_cancellation,
       customer_cancellation,
       customer_cancellation + driver_cancellation as total_cancelled,
       (customer_cancellation + driver_cancellation) * 100.0 / total_bookings as overall_cancellation_rate
from(
    select "Pickup Location",
            count(*) as total_bookings,
            count(
               case when "Cancelled Rides by Driver" is not NULL
               then 1
            end) as driver_cancellation,
            count(
               case when "Cancelled Rides by Customer" is not NULL
               then 1 
            end) as customer_cancellation
    from bookings
    group by "Pickup Location"
    having total_bookings >= 500
)
order by overall_cancellation_rate desc;

WITH result AS (
    SELECT
        "Pickup Location",
        total_bookings,
        completed_rides,
        driver_cancellation,
        customer_cancellation,

        driver_cancellation + customer_cancellation
            AS total_cancelled,

        (driver_cancellation + customer_cancellation)
            * 100.0 / total_bookings
            AS overall_cancellation_rate,

        completed_rides * 100.0 / total_bookings
            AS completion_rate

    FROM (
        SELECT
            "Pickup Location",
            COUNT(*) AS total_bookings,

            COUNT(
                CASE
                    WHEN "Booking Status" = 'Completed'
                    THEN 1
                END
            ) AS completed_rides,

            COUNT(
                CASE
                    WHEN "Cancelled Rides by Driver" IS NOT NULL
                    THEN 1
                END
            ) AS driver_cancellation,

            COUNT(
                CASE
                    WHEN "Cancelled Rides by Customer" IS NOT NULL
                    THEN 1
                END
            ) AS customer_cancellation

        FROM bookings
        GROUP BY "Pickup Location"
        HAVING COUNT(*) >= 500
    )
),

benchmarked AS (
    SELECT *,
           AVG(overall_cancellation_rate) OVER ()
               AS avg_overall_cancellation_rate,

           AVG(completion_rate) OVER ()
               AS avg_completion_rate
    FROM result
)

SELECT
    "Pickup Location",
    total_bookings,
    completed_rides,
    total_cancelled,
    overall_cancellation_rate,
    completion_rate,
    avg_overall_cancellation_rate,
    avg_completion_rate

FROM benchmarked

WHERE overall_cancellation_rate > avg_overall_cancellation_rate
  AND completion_rate < avg_completion_rate

ORDER BY overall_cancellation_rate DESC;

SELECT
    "Vehicle Type",

    COUNT(*) AS total_bookings,

    COUNT(
        CASE
            WHEN "Booking Status" = 'Completed'
            THEN 1
        END
    ) AS completed_rides,

    COUNT(
        CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END
    ) AS driver_cancellation,

    COUNT(
        CASE
            WHEN "Cancelled Rides by Customer" IS NOT NULL
            THEN 1
        END
    ) AS customer_cancellation,

    COUNT(
        CASE
            WHEN "Booking Status" = 'No Driver Found'
            THEN 1
        END
    ) AS no_driver_found,

    COUNT(
        CASE
            WHEN "Booking Status" = 'Incomplete'
            THEN 1
        END
    ) AS incomplete_rides,

    COUNT(*) -
    COUNT(
        CASE
            WHEN "Booking Status" = 'Completed'
            THEN 1
        END
    ) AS non_completed_rides,

    (
        COUNT(*) -
        COUNT(
            CASE
                WHEN "Booking Status" = 'Completed'
                THEN 1
            END
        )
    ) * 100.0 / COUNT(*) AS non_completion_rate

FROM bookings

GROUP BY "Vehicle Type"

ORDER BY non_completion_rate DESC;

SELECT
    "Vehicle Type",
    total_bookings,
    non_completed_rides,

    driver_cancellation * 100.0 / non_completed_rides
        AS driver_cancel_pct,

    customer_cancellation * 100.0 / non_completed_rides
        AS customer_cancel_pct,

    no_driver_found * 100.0 / non_completed_rides
        AS no_driver_found_pct,

    incomplete_rides * 100.0 / non_completed_rides
        AS incomplete_pct

FROM (
    SELECT
        "Vehicle Type",

        COUNT(*) AS total_bookings,

        COUNT(*) -
        COUNT(CASE
            WHEN "Booking Status" = 'Completed'
            THEN 1
        END) AS non_completed_rides,

        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) AS driver_cancellation,

        COUNT(CASE
            WHEN "Cancelled Rides by Customer" IS NOT NULL
            THEN 1
        END) AS customer_cancellation,

        COUNT(CASE
            WHEN "Booking Status" = 'No Driver Found'
            THEN 1
        END) AS no_driver_found,

        COUNT(CASE
            WHEN "Booking Status" = 'Incomplete'
            THEN 1
        END) AS incomplete_rides

    FROM bookings
    GROUP BY "Vehicle Type"
)
ORDER BY driver_cancel_pct DESC;

SELECT
    "Vehicle Type",
    "Driver Cancellation Reason",
    COUNT(*) AS driver_cancellations,

    COUNT(*) * 100.0 /
    SUM(COUNT(*)) OVER (PARTITION BY "Vehicle Type")
    AS reason_pct

FROM bookings

WHERE "Cancelled Rides by Driver" IS NOT NULL

GROUP BY
    "Vehicle Type",
    "Driver Cancellation Reason"

ORDER BY
    "Vehicle Type",
    reason_pct DESC;

SELECT
    "Vehicle Type",
    "Driver Cancellation Reason",
    COUNT(*) AS driver_cancellations,

    COUNT(*) * 100.0 /
    SUM(COUNT(*)) OVER (
        PARTITION BY "Vehicle Type"
    ) AS reason_pct

FROM bookings

WHERE "Cancelled Rides by Driver" IS NOT NULL

GROUP BY
    "Vehicle Type",
    "Driver Cancellation Reason"

ORDER BY
    "Vehicle Type",
    reason_pct DESC;

SELECT
    "Pickup Location",
    "Vehicle Type",
    total_bookings,
    completed_rides,
    driver_cancellation,

    driver_cancellation * 100.0 / total_bookings
        AS driver_cancellation_rate,

    completed_rides * 100.0 / total_bookings
        AS completion_rate

FROM (
    SELECT
        "Pickup Location",
        "Vehicle Type",

        COUNT(*) AS total_bookings,

        COUNT(CASE
            WHEN "Booking Status" = 'Completed'
            THEN 1
        END) AS completed_rides,

        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) AS driver_cancellation

    FROM bookings

    GROUP BY
        "Pickup Location",
        "Vehicle Type"

    HAVING COUNT(*) >= 100
)

ORDER BY driver_cancellation_rate DESC;

WITH location_vehicle AS (
    SELECT
        "Pickup Location",
        "Vehicle Type",
        COUNT(*) AS total_bookings,
        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) AS driver_cancellation
    FROM bookings
    GROUP BY
        "Pickup Location",
        "Vehicle Type"
    HAVING COUNT(*) >= 100
),

vehicle_average AS (
    SELECT
        "Vehicle Type",
        SUM(driver_cancellation) * 100.0 /
        SUM(total_bookings) AS overall_driver_rate
    FROM location_vehicle
    GROUP BY "Vehicle Type"
)

SELECT
    lv."Vehicle Type",
    lv."Pickup Location",
    lv.total_bookings,
    lv.driver_cancellation,
    lv.driver_cancellation * 100.0 /
        lv.total_bookings AS location_driver_rate,
    va.overall_driver_rate,

    (lv.driver_cancellation * 100.0 / lv.total_bookings)
        - va.overall_driver_rate AS difference_from_vehicle_avg

FROM location_vehicle lv
JOIN vehicle_average va
    ON lv."Vehicle Type" = va."Vehicle Type"

ORDER BY
    lv."Vehicle Type",
    location_driver_rate DESC;

WITH location_vehicle AS (
    SELECT
        "Pickup Location",
        "Vehicle Type",
        COUNT(*) AS total_bookings,
        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) AS driver_cancellation
    FROM bookings
    GROUP BY
        "Pickup Location",
        "Vehicle Type"
    HAVING COUNT(*) >= 100
),

vehicle_average AS (
    SELECT
        "Vehicle Type",
        SUM(driver_cancellation) * 100.0 /
        SUM(total_bookings) AS overall_driver_rate
    FROM location_vehicle
    GROUP BY "Vehicle Type"
),

ranked AS (
    SELECT
        lv."Vehicle Type",
        lv."Pickup Location",
        lv.total_bookings,
        lv.driver_cancellation,

        lv.driver_cancellation * 100.0 /
        lv.total_bookings AS location_driver_rate,

        va.overall_driver_rate,

        (lv.driver_cancellation * 100.0 / lv.total_bookings)
        - va.overall_driver_rate AS difference_from_vehicle_avg,

        ROW_NUMBER() OVER (
            PARTITION BY lv."Vehicle Type"
            ORDER BY
                lv.driver_cancellation * 1.0 /
                lv.total_bookings DESC
        ) AS rank_no

    FROM location_vehicle lv

    JOIN vehicle_average va
        ON lv."Vehicle Type" = va."Vehicle Type"
)

SELECT
    "Vehicle Type",
    "Pickup Location",
    total_bookings,
    driver_cancellation,
    location_driver_rate,
    overall_driver_rate,
    difference_from_vehicle_avg

FROM ranked

WHERE rank_no = 1

ORDER BY difference_from_vehicle_avg DESC;


SELECT
    "Pickup Location",
    "Vehicle Type",
    total_bookings,
    completed_rides,
    driver_cancellation,

    driver_cancellation * 100.0 / total_bookings
        AS driver_cancellation_rate

FROM (
    SELECT
        "Pickup Location",
        "Vehicle Type",

        COUNT(*) AS total_bookings,

        COUNT(CASE
            WHEN "Booking Status" = 'Completed'
            THEN 1
        END) AS completed_rides,

        COUNT(CASE
            WHEN "Cancelled Rides by Driver" IS NOT NULL
            THEN 1
        END) AS driver_cancellation

    FROM bookings

    GROUP BY
        "Pickup Location",
        "Vehicle Type"

    HAVING COUNT(*) >= 100
)

ORDER BY
    driver_cancellation DESC,
    driver_cancellation_rate DESC
LIMIT 15;


SELECT
    "Pickup Location",

    COUNT(*) AS total_bookings,

    COUNT(CASE
        WHEN "Booking Status" = 'Completed' THEN 1
    END) AS completed_rides,

    COUNT(CASE
        WHEN "Booking Status" = 'Completed' THEN 1
    END) * 100.0 / COUNT(*) AS completion_rate,

    COUNT(CASE
        WHEN "Booking Status" = 'Cancelled by Driver' THEN 1
    END) AS driver_cancellation,

    COUNT(CASE
        WHEN "Booking Status" = 'Cancelled by Customer' THEN 1
    END) AS customer_cancellation,

    COUNT(CASE
        WHEN "Booking Status" = 'No Driver Found' THEN 1
    END) AS no_driver_found,

    COUNT(CASE
        WHEN "Booking Status" = 'Incomplete' THEN 1
    END) AS incomplete_rides,

    COUNT(CASE
        WHEN "Booking Status" != 'Completed' THEN 1
    END) AS non_completed_rides,

    (
        COUNT(CASE
            WHEN "Booking Status" = 'Cancelled by Driver' THEN 1
        END)
        +
        COUNT(CASE
            WHEN "Booking Status" = 'Cancelled by Customer' THEN 1
        END)
    ) * 100.0 / COUNT(*) AS overall_cancellation_rate

FROM bookings

GROUP BY "Pickup Location"

HAVING COUNT(*) >= 500

ORDER BY total_bookings DESC;

WITH location_metrics AS (
    SELECT
        "Pickup Location",

        COUNT(*) AS total_bookings,

        COUNT(CASE
            WHEN "Booking Status" = 'Completed' THEN 1
        END) * 100.0 / COUNT(*) AS completion_rate,

        (
            COUNT(CASE
                WHEN "Booking Status" = 'Cancelled by Driver' THEN 1
            END)
            +
            COUNT(CASE
                WHEN "Booking Status" = 'Cancelled by Customer' THEN 1
            END)
        ) * 100.0 / COUNT(*) AS overall_cancellation_rate

    FROM bookings

    GROUP BY "Pickup Location"

    HAVING COUNT(*) >= 500
),

benchmarked AS (
    SELECT
        *,
        AVG(overall_cancellation_rate) OVER ()
            AS avg_overall_cancellation_rate,

        AVG(completion_rate) OVER ()
            AS avg_completion_rate

    FROM location_metrics
)

SELECT *
FROM benchmarked
WHERE overall_cancellation_rate > avg_overall_cancellation_rate
  AND completion_rate < avg_completion_rate
ORDER BY overall_cancellation_rate DESC;

SELECT
    "Pickup Location",
    "Vehicle Type",
    COUNT(*) AS total_bookings,

    COUNT(CASE
        WHEN "Booking Status" = 'Completed'
        THEN 1
    END) AS completed_rides,

    COUNT(CASE
        WHEN "Booking Status" = 'Cancelled by Driver'
        THEN 1
    END) AS driver_cancellation,

    COUNT(CASE
        WHEN "Booking Status" = 'Cancelled by Driver'
        THEN 1
    END) * 100.0 / COUNT(*) AS driver_cancellation_rate,

    COUNT(CASE
        WHEN "Booking Status" = 'Completed'
        THEN 1
    END) * 100.0 / COUNT(*) AS completion_rate

FROM bookings

WHERE "Pickup Location" IN (
    'Vinobapuri',
    'Akshardham',
    'Munirka'
)

GROUP BY
    "Pickup Location",
    "Vehicle Type"

HAVING COUNT(*) >= 50

ORDER BY
    "Pickup Location",
    driver_cancellation_rate DESC;

    SELECT
    "Pickup Location",
    "Vehicle Type",
    "Driver Cancellation Reason",
    COUNT(*) AS driver_cancellations,

    COUNT(*) * 100.0 /
    SUM(COUNT(*)) OVER (
        PARTITION BY "Pickup Location", "Vehicle Type"
    ) AS reason_percentage

FROM bookings

WHERE "Booking Status" = 'Cancelled by Driver'
  AND (
        ("Pickup Location" = 'Akshardham' AND "Vehicle Type" = 'eBike')
        OR
        ("Pickup Location" = 'Vinobapuri' AND "Vehicle Type" = 'Go Sedan')
        OR
        ("Pickup Location" = 'Munirka' AND "Vehicle Type" = 'Go Sedan')
      )

GROUP BY
    "Pickup Location",
    "Vehicle Type",
    "Driver Cancellation Reason"

ORDER BY
    "Pickup Location",
    "Vehicle Type",
    driver_cancellations DESC;

SELECT
    "Pickup Location",
    "Vehicle Type",
    strftime('%H', "Time") AS hour,
    COUNT(*) AS driver_cancellations

FROM bookings

WHERE "Booking Status" = 'Cancelled by Driver'
  AND (
        ("Pickup Location" = 'Akshardham' AND "Vehicle Type" = 'eBike')
        OR
        ("Pickup Location" = 'Vinobapuri' AND "Vehicle Type" = 'Go Sedan')
        OR
        ("Pickup Location" = 'Munirka' AND "Vehicle Type" = 'Go Sedan')
      )

GROUP BY
    "Pickup Location",
    "Vehicle Type",
    hour

ORDER BY
    "Pickup Location",
    "Vehicle Type",
    driver_cancellations DESC;
-- Let's start by introducing the tables.


-- order_info table
SELECT 
  *
FROM 
  `case-studies-405816.Pizza_info.order_info` 


-- order_dates table
SELECT 
  *
FROM 
  `case-studies-405816.Pizza_info.order_dates` 


-- pizza_prices table
SELECT 
  *
FROM 
  `case-studies-405816.Pizza_info.pizza_prices` 

 
-- pizza_types table
SELECT
  *
FROM 
  `case-studies-405816.Pizza_info.pizza_types` 


 
-- 1. Find the total quantity of each pizza ordered.

SELECT
  pizza_id,
  SUM(quantity) AS total_quantity
FROM
  `case-studies-405816.Pizza_info.order_info`
GROUP BY
  pizza_id

 

-- 2. Which type of pizza (pizza_id) was ordered on 2015.12.31?

SELECT
  DISTINCT(oi.pizza_id)
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.order_dates` od ON oi.order_id = od.order_id
WHERE
  od.date = '2015-12-31';



-- 3. What was the most popular pizza type?

SELECT
  pp.pizza_type_id,
  SUM(oi.quantity) as TotalQuantity
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.pizza_prices` pp ON oi.Pizza_id = pp.Pizza_id
GROUP BY
  pp.pizza_type_id
ORDER BY
  TotalQuantity DESC
LIMIT 1;



-- 4. What was the most popular pizza_id in December?

SELECT
  oi.pizza_id,
  COUNT(oi.quantity) as OrderCount
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.order_dates` od ON oi.order_id = od.order_id
WHERE
  EXTRACT(MONTH FROM od.date) = 12
GROUP BY
  oi.pizza_id
ORDER BY
  OrderCount DESC
LIMIT 1;



-- 5. Find the total revenue for each month.

SELECT
  EXTRACT(MONTH FROM od.date) as Month,
  SUM(oi.quantity*op.price) as TotalIncome
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.order_dates` AS od ON oi.order_id = od.order_id
JOIN
  `case-studies-405816.Pizza_info.pizza_prices` AS op ON oi.pizza_id = op.pizza_id
GROUP BY
  Month;



-- 6. Find the most purchased pizza_id for each day with its quantity.

WITH rank_table AS (
  SELECT 
    od.date,
    oi.pizza_id,
    SUM(quantity) AS order_count,
    Dense_rank() OVER (PARTITION BY od.date ORDER BY SUM(quantity) DESC) AS dr
  FROM `case-studies-405816.Pizza_info.order_info` AS oi
  JOIN
    `case-studies-405816.Pizza_info.order_dates` AS od ON oi.order_id = od.order_id
  GROUP BY
    od.date,
    oi.pizza_id
)
SELECT 
  r.date,
  r.pizza_id,
  r.order_count
FROM 
  rank_table r
WHERE 
  r.dr = 1
ORDER BY
  r.date ASC


 
-- 7. Which part of the day had the highest order volume?

WITH ToD_table AS (
  SELECT 
  order_id,
  CASE
    WHEN time BETWEEN "12:00:00" AND "17:59:59" THEN "Afternoon"
    WHEN time BETWEEN "18:00:00" AND "23:59:59" THEN "Night"
    ELSE "Morning"
  END AS `Time_of_day`
  FROM 
    `case-studies-405816.Pizza_info.order_dates` AS od
)
SELECT 
  tod.Time_of_day,
  SUM(oi.quantity) as OrderCount
FROM 
  ToD_table AS tod
JOIN 
  `case-studies-405816.Pizza_info.order_info` AS oi ON oi.order_id = tod.order_id
GROUP BY
  tod.Time_of_day
ORDER BY
  OrderCount DESC
LIMIT 1;



 -- 8. Find the total revenue for each pizza category.

SELECT
  pt.category,
  SUM(pp.price*oi.quantity) AS TotalRevenue
FROM
  `case-studies-405816.Pizza_info.pizza_prices` AS pp
JOIN
  `case-studies-405816.Pizza_info.order_info` AS oi ON oi.pizza_id = pp.pizza_id
JOIN
  `case-studies-405816.Pizza_info.pizza_types` AS pt ON pp.pizza_type_id = pt.pizza_type_id
GROUP BY
  pt.category
 

 
-- 9. Find the total revenue for XL pizza size.

SELECT
  pp.size,
  SUM(pp.price*oi.quantity) AS TotalRevenue
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.pizza_prices` AS pp ON oi.pizza_id = pp.pizza_id
WHERE 
  size = "XL"
GROUP BY
  pp.size


 
-- 10. Find the total pizza count for each pizza size.

SELECT
  pp.size,
  SUM(oi.quantity) as OrderCount
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.pizza_prices` AS pp ON oi.pizza_id = pp.pizza_id
GROUP BY
  pp.size
ORDER BY
  OrderCount DESC












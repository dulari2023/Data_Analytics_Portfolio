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



-- 3. What is the most popular pizza type?

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



-- 4. What is the most popular pizza_id in December?

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



-- 6. Find the total revenue for each pizza category.

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


 
-- 7. Find the order count during the busiest hour in the dataset.

SELECT
  EXTRACT(HOUR FROM od.time) as Hour,
  SUM(oi.quantity) as OrderCount,
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.order_dates` AS od ON oi.order_id = od.order_id
GROUP BY
  Hour
ORDER BY
  OrderCount DESC
LIMIT 1;



--8. How much pizza was ordered each day?

SELECT
  EXTRACT(MONTH FROM od.date) as Month,
  EXTRACT(DAY FROM od.date) as Day,
  SUM(oi.quantity) as OrderCount,
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.order_dates` AS od ON oi.order_id = od.order_id
GROUP BY
  Month,
  Day
ORDER BY
  Month,
  Day ASC

 

-- 9. Find the total revenue for each pizza size.

SELECT
  pp.size,
  SUM(pp.price*oi.quantity) AS TotalRevenue
FROM
  `case-studies-405816.Pizza_info.order_info` AS oi
JOIN
  `case-studies-405816.Pizza_info.pizza_prices` AS pp ON oi.pizza_id = pp.pizza_id
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












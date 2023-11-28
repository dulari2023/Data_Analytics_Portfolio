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


-- order_dates table
SELECT 
  *
FROM 
  `case-studies-405816.Pizza_info.pizza_prices` 


-- order_dates table
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
 DISTINCT(pi.pizza_id)
FROM
 `case-studies-405816.Pizza_info.order_info` AS pi
JOIN
 `case-studies-405816.Pizza_info.order_dates` od ON pi.order_id = od.order_id
WHERE
 od.date = '2015-12-31';


-- 3. What is the most popular pizza type?









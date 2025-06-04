-- Let's start by introducing the table.

SELECT 
   *
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 


-- 1.   Who are the top 5 billionaires in the dataset by net worth?

SELECT 
   FULL_NAME,
   NET_WORTH__BILLIONS_
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 
ORDER BY 
   NET_WORTH__BILLIONS_ DESC
LIMIT 5;


-- 2.   Who are the top 5 billionaires between the ages of 40 and 50 with the highest net worth?

SELECT 
   FULL_NAME,
   AGE,
   NET_WORTH__BILLIONS_
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 
WHERE 
   AGE BETWEEN 40 AND 50
ORDER BY 
   NET_WORTH__BILLIONS_ DESC
LIMIT 5;


-- 3.   How many billionaires in the dataset are from each country?

SELECT 
   COUNTRY_OF_RESIDENCE,
   COUNT(*) AS count
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 
GROUP BY 
   COUNTRY_OF_RESIDENCE;


-- 4.   How many billionaires in the dataset are from the United States?

SELECT 
   COUNT(*) AS count
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 
WHERE 
   COUNTRY_OF_RESIDENCE = "United States";


-- 5.   What is the total net worth of billionaires in each country?

SELECT 
   COUNTRY_OF_RESIDENCE,
   SUM(NET_WORTH__BILLIONS_) AS Total_net_worth
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 
GROUP BY 
   COUNTRY_OF_RESIDENCE;


-- 6.   What are the top sources of income among the billionaires in the dataset?

SELECT 
   SOURCE_OF_INCOME,
   COUNT(*) AS count
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 
GROUP BY 
   SOURCE_OF_INCOME
ORDER BY 
   count DESC

-- 7.   What is the dataset's average net worth(billions) of the billionaires?

SELECT 
   AVG(NET_WORTH__BILLIONS_) AS average_net_worth
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 


-- 8.   How many billionaires in the dataset are above the average net worth?

SELECT 
   COUNT(*) AS number_of_billionaires_above_average
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 
WHERE 
   NET_WORTH__BILLIONS_ > (SELECT AVG(NET_WORTH__BILLIONS_) FROM `case-studies-405816.Top_100_billionaires.Billionaires_info`)


-- 9.   How many billionaires in the dataset are over the age of 60?

SELECT 
   COUNT(*) AS number_of_billionaires_above_60
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 
WHERE 
   AGE > 60;


-- 10.   What are the youngest and oldest ages of the billionaires in the dataset?

--Youngest
SELECT 
   MIN(AGE) AS younguest_age,
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 

--Oldest
SELECT 
   MAX(AGE) AS oldest_age,
FROM 
   `case-studies-405816.Top_100_billionaires.Billionaires_info` 

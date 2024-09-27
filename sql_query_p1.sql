-- SQL Reatial Sales Analysis - P1
create database sql_project_p2;

-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id	INT PRIMARY KEY,
				sale_date	DATE,
				sale_time	TIME,
				customer_id	INT,
				gender	VARCHAR(15),
				age	INT,
				category VARCHAR(15),
				quantiy	INT,
				price_per_unit	FLOAT,
				cogs	FLOAT,
				total_sale FLOAT
			);


select * from retail_sales
limit 10;

select count(*) from retail_sales;


-- 
select * from retail_sales
where transactions_id is null;

select * from retail_sales
where sale_date is null;

select * from retail_sales
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or 
	total_sale is null;


--
delete from retail_sales
where transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or 
	total_sale is null;


-- Data Exploration

-- How many sales we have?
select count(*) as total_sale from retail_sales;

-- How many unique customers we have?
select count(distinct customer_id) as total_sale from retail_sales;

select distinct category from retail_sales


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantiy >= 4

-- Q.3. Write a SQL query to calculate the total sales (total_sale) for each category:
SELECT category, 
	   SUM(total_sale) as net_sale, 
	   COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Q.4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
SELECT ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5. Write a SQL query to find all transactions where the total_sale is greater than 1000:
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category,
	   gender,
	   COUNT(*) as total_trans
FROM retail_sales
GROUP BY category,
		 gender
ORDER BY category,
		 gender;

-- Q.7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year,
	   month as best_selling_month,
	   avg_sale
FROM 
(
SELECT EXTRACT(YEAR FROM sale_date) as year,
	   EXTRACT(MONTH FROM sale_date) as month,
	   AVG(total_sale) as avg_sale,
	   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY EXTRACT(YEAR FROM sale_date),
	     EXTRACT(MONTH FROM sale_date)
) as t1
WHERE rank = 1;

-- Q.8. Write a SQL query to find the top 5 customers based on the highest total sales:
SELECT customer_id,
	   SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;

-- Q.9. Write a SQL query to find the number of unique customers who purchased items from each category:
SELECT category, 
	   COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY category

-- Q.10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT
	   CASE WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	   ELSE 'Evening' END as shift,
	   COUNT(*) as total_orders
FROM retail_sales
GROUP BY CASE WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	     WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	     ELSE 'Evening' END;

-- END of project










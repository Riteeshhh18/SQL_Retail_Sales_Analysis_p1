-- create TABLE

CREATE TABLE retail_sales_tb
(
 transactions_id INT PRIMARY KEY,
 sale_date	DATE,
 sale_time	TIME,
 customer_id	INT,
 gender	VARCHAR(15),
 age	INT,
 category	VARCHAR(25),
 quantiy	INT,
 price_per_unit	FLOAT,
 cogs	FLOAT,
 total_sale FLOAT
)

-- Data Cleaning

select * from retail_sales_tb
where
     transactions_id is null 
	 or
	 sale_date is null 
	 or 
	 sale_time is null 
	 or 
	 customer_id is null 
	 or 
	 gender is null 
	 or
	 age is null
	 or 
	 category is null
	 or 
	 quantiy is null
	 or 
	 price_per_unit is null 
	 or 
	 cogs is null 
	 or
	 total_sale is null;
	 
	 
select count(*) from retail_sales_tb 

-- Data Exporation

-- How many sales we have?

select count(*) as Total_sales from retail_sales_tb

-- How many unique customer we have?

select count( DISTINCT customer_id) from retail_sales_tb

-- How many Category we have?
select DISTINCT category from retail_sales_tb


-- Data Analysis & Business key problems and answers

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales_tb
where sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * 
from retail_sales_tb
where 
category = 'Clothing' and quantiy >= 4 
and
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
Select category, SUM(total_sale) as net_sales,
COUNT (*) as total_orders
from retail_sales_tb
Group by category

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
Select ROUND(AVG(age),2) as Average_Age , category from retail_sales_tb
WHERE category = 'Beauty'
GROUP BY category

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales_tb
where total_sale > 1000

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select category, gender, COUNT(*) as total_trans from retail_sales_tb
group by category, gender
order by 1

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales_tb
GROUP BY 1, 2
) as t1
WHERE rank = 1

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
customer_id , SUM(total_sale) AS Total_sales from retail_sales_tb 
GROUP BY customer_id
ORDER BY 2 DESC
limit 5 

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
category, count (DISTINCT customer_id) as Unique_customer from retail_sales_tb
group by category

--Q.10 Which age group has the highest total spending?
SELECT age, SUM(total_sale) as total_spending from retail_sales_tb
Group by age 
order by 2 DESC
Limit 1 







	 
	 

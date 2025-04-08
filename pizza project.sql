CREATE TABLE Pizza_Dash (
    pizza_id INT,
    order_id INT,
    pizza_name_id TEXT,
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price NUMERIC,
    total_price NUMERIC,
    pizza_size TEXT,
    pizza_category TEXT,
    pizza_ingredients TEXT,
    pizza_name TEXT
);

SET datestyle = 'ISO, DMY';

COPY Pizza_Dash FROM 'C:/Program Files/PostgreSQL/16/data/Data_copy/pizza_sales.csv'
DELIMITER ',' CSV HEADER;





select * from pizza_dash



-- Total Revenue 

select sum (total_price) as Total_revenue from pizza_dash;


-- Average Order Value

select (sum(total_price)/count(distinct order_id)) as Average_Value from pizza_dash


-- Total Pizza Sold

select sum(quantity) as pizza_Sold from pizza_dash;

-- Total Orders

select count(distinct order_id) as Total_Orders from pizza_dash;


-- Average Pizza Per Order

select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id)as decimal (10,2)) as decimal(10,2)) as Average_pizza_perorder from pizza_dash


-- B. Daily Trends For Total Orders

SELECT 
  TO_CHAR(order_date, 'Day') AS order_day,
  COUNT(DISTINCT order_id) AS total_orders
FROM pizza_dash
GROUP BY TO_CHAR(order_date, 'Day');


-- C. Monthly Trends For Orders


SELECT 
  TO_CHAR(order_date, 'Month') AS order_month,
  COUNT(DISTINCT order_id) AS total_orders
FROM pizza_dash
GROUP BY TO_CHAR(order_date, 'Month');


-- D. % of sales By Pizza Catetgory

select pizza_category , cast(sum(total_price)as decimal(10,2)) as Total_Revenue,
cast(sum(total_price)*100 / (select sum(total_price) from pizza_dash) as decimal (10,2)) from pizza_dash
group by pizza_category;


-- E. % Sales By Pizza Size

select pizza_size , cast(sum(total_price)as decimal(10,2)) as Total_Revenue,
cast(sum(total_price)*100 / (select sum(total_price) from pizza_dash) as decimal (10,2)) from pizza_dash
group by pizza_size;

-- F. Total Pizzas Sales By Pizza Category

select pizza_category, sum(quantity) as Total_Quantity_sold
from pizza_dash
group by pizza_category
order by Total_Quantity_sold desc;

-- G. Top 5 Pizzas By Revenue

select pizza_name , sum(total_price) as total_revenue
from pizza_dash
group by pizza_name
order by total_revenue desc limit 5;

-- H. Bottom 5 Pizzas By Revenue

select pizza_name , sum(total_price) as total_revenue
from pizza_dash
group by pizza_name
order by total_revenue asc limit 5;

--I. Top 5 Pizzas by Quantity

select pizza_name,sum(quantity) as total_revenue
from pizza_dash
group by pizza_name
order by total_revenue desc limit 5;

-- J Bottom 5 by Quantity

select pizza_name,sum(quantity) as total_revenue
from pizza_dash
group by pizza_name
order by total_revenue asc limit 5;

-- K Top 5 pizzas for total orders

select pizza_name,count(distinct order_id) as Total_orders
from pizza_dash
group by pizza_name
order by total_orders desc limit 5

-- L. Bottom 5 pizzas for sales

select pizza_name,count(distinct order_id) as Total_orders
from pizza_dash
group by pizza_name
order by total_orders asc limit 5;

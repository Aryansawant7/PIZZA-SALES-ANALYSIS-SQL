use pizzahut;

-- Retrive the total number of order placed

-- select count(order_id)as total_orders from orders;

---------------------------------------------------------------------------------------------------------------------

-- Calaculate the total revenue genrated by pizza sales

-- -- select round(sum(o.quantity*p.price),2) as Total_sales from order_details o join pizzas p on o.pizza_id=p.pizza_id;
---------------------------------------------------------------------------------------------------------------------- 

-- Identify the highest-priced pizza

-- select pt.name from pizza_types pt join pizzas p on pt.pizza_type_id=p.pizza_type_id order by price desc limit 0,1;

----------------------------------------------------------------------------------------------------------------------------- 

-- Identify the most common pizza size ordered

-- select p.size,count(order_id) as order_count from order_details o join pizzas p on o.pizza_id=p.pizza_id group by p.size 
-- order by order_count desc;

------------------------------------------------------------------------------------------------------------------------------ 

-- List the top 5 most ordered pizza types along with their quantaties

-- select p.name,sum(o.quantity) as qty from pizza_types p join pizzas pi on p.pizza_type_id=pi.pizza_type_id 	
-- join order_details o on pi.pizza_id=o.pizza_id group by p.name order by qty desc limit 0,5;


------------------------------------------------------------------------------------------------------------------------------ 

-- Join the necessary tables to find the total quantity of each pizza category ordered

-- select p.category,sum(o.quantity) as qty from pizza_types p join pizzas pi on p.pizza_type_id=pi.pizza_type_id 	
-- join order_details o on pi.pizza_id=o.pizza_id group by p.category order by  qty desc;

----------------------------------------------------------------------------------------------------------------------------- 

-- Determine the distributions of orders by hours of the day

-- select hour(order_time) as hours,count(order_id) as orders from orders group by hours;

---------------------------------------------------------------------------------------------------------------------------- 
-- Join relevant tables to find the category-wise distribution of pizzas

-- select category,count(name) from pizza_types group by category;

------------------------------------------------------------------------------------------------------------------------------- 

-- Group the orders by date and calculate the average number of pizzas ordered per day

-- SELECT 
--     ROUND(AVG(quantity), 0) AS avg_pizza_ordered_perday
-- FROM
--     (SELECT 
--         orders.order_date, SUM(order_details.quantity) AS quantity
--     FROM
--         orders
--     JOIN order_details ON orders.order_id = order_details.order_id
--     GROUP BY orders.order_date) AS order_quantity;

--------------------------------------------------------------------------------------------------------------------------- 

-- Determine the top 3 most ordered pizza types based on revenue

-- select pt.name as category,sum(p.price*o.quantity) as revenue from pizza_types pt join pizzas p on pt.pizza_type_id=p.pizza_type_id join order_details o 	
-- on p.pizza_id=o.pizza_id group by pt.name order by revenue desc limit 3;

-------------------------------------------------------------------------------------------------------------------------------- 

-- Calculate the percentage contribution of each pizza types to total revenue

-- select pt.category,round(sum(o.quantity*p.price) / (select round(sum(o.quantity*p.price),2) as total_sales
-- from
-- order_details o join pizzas p on p.pizza_id=o.pizza_id)*100,2) as revenue 
-- from pizza_types pt join pizzas p on pt.pizza_type_id=p.pizza_type_id
-- join order_details o
-- on o.pizza_id=p.pizza_id
-- group by pt.category order by revenue desc;

----------------------------------------------------------------------------------------------------------------------- 
-- Analyze the cumulative revenue genrated over time

-- select order_date,sum(revenue) over (order by order_date) as cum_revenue from
-- (SELECT 
--     orders.order_date,
--     SUM(order_details.quantity * pizzas.price) AS revenue
-- FROM
--     order_details
--         JOIN
--     pizzas ON order_details.pizza_id = pizzas.pizza_id
--         JOIN
--     orders ON orders.order_id = order_details.order_id
-- GROUP BY orders.order_date) as sales ;

------------------------------------------------------------------------------------------------------------------------- 

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category

-- select name,revenue from
-- (select category,name,revenue,rank() over(partition by category order by revenue desc) as rn 
-- from
-- (select pizza_types.category ,(pizza_types.names,sum((order_details.quantity)*pizzas.price)as revenue
-- from pizza_types join pizzas
-- on pizza_types.pizza_type_id=pizzas.pizza_type_id
-- join order_details
-- on order_details.pizza_id=pizzas.pizza_id
-- group by pizza_types.category,pizza_types.name)as a ) as b
-- where rn <= 3;




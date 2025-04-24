--1  Retrieve the total number of orders placed.
select count(order_id) as total_order from orders;
-- Total order is 21350


--2  Calculate the total revenue generated from pizza sales.
select 
sum(order_details.quantity*pizzas.price)as total_sales
from order_details join pizzas
on pizzas.pizza_id=order_details.pizza_id

--  total revenue is 817860.049999993



--3  Identify the highest-priced pizza.

select top(1) pizza_types.name,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id =pizzas.pizza_type_id
order by pizzas.price desc;

--the highest-priced pizza  (The Greek Pizza	35.95)



--4  Identify the most common pizza size ordered.

select pizzas.size,count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size
order by order_count desc ;

--the most common pizza size ordered is large L


--5   List the top 5 most ordered pizza types along with their quantities.

select top(5)pizza_types.name,
sum(order_details.quantity) as qn
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by qn desc ;


--6  Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category,
sum(order_details.quantity) as qn
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category
order by qn desc ;

--7  Determine the distribution of orders by hour of the day.

SELECT DATEPART(HOUR, time) AS hour, COUNT(order_id) AS order_c
FROM orders
GROUP BY DATEPART(HOUR, time);


--8   Join relevant tables to find the category-wise distribution of pizzas.

select category , count(name) from pizza_types
group by category;


--category	(No column name)
--Chicken	6
--Classic	8
--Supreme	9
--Veggie	9


--9  Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(quantity)from
(select orders.date,sum(order_details.quantity)as quantity
from orders join order_details
on orders.order_id=order_details.order_id
group by orders.date) as order_qua;


-- average number of pizzas ordered per day is 138


--10  Determine the top 3 most ordered pizza types based on revenue.
select top (3) pizza_types.name,
sum(order_details.quantity*pizzas.price )as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by revenue desc;

--name	                        revenue
--The Thai Chicken Pizza	    43434.25
--The Barbecue Chicken Pizza	42768
--The California Chicken Pizza	41409.5

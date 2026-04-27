create database E_commerce
use E_commerce

-- Q1 Retrieve all orders that occurred in 2023.

select *
from orders
where year (order_date) = 2023


-- Q2 Retrieve all orders with status = 'Delivered'.

select *
from orders
where order_status = 'Delivered'


-- Q3 Retrieve all customers who live in Cairo.

select *
from customers
where city = 'Cairo'

-- Q4 Retrieve all products with price greater than 5000.

select * 
from Products
where price > 5000


-- Q5 Retrieve all orders where the discount is greater than 10%.

select *
from orders
where discount > 10

-- Q6  Count the total number of orders.

select count(order_id) As Total_orders
from orders

-- Q7 Calculate the total quantity of products sold.

select sum(quantity) As Total_Quantity
from orders

-- Q8 Calculate the average product price.

select category , Avg(price) As Avg_price
from products
group by category


-- Q9 Count the number of orders for each order status (Delivered, Cancelled, Pending).

select order_status , count(order_id) AS order_count
from orders
group by order_status

-- Q10 Count the number of customers in each city.

select city,count(customer_id) AS count_customer
from customers
group by city

-- Q11 Retrieve each order along with the customer name who made it.

select  O.order_id , C.customer_name
from orders O
join customers C
on C.customer_id = O.customer_id


-- Q12 Retrieve each product along with the total quantity sold.

select P.product_name , sum(O.quantity) AS Total_quantity
from products P
join orders O
on O.product_id = P.product_id
group by product_name

-- Q13 Calculate total sales for each product (price × quantity × (1 - discount/100)). 


select P.product_name , sum(P.price * O.quantity * (1 - O.discount/100)) AS Total_Sales
from  orders O
join products P
on O.Product_id = P.Product_id
group by P.product_name

-- Q14 Find the top 5 customers based on total spending.

select C.customer_name , sum(P.price * O.quantity * (1 - O.discount/100)) AS Total_Spending
from products P
join orders O
on P.product_id = O.product_id
join customers C
on O.customer_id = C.customer_id
group by customer_name
order by Total_Spending desc
limit 5

--  Q15 Retrieve customers who made more than 3 orders.

select customer_id , count(order_id) AS Order_count
from orders
group by customer_id
having Order_count > 3

-- Q16 Find the total sales for each city.

select C.city , sum(P.price * O.quantity * (1 - O.discount/100)) AS Total_Sales
from orders O
join Customers C
on O.customer_id = c.customer_id
join products P
on O.product_id = P.product_id
group by C.city
order by C.city

-- Q17 Find the most sold product (by quantity).

select product_id , sum(quantity) As Total_Quantity
from orders
group by product_id
order by  Total_Quantity desc
limit 1

-- Q18  Calculate the total revenue generated for each payment method.

select O.payment_method , sum(P.price * O.quantity * (1 - O.discount/100)) AS Total_Revenue
from orders O
join products P
on O.product_id = P.product_id
group by O.payment_method
order by O.Payment_method


-- Q19 Find the monthly total sales trend.

select 
year(order_date) As Year , 
Month(order_date) As Month , 
sum(P.price * O.quantity * (1 - O.discount/100)) AS Total_Sales
from orders O
join products P
on O.product_id = P.product_id
group by Month , year
order by Month , year


-- Q20  Identify high-value customers who: made more than 3 orders and spent more than 20000.

select O.customer_id , count(O.order_id) AS Order_count ,sum(P.price * O.quantity * (1 - O.discount/100)) AS Total_Sales
from orders O
join products P
on O.product_id = P.product_id
group by customer_id
having count(O.order_id) > 3 and sum(P.price * O.quantity * (1 - O.discount/100)) > 20000 
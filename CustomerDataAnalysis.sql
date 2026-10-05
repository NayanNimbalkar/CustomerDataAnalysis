CREATE database CUSTOMER_DATA_ANALYSIS;
select * from agents;
select * from customer;
select * from orders;



#Q)1.	Retrieve customer details along with the agent's name who helped them, 
-- showing the total outstanding amount.
/*

*/
SELECT c.cust_name, o.ord_num, a.agent_name, sum( c.outstanding_amt) as Total_Outstanding_amount
FROM customer c
JOIN agents a
ON c.agent_code = a.agent_code
JOIN orders o
ON c.cust_code = o.cust_code
group by  c.cust_name,o.ord_num, a.agent_name;


#Q)2.	Find the agents whose total order amount exceeds 10,000.
select * from agents;
select * from orders;


select a.AGENT_NAME, sum(o.ORD_AMOUNT) as total_amount
from agents a
join orders o
on a.AGENT_CODE=o.AGENT_CODE
group by a.AGENT_NAME
having sum(ORD_AMOUNT)>10000;



#Q)3.	Create a view to list all orders along with customer names and their respective agent's names.

select * from orders;
select * from customer;
select * from agents;

CREATE VIEW  analysis as(
select o.*, c.cust_name,  a.agent_name
from orders o
join customer c
on o.CUST_CODE= c.CUST_CODE
join agents a
on o.AGENT_CODE=a.AGENT_CODE
);


select * from analysis;


#Q)4.	Find all orders placed by customers who reside in New York.
select * from orders;
select * from customer;
select * from agents;

select o.*, cust_name, cust_city
from customer c
join orders o
on c.CUST_CODE= o.CUST_CODE
where CUST_CITY='New York';

#Q)5.	Find the total number of orders handled by each agent.

select * from orders;
select * from customer;
select * from agents;

select a.agent_name, count(ord_num) as total_orders
from agents a
join orders o
on  a.AGENT_CODE=o.AGENT_CODE
group by a.AGENT_NAME;




#Q)6.	Get the list of customers who placed an order with an advance amount greater than or 
-- equal to 50% of the order amount.

SELECT c.CUST_NAME,o.ORD_NUM,o.ORD_AMOUNT, o.ADVANCE_AMOUNT
FROM customer c
JOIN orders o
ON c.CUST_CODE = o.CUST_CODE
WHERE o.ADVANCE_AMOUNT >= o.ORD_AMOUNT * 0.50;


#Q)7.	Find the number of customers in each city and the total outstanding amount for each city.

SELECT CUST_CITY,COUNT(CUST_CODE) AS total_customers, SUM(OUTSTANDING_AMT) AS total_outstanding_amount
FROM customer
GROUP BY CUST_CITY;


#Q)8.	List all customers along with their orders, including customers who have not placed any orders

SELECT c.CUST_NAME,o.ORD_NUM,o.ORD_AMOUNT,o.ORD_DATE
FROM customer c
LEFT JOIN orders o
ON c.CUST_CODE = o.CUST_CODE;

#Q)9.	Find the customer who placed the highest order amount using a subquery.

SELECT c.CUST_NAME, o.ORD_NUM, o.ORD_AMOUNT
FROM customer c
JOIN orders o
ON c.CUST_CODE = o.CUST_CODE
WHERE o.ORD_AMOUNT = (
    SELECT MAX(ORD_AMOUNT)
    FROM orders
);




#Q)10.	Find the total order amount for customers who have placed more than 2 orders using a subquery.

SELECT c.CUST_NAME, SUM(o.ORD_AMOUNT) AS total_order_amount
FROM customer c
JOIN orders o
ON c.CUST_CODE = o.CUST_CODE
WHERE c.CUST_CODE IN (
    SELECT CUST_CODE
    FROM orders
    GROUP BY CUST_CODE
    HAVING COUNT(ORD_NUM) > 2
)
GROUP BY c.CUST_CODE, c.CUST_NAME;

#Q)11.	List the orders placed in the month of May 2008

SELECT *
FROM orders
WHERE ORD_DATE >= '2008-05-01'
  AND ORD_DATE < '2008-06-01';

#Q)12.	List orders where the amount is greater than 1000 or the order date is before '2008-12-31'.

SELECT *
FROM orders
WHERE ORD_AMOUNT > 1000
   OR ORD_DATE < '2008-12-31';

#Q)13.	Find all orders placed by customers in 'New York' or whose order amount is greater than 5000.

SELECT o.*, c.CUST_NAME, c.CUST_CITY
FROM orders o
JOIN customer c
ON o.CUST_CODE = c.CUST_CODE
WHERE c.CUST_CITY = 'New York'
OR o.ORD_AMOUNT > 5000;

#Q)14.	Find the agents who have handled orders for more than 3 distinct customers.

SELECT a.AGENT_CODE, a.AGENT_NAME, COUNT(DISTINCT o.CUST_CODE) AS distinct_customers
FROM agents a
JOIN orders o
ON a.AGENT_CODE = o.AGENT_CODE
GROUP BY a.AGENT_CODE, a.AGENT_NAME
HAVING COUNT(DISTINCT o.CUST_CODE) >3;

#Q)15.	Find customers who have made at least one payment but still have an outstanding amount greater than 7000

SELECT CUST_NAME, OUTSTANDING_AMT, PAYMENT_AMT
FROM customer
WHERE PAYMENT_AMT > 0
  AND OUTSTANDING_AMT > 7000;
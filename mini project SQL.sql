create database ECommerce_Business;

use ECommerce_Business;

create table  customers 
(customer_id int primary key not null,
 name varchar (50),
city varchar(50),
signup_date date)
;

create table product (
product_id int primary key not null,
product_name varchar(50),
category varchar(50),
price decimal(10,2) 
);

create table orders(
order_id int primary key,
customer_id int,
order_date DATE,
total_amount decimal(10,2),
foreign key (customer_id) references customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),

    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Delhi', '2023-01-15'),
(2, 'Priya Singh', 'Mumbai', '2023-02-10'),
(3, 'Amit Verma', 'Bangalore', '2023-03-05'),
(4, 'Sneha Patel', 'Ahmedabad', '2023-04-12'),
(5, 'Vikram Rao', 'Chennai', '2023-05-20'),
(6, 'Neha Kapoor', 'Delhi', '2023-06-18'),
(7, 'Arjun Mehta', 'Pune', '2023-07-22'),
(8, 'Kavita Joshi', 'Mumbai', '2023-08-30'),
(9, 'Rohan Das', 'Kolkata', '2023-09-14'),
(10, 'Anjali Nair', 'Hyderabad', '2023-10-01');

select * from customers;

INSERT INTO product VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Smartphone', 'Electronics', 25000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Mouse', 'Accessories', 800),
(106, 'Office Chair', 'Furniture', 7000),
(107, 'Desk', 'Furniture', 12000),
(108, 'Monitor', 'Electronics', 15000),
(109, 'Tablet', 'Electronics', 18000),
(110, 'Printer', 'Electronics', 10000);

select * from product;

INSERT INTO orders VALUES
(1001, 1, '2023-11-01', 65000),
(1002, 2, '2023-11-03', 25000),
(1003, 3, '2023-11-05', 2200),
(1004, 4, '2023-11-07', 1500),
(1005, 5, '2023-11-08', 8000),
(1006, 6, '2023-11-09', 60000),
(1007, 7, '2023-11-10', 15000),
(1008, 8, '2023-11-12', 18000),
(1009, 9, '2023-11-15', 10000),
(1010, 10, '2023-11-18', 25000),
(1011, 1, '2023-11-20', 2000),
(1012, 2, '2023-11-22', 12000),
(1013, 3, '2023-11-25', 7000),
(1014, 4, '2023-11-27', 800),
(1015, 5, '2023-11-30', 60000);

select * from orders;

INSERT INTO order_items VALUES
(1, 1001, 101, 1, 60000),
(2, 1001, 103, 2, 2000),
(3, 1002, 102, 1, 25000),
(4, 1003, 103, 1, 2000),
(5, 1003, 105, 1, 200),
(6, 1004, 104, 1, 1500),
(7, 1005, 106, 1, 7000),
(8, 1005, 105, 1, 1000),
(9, 1006, 101, 1, 60000),
(10, 1007, 108, 1, 15000),
(11, 1008, 109, 1, 18000),
(12, 1009, 110, 1, 10000),
(13, 1010, 102, 1, 25000),
(14, 1011, 103, 1, 2000),
(15, 1012, 107, 1, 12000),
(16, 1013, 106, 1, 7000),
(17, 1014, 105, 1, 800),
(18, 1015, 101, 1, 60000),
(19, 1015, 104, 1, 1500),
(20, 1015, 105, 1, 800);

select * from order_items;

select sum(total_amount) as revenue from orders;

select customer_id, sum(total_amount) as total_spent
from orders
group by customer_id;

select product_id, sum(quantity) as total_quantity
from order_items
group by product_id
order by total_quantity desc;

select p.product_name, sum(oi.quantity) as total_quantity
from product p
 join order_items oi on p.product_id = oi.product_id 
 group by product_name order by
 total_quantity ;
 
 select c.city, sum(o.total_amount) as total_revenue
 from customers c 
 join orders o 
 on c.customer_id= o.customer_id 
 group by c.city having sum(o.total_amount) > 50000;
 
 SELECT 
    c.customer_id,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 2;
 
 SELECT 
    c.customer_id, 
    COUNT(o.order_id) AS total_orders, 
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 3;
 
 SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 3;


SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN product p 
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN product p 
    ON p.product_id = oi.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_quantity_sold DESC
LIMIT 1;

SELECT 
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN product p 
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC;

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
 COUNT(order_id) AS total_orders, 
 SUM(total_amount) AS total_revenue 
 FROM orders 
 GROUP BY DATE_FORMAT(order_date, '%Y-%m') 
 ORDER BY total_revenue desc limit 1;
 
 SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
HAVING SUM(total_amount) > (
    SELECT AVG(monthly_revenue)
    FROM (
        SELECT SUM(total_amount) AS monthly_revenue
        FROM orders
        GROUP BY DATE_FORMAT(order_date, '%Y-%m')
    ) AS monthly_data
);

SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent,
    CASE 
        WHEN SUM(o.total_amount) > 5000 THEN 'High Value'
        WHEN SUM(o.total_amount) > 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_category
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.name;
    
    SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent,
    CASE 
        WHEN SUM(o.total_amount) > 5000 THEN 'High Value'
        WHEN SUM(o.total_amount) > 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_category
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.name
ORDER BY 
    CASE 
        WHEN SUM(o.total_amount) > 5000 THEN 1
        WHEN SUM(o.total_amount) > 2000 THEN 2
        ELSE 3
    END;
    
    SELECT 
    customer_id,
    name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM (
    SELECT 
        c.customer_id,
        c.name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY 
        c.customer_id,
        c.name
) AS customer_data;

SELECT
    o.customer_id,
    o.order_date,
    o.total_amount,
    SUM(o.total_amount) OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM orders o
ORDER BY 
    o.customer_id,
    o.order_date;
    
    SELECT 
    customer_id,
    name,
    total_spent,
    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS rank_value,
    
    DENSE_RANK() OVER (
        ORDER BY total_spent DESC
    ) AS dense_rank_value

FROM (
    SELECT 
        c.customer_id,
        c.name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY 
        c.customer_id, 
        c.name
) AS spending_data;

SELECT 
    customer_id,
    name,
    total_spent,
    ROW_NUMBER() OVER (
        ORDER BY total_spent DESC 
    ) AS row_num
FROM (
    SELECT 
        c.customer_id,
        c.name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id 
    GROUP BY 
        c.customer_id, 
        c.name 
) AS spending_data;

SELECT *
FROM (
    SELECT 
        customer_id,
        name,
        total_spent,
        ROW_NUMBER() OVER (
            ORDER BY total_spent DESC
        ) AS row_num
    FROM (
        SELECT 
            c.customer_id,
            c.name,
            SUM(o.total_amount) AS total_spent
        FROM customers c
        JOIN orders o
            ON c.customer_id = o.customer_id
        GROUP BY 
            c.customer_id, 
            c.name
    ) AS spending_data
) AS ranked_data
WHERE row_num <= 3;


SELECT
    customer_id,
    order_date,
    total_amount,
    
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_amount,
    
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS difference

FROM orders
ORDER BY 
    customer_id,
    order_date;
    
    SELECT
    customer_id,
    order_date,
    total_amount,

    LEAD(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_amount,

    LEAD(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) - total_amount AS difference

FROM orders
ORDER BY 
    customer_id,
    order_date;
    
    SELECT
    customer_id,
    name,
    total_spent,

    NTILE(4) OVER (
        ORDER BY total_spent DESC
    ) AS spending_group

FROM (
    SELECT
        c.customer_id,
        c.name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.name
) AS spending_data;

SELECT
    customer_id,
    name,
    total_spent,
    spending_group,

    CASE 
        WHEN spending_group = 1 THEN 'Platinum'
        WHEN spending_group = 2 THEN 'Gold'
        WHEN spending_group = 3 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_category

FROM (
    SELECT
        customer_id,
        name,
        total_spent,
        NTILE(4) OVER (
            ORDER BY total_spent DESC
        ) AS spending_group
    FROM (
        SELECT
            c.customer_id,
            c.name,
            SUM(o.total_amount) AS total_spent
        FROM customers c
        JOIN orders o
            ON c.customer_id = o.customer_id
        GROUP BY
            c.customer_id,
            c.name
    ) AS spending_data
) AS segmented_data;

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.name
)

SELECT *
FROM customer_spending
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
);


SELECT 
    o.customer_id,
    o.order_id,
    o.total_amount
FROM orders o
WHERE o.total_amount = (
    SELECT MAX(o2.total_amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

SELECT 
    o.customer_id,
    o.order_id,
    o.total_amount
FROM orders o
WHERE o.total_amount = (
    SELECT MAX(o2.total_amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
      AND o2.total_amount < (
            SELECT MAX(o3.total_amount)
            FROM orders o3
            WHERE o3.customer_id = o.customer_id
      )
);

CREATE USER 'read_only'@'localhost' 
IDENTIFIED BY 'Password@12';

GRANT SELECT 
ON mini_project.* 
TO 'read_only'@'localhost';

SHOW GRANTS FOR 'read_only'@'localhost';



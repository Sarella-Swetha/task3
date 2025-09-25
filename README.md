CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

| Table Name   | Description                         |
| ------------ | ----------------------------------- |
| `users`      | Stores user account details         |
| `addresses`  | Stores addresses linked to users    |
| `products`   | Stores product details              |
| `categories` | Stores product category information |
| `orders`     | Stores customer orders              |
| `payments`   | Stores payment details              |
| `inventory`  | Stores product inventory            |


CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

📌 Sample SQL Queries
1. Select All Users
SELECT * FROM users;

2. Select Specific Columns
SELECT username, email FROM users;

3. Filter Rows with WHERE
SELECT * FROM addresses WHERE city = 'Chennai';

4. WHERE with AND
SELECT * FROM products WHERE category_id = 1 AND price > 100;

5. WHERE with OR
SELECT o.order_id, o.order_status, p.payment_status
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'PENDING' OR p.payment_status = 'SUCCESS';

6. Pattern Matching with LIKE
SELECT product_id, name, price
FROM products
WHERE name LIKE '%Shirt%';

7. BETWEEN
SELECT name, price
FROM products
WHERE price BETWEEN 10 AND 200;

8. ORDER BY ASC
SELECT name, price
FROM products
ORDER BY price ASC;

9. ORDER BY DESC
SELECT order_id, user_id, placed_at
FROM orders
ORDER BY placed_at DESC;

10. LIMIT
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 1;

11. DISTINCT
SELECT DISTINCT country FROM addresses;

12. Aliasing
SELECT p.product_id AS id, p.name AS product_name, p.price AS cost_in_usd
FROM products p;

13. IN Condition
SELECT * FROM addresses WHERE city IN ('Chennai','Bengaluru');

14. JOIN: Orders with Customer Names
SELECT o.order_id, u.username, o.total_amount, o.placed_at
FROM orders o
JOIN users u ON o.user_id = u.user_id;

15. JOIN: Products with Categories
SELECT p.product_id, p.name AS product_name, c.name AS category
FROM products p
JOIN categories c ON p.category_id = c.category_id;

16. Aggregation + GROUP BY
SELECT p.name, i.quantity
FROM inventory i
JOIN products p ON i.product_id = p.product_id;

17. Total Spend by Each User
SELECT u.username, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.username;

18. HAVING Clause
SELECT u.username, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.username
HAVING total_spent > 200;

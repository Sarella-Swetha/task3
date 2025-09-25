USE ecommerce_db;
show TABLES;
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

-- 1. Select all users
SELECT * FROM users;

-- 2. Select specific columns (projection)
SELECT username, email FROM users;

-- 3. Filter rows with WHERE (users from Chennai)
SELECT * FROM addresses
WHERE city = 'Chennai';

-- 4. WHERE with AND (products in Electronics category with price > 100)
SELECT * FROM products
WHERE category_id = 1 AND price > 100;

-- 5. WHERE with OR (orders that are PENDING or SUCCESS payment)
SELECT o.order_id, o.order_status, p.payment_status
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'PENDING' OR p.payment_status = 'SUCCESS';

-- 6. Pattern matching with LIKE (find products whose name contains 'Shirt')
SELECT product_id, name, price
FROM products
WHERE name LIKE '%Shirt%';

-- 7. BETWEEN (products priced between 10 and 200)
SELECT name, price
FROM products
WHERE price BETWEEN 10 AND 200;

-- 8. ORDER BY ascending (products sorted by price)
SELECT name, price
FROM products
ORDER BY price ASC;

-- 9. ORDER BY descending (latest orders by placed date)
SELECT order_id, user_id, placed_at
FROM orders
ORDER BY placed_at DESC;

-- 10. LIMIT (Top 1 expensive product)
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 1;

-- 11. DISTINCT (list all unique countries from addresses)
SELECT DISTINCT country FROM addresses;

-- 12. Aliasing columns and tables
SELECT p.product_id AS id, p.name AS product_name, p.price AS cost_in_usd
FROM products p;

-- 13. IN (find users from Chennai or Bengaluru)
SELECT * FROM addresses
WHERE city IN ('Chennai','Bengaluru');

-- 14. JOIN: Orders with customer names and total amount
SELECT o.order_id, u.username, o.total_amount, o.placed_at
FROM orders o
JOIN users u ON o.user_id = u.user_id;

-- 15. JOIN: Products with their category name
SELECT p.product_id, p.name AS product_name, c.name AS category
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- 16. Aggregation + GROUP BY: Total quantity of each product in inventory
SELECT p.name, i.quantity
FROM inventory i
JOIN products p ON i.product_id = p.product_id;

-- 17. Aggregation + GROUP BY: Total spend by each user
SELECT u.username, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.username;

-- 18. HAVING: Users who spent more than 200
SELECT u.username, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.username
HAVING total_spent > 200;
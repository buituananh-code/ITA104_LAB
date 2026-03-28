CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address TEXT
);

CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_id INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS order_details (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

DELETE FROM order_details;
DELETE FROM orders;
DELETE FROM products;
DELETE FROM customers;

INSERT INTO customers (name, phone, address) VALUES
('Nguyễn Văn An', '0123456781', 'Hà Nội'),
('Trần Văn Bình', '0123456782', 'Hà Nội'),
('Lê Văn Cường', '0123456783', 'HCM');

INSERT INTO products (product_name, price) VALUES
('Laptop', 1500),
('Phone', 800),
('Mouse', 50);

INSERT INTO orders (customer_id, total_amount) VALUES
(1, 2300),
(2, 800);

INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1500),
(1, 2, 1, 800),
(2, 2, 1, 800);

#Bài 1: Đơn hàng + tên khách hàng
    SELECT 
        o.order_id,
        o.order_date,
        c.name AS customer_name
    FROM orders o
    JOIN customers c
    ON o.customer_id = c.customer_id;

#Bài 2: Chi tiết đơn hàng
    SELECT 
        o.order_id,
        p.product_name,
        od.quantity,
        od.price
    FROM order_details od
    JOIN products p
    ON od.product_id = p.product_id
    JOIN orders o
    ON od.order_id = o.order_id;

#Bài 3: Tổng tiền từng đơn hàng
    SELECT 
        o.order_id,
        SUM(od.quantity * od.price) AS total_amount
    FROM orders o
    JOIN order_details od
    ON o.order_id = od.order_id
    GROUP BY o.order_id;

#Bài 4: Tổng tiền từng khách hàng
    SELECT 
        c.name AS customer_name,
        SUM(od.quantity * od.price) AS total_spent
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    JOIN order_details od
    ON o.order_id = od.order_id
    GROUP BY c.name;
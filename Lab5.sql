DROP TABLE IF EXISTS order_details CASCADE;
DROP TABLE IF EXISTS order_items   CASCADE;
DROP TABLE IF EXISTS orders        CASCADE;
DROP TABLE IF EXISTS products      CASCADE;
DROP TABLE IF EXISTS customers     CASCADE;
DROP TABLE IF EXISTS suppliers     CASCADE;

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    phone       VARCHAR(20),
    address     VARCHAR(200)
);

INSERT INTO suppliers (name, phone, address) VALUES
('Công ty Sữa Việt Nam',   '028-3812-1111', 'Số 10 Tân Trào, Q.7, TP.HCM'),
('Công ty Thực Phẩm Xanh', '024-3632-2222', 'Số 5 Giải Phóng, Hà Nội'),
('Nhà Phân Phối ABC',      '0903-333-444',  'Số 88 Lê Lợi, Đà Nẵng'),
('Công ty Hải Sản Biển',   '0911-555-666',  'Số 3 Trần Phú, Nha Trang'),
('Trang Trại Hữu Cơ',      '0977-777-888',  'Số 20 Nguyễn Huệ, Cần Thơ');

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(100),
    phone       VARCHAR(20),
    address     VARCHAR(200)
);

INSERT INTO customers (name, email, phone, address) VALUES
('Nguyễn Văn An',   'an.nguyen@email.com',   '0901-111-001', 'Hà Nội'),
('Trần Thị Bích',   'bich.tran@email.com',   '0902-222-002', 'TP.HCM'),
('Lê Minh Cường',   'cuong.le@email.com',    '0903-333-003', 'Đà Nẵng'),
('Phạm Thu Hà',     'ha.pham@email.com',     '0904-444-004', 'Hải Phòng'),
('Hoàng Đức Minh',  'minh.hoang@email.com',  '0905-555-005', 'Cần Thơ'),
('Vũ Thị Lan',      'lan.vu@email.com',      '0906-666-006', 'Huế'),
('Bùi Thị Mai',     'mai.bui@email.com',     '0908-888-008', 'Vinh'),
('Ngô Thanh Tùng',  'tung.ngo@email.com',    '0909-999-009', 'Buôn Ma Thuột');

CREATE TABLE products (
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price        NUMERIC(12,2) NOT NULL,
    stock        INT DEFAULT 0,
    supplier_id  INT REFERENCES suppliers(supplier_id)
);

INSERT INTO products (product_name, price, stock, supplier_id) VALUES
('Sữa tươi tiệt trùng 1L',         28000,  200, 1),
('Sữa đặc có đường 380g',          25000,  150, 1),
('Sữa chua uống đóng chai 180ml',  12000,  300, 1),
('Dầu ăn thực vật 1L',             45000,  120, 2),
('Nước mắm cao cấp 500ml',         38000,   80, 2),
('Mì gói hảo hảo (thùng 30 gói)', 105000,   60, 2),
('Gạo ST25 5kg',                   125000,  100, 3),
('Đường kính trắng 1kg',           22000,  250, 3),
('Cá hồi phi lê đông lạnh 500g',  185000,   40, 4),
('Tôm sú tươi 1kg',                220000,   30, 4),
('Rau cải xanh hữu cơ 500g',       18000,  180, 5),
('Cà rốt hữu cơ 1kg',              32000,   90, 5),
('Mật ong rừng nguyên chất 500g', 195000,   20, 5),
('Trà xanh Thái Nguyên 100g',      55000,   50, 3);

CREATE TABLE orders (
    order_id    SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date  DATE NOT NULL DEFAULT CURRENT_DATE,
    status      VARCHAR(30) DEFAULT 'completed'
);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-11-01', 'completed'),
(2, '2024-11-03', 'completed'),
(3, '2024-11-05', 'completed'),
(4, '2024-11-10', 'completed'),
(5, '2024-11-12', 'completed'),
(1, '2024-11-15', 'completed'),
(6, '2024-11-18', 'completed'),
(2, '2024-11-22', 'completed');

CREATE TABLE order_details (
    detail_id  SERIAL PRIMARY KEY,
    order_id   INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity   INT NOT NULL CHECK (quantity > 0),
    price      NUMERIC(12,2) NOT NULL
);

INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1,  1,  3,  28000),
(1,  7,  2, 125000),
(2,  9,  1, 185000),
(2,  4,  2,  45000),
(3,  6,  1, 105000),
(3,  5,  3,  38000),
(4, 10,  1, 220000),
(4,  8,  5,  22000),
(5,  2,  4,  25000),
(5, 11,  6,  18000),
(6,  3, 10,  12000),
(6, 12,  3,  32000),
(7,  1,  5,  28000),
(7,  7,  1, 125000),
(8,  9,  2, 185000),
(8,  5,  1,  38000);

CREATE VIEW order_items AS SELECT * FROM order_details;

--Bài 1:
SELECT 
    o.order_id,
    p.product_name,
    od.quantity,
    od.price
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id
INNER JOIN orders o   ON od.order_id   = o.order_id;

SELECT 
    c.name AS full_name,
    o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

--Bài 2:
SELECT 
    p.product_name,
    od.order_id
FROM order_details od
RIGHT JOIN products p ON od.product_id = p.product_id;

SELECT 
    c.name  AS contact_name,
    c.phone AS phone_number
FROM customers c
UNION
SELECT 
    s.name  AS supplier_name,
    s.phone AS contact_phone
FROM suppliers s;

--Bài 3:
SELECT 
    product_name,
    price
FROM products
WHERE supplier_id = (
    SELECT supplier_id FROM suppliers
    WHERE name = 'Công ty Sữa Việt Nam'
);

SELECT 
    product_name,
    price,
    (SELECT AVG(price) FROM products) AS average_price
FROM products;

--Bài 4:
SELECT 
    order_id
FROM order_details
WHERE quantity * price > 50000;

SELECT 
    s.name AS Supplier_name
FROM suppliers s
WHERE EXISTS (
    SELECT * FROM products p
    WHERE p.supplier_id = s.supplier_id
);
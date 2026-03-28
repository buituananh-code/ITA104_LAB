#Dựa vào Lab2.sql INSERT DATA
    INSERT INTO customers (name, phone, address) VALUES
    ('Nguyễn Văn An', '0123456781', 'Hà Nội'),
    ('Trần Văn Bình', '0123456782', 'Hà Nội'),
    ('Lê Văn Cường', '0123456783', 'HCM'),
    ('Phạm Văn Dũng', '0123456784', 'Đà Nẵng'),
    ('Hoàng Văn Em', '0123456785', 'Hà Nội'),
    ('Nguyễn Văn Phúc', '0123456786', 'HCM'),
    ('Đỗ Văn Huy', '0123456787', 'Hải Phòng'),
    ('Bùi Văn Khang', '0123456788', 'Huế'),
    ('Phan Văn Long', '0123456789', 'Cần Thơ'),
    ('Võ Văn Nam', '0123456790', 'Hà Nội');

    INSERT INTO products (product_name, price) VALUES
    ('Laptop', 1500),
    ('Phone', 800),
    ('Tablet', 600),
    ('Headphones', 200),
    ('Keyboard', 100),
    ('Mouse', 50),
    ('Monitor', 300),
    ('Printer', 250),
    ('Camera', 700),
    ('Speaker', 150),
    ('USB', 20),
    ('SSD', 120),
    ('HDD', 90),
    ('Router', 80),
    ('Smartwatch', 250),
    ('TV', 1200),
    ('Fan', 70),
    ('Air Conditioner', 900),
    ('Mic', 110),
    ('Webcam', 95);

#Bài 1
    SELECT 
        product_name AS TenSanPham,
        price AS DonGia
    FROM products;

#Bài 2
    SELECT 
        name AS TenKhachHang,
        phone AS SoDienThoai
    FROM customers
    WHERE name LIKE '%Văn%';

#Bài 3
    SELECT 
        product_name,
        price
    FROM products
    ORDER BY price DESC;

#Bài 4
    SELECT 
        product_name,
        price
    FROM products
    ORDER BY price ASC
    LIMIT 3;
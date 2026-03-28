#Bài 1
    SELECT product_name AS TenSanPham, price AS DonGia FROM products;

#Bài 2
    SELECT name AS TenKhachHang, phone AS SoDienThoai 
    FROM customers
    WHERE name LIKE '%Văn%';

#Bài 3
    SELECT product_name, price 
    FROM products
    ORDER BY price DESC;

#Bài 4
    SELECT product_name, price 
    FROM products
    ORDER BY price ASC
    LIMIT 3;
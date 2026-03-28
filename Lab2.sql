#Bài 1:
    # Customers
        customer_id
        name
        phone
        address
    # Products
        product_id
        product_name
        price
    # Orders
        order_id
        order_date
        customer_id
        total_amount
    # OrderDetails
        order_id
        product_id
        quantity
        price

#Bài 3:
    # Customers
        CREATE TABLE customers (
            customer_id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            phone VARCHAR(15) UNIQUE,
            address TEXT
        );
    # Products
        CREATE TABLE products (
            product_id SERIAL PRIMARY KEY,
            product_name VARCHAR(255) NOT NULL,
            price DECIMAL(10,2) NOT NULL
        );
    # Orders
        CREATE TABLE orders (
            order_id SERIAL PRIMARY KEY,
            order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            customer_id INT,
            total_amount DECIMAL(10,2),
            FOREIGN KEY (customer_id)
                REFERENCES customers(customer_id)
        );
    # OrderDetails
        CREATE TABLE order_details (
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
    # Quan hệ
        customers (1) → (n) orders
        orders (1) → (n) order_details
        products (1) → (n) order_details
        # Quan hệ đã được giải quyết bằng bảng trung gian:
            order_details
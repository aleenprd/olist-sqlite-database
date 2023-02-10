CREATE TABLE IF NOT EXISTS customers(
    customer_unique_id VARCHAR PRIMARY KEY,
    customer_city VARCHAR NOT NULL,
    customer_state VARCHAR NOT NULL,
    customer_zip_code_prefix INTEGER REFERENCES geolocation (geolocation_zip_code_prefix),
    customer_id VARCHAR REFERENCES orders (customer_id)
);
CREATE TABLE IF NOT EXISTS geolocation(
    geolocation_zip_code_prefix INTEGER PRIMARY KEY,
    geolocation_lat FLOAT NOT NULL,
    geolocation_lng FLOAT NOT NULL,
    geolocation_city VARCHAR NOT NULL,
    geolocation_state VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS items(
    order_id VARCHAR PRIMARY KEY,
    order_item_id TINYINT NOT NULL,
    shipping_limit_date TIMESTAMP NOT NULL,
    price FLOAT NOT NULL,
    freight_value FLOAT NOT NULL,
    product_id VARCHAR REFERENCES products (product_id),
    seller_id VARCHAR REFERENCES sellers (seller_id)
);
CREATE TABLE IF NOT EXISTS payments(
    order_id VARCHAR PRIMARY KEY,
    payment_sequential TINYINT NOT NULL,
    payment_type VARCHAR NOT NULL,
    payment_installments TINYINT NOT NULL,
    payment_value FLOAT NOT NULL
);
CREATE TABLE IF NOT EXISTS orders(
    order_id VARCHAR PRIMARY KEY,
    order_status VARCHAR NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP NOT NULL,
    order_delivered_carrier_date TIMESTAMP NULL,
    order_delivered_customer_date TIMESTAMP NULL,
    order_estimated_delivery_date TIMESTAMP NULL,
    customer_id VARCHAR REFERENCES customers (customer_id)
);
CREATE TABLE IF NOT EXISTS reviews(
    review_id VARCHAR PRIMARY KEY,
    review_score INTEGER NOT NULL,
    review_comment_title VARCHAR NULL,
    review_comment_message VARCHAR NULL,
    review_creation_date TIMESTAMP NOT NULL,
    review_answer_timestamp TIMESTAMP NOT NULL,
    order_id VARCHAR NOT NULL REFERENCES orders (order_id)
);
CREATE TABLE IF NOT EXISTS products(
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR NULL,
    product_name_lenght INTEGER NULL,
    product_description_lenght INTEGER NULL,
    product_photos_qty INTEGER NULL,
    product_weight_g INTEGER NULL,
    product_length_cm INTEGER NULL,
    product_height_cm INTEGER NULL,
    product_width_cm INTEGER NULL
);
CREATE TABLE IF NOT EXISTS sellers(
    seller_id VARCHAR PRIMARY KEY,
    seller_city VARCHAR NOT NULL,
    seller_state VARCHAR NOT NULL,
    seller_zip_code_prefix INTEGER NOT NULL REFERENCES geolocation (geolocation_zip_code_prefix)
);
CREATE TABLE IF NOT EXISTS translation(
    product_category_name_english VARCHAR PRIMARY KEY,
    product_category_name VARCHAR REFERENCES products (product_category_name)
);
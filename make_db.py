#!/usr/bin/env python


import sqlite3
import csv


# CREATE OR CONNECT TO DATABASE
db = sqlite3.connect("olist.db")
cursor = db.cursor()


# DATA PATHS
DATA_PATH = "./data/olist_datasets"
CUSTOMERS_FILENAME = "olist_customers_dataset.csv"
GEOLOCATION_FILENAME = "olist_geolocation_dataset.csv"
ITEMS_FILENAME = "olist_order_items_dataset.csv"
PAYMENTS_FILENAME = "olist_order_payments_dataset.csv"
REVIEWS_FILENAME = "olist_order_reviews_dataset.csv"
ORDERS_FILENAME = "olist_orders_dataset.csv"
PRODUCTS_FILENAME = "olist_products_dataset.csv"
SELLERS_FILENAME = "olist_sellers_dataset.csv"
TRANSLATION_FILENAME = "product_category_name_translation.csv"

file_paths_dict = {
    "customers": CUSTOMERS_FILENAME,
    "geolocation": GEOLOCATION_FILENAME,
    "items": ITEMS_FILENAME,
    "payments": PAYMENTS_FILENAME,
    "reviews": REVIEWS_FILENAME,
    "orders": ORDERS_FILENAME,
    "products": PRODUCTS_FILENAME,
    "sellers": SELLERS_FILENAME,
    "translation": TRANSLATION_FILENAME,
}


# CREATE TABLES ACCORDING TO SQL SCRIPT
with open("./queries/create_tables.sql", "r") as sql_file:
    create_tables_script = sql_file.read()
cursor.executescript(create_tables_script)


# POPULATE TABLES WITH DATA FROM CSV FILES
for table_name, file_path in file_paths_dict.items():
    print(f"Inserting file {file_path} into table {table_name}...")

    # Read the file row by row
    with open(f"{DATA_PATH}/{file_path}", "r") as fin:
        dr = csv.DictReader(fin)

        # Fetch column names from each dictionary row
        cols = dr.fieldnames

        # Build column name placeholders
        question_marks = []
        for i in range(len(cols)):
            question_marks.append("?")
        question_marks = (",").join(question_marks)

        # Data to be added to the table
        to_db = [tuple([i[c] for c in cols]) for i in dr]

    cols = (",").join(cols)
    cursor.executemany(
        f"""INSERT OR REPLACE INTO {table_name} ({cols}) VALUES ({question_marks});""",
        to_db,
    )

# COMMIT CHANGES AND CLOSE CONNECTION TO DATABASE
db.commit()
db.close()


# DATA COLUMNS
# customers_cols = [
#     "customer_unique_id",
#     "customer_city",
#     "customer_state",
#     "customer_zip_code_prefix",
#     "customer_id",
# ]

# geolocation_cols = [
#     "geolocation_zip_code_prefix",
#     "geolocation_lat",
#     "geolocation_lng",
#     "geolocation_city",
#     "geolocation_state",
# ]

# items_cols = [
#     "order_id",
#     "order_item_id",
#     "shipping_limit_date",
#     "price",
#     "freight_value",
#     "product_id",
#     "seller_id",
# ]

# payments_cols = [
#     "order_id",
#     "payment_sequential",
#     "payment_type",
#     "payment_installments",
#     "payment_value",
# ]

# orders_cols = [
#     "order_id",
#     "order_status",
#     "order_purchase_timestamp",
#     "order_approved_at",
#     "order_delivered_carrier_date",
#     "order_delivered_customer_date",
#     "order_estimated_delivery_date",
#     "customer_id",
# ]

# reviews_cols = [
#     "review_id",
#     "review_score",
#     "review_comment_title",
#     "review_comment_message",
#     "review_creation_date",
#     "review_answer_timestamp",
#     "order_id",
# ]

# products_cols = [
#     "product_id",
#     "product_category_name",
#     "product_name_lenght",
#     "product_description_lenght",
#     "product_photos_qty",
#     "product_weight_g",
#     "product_length_cm",
#     "product_height_cm",
#     "product_width_cm",
# ]

# sellers_cols = [
#     "seller_id",
#     "seller_city",
#     "seller_state",
#     "seller_zip_code_prefix",
# ]

# translation_cols = ["product_category_name", "product_category_name_english"]

# cols_list = [
#     customers_cols,
#     geolocation_cols,
#     items_cols,
#     payments_cols,
#     orders_cols,
# ]

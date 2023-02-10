# Olist Sqlite

This project aims to create a database from the [Kaggle Olist dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) which is a collection of CSV files. We will use Python's native [Sqlite3 API](https://docs.python.org/3/library/sqlite3.html) and construct our 'olist.db' by running 'python make_db.py'. This will enable us to write SQL queries and run them directly in an IDE such as VsCode.

The original data has the following relational schema:

![relational schema](./pictures/olist-original-schema.png)

The original data can be downloaded from Kaggle. But I have posted my sample in 'data/olist_datasets/' as a collection of CSV files.

You can find the query used for creating the different tables in 'queries/create_tables.sql, alongside some random queries which I used for testing purposes.
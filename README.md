# E-commerce Shop Database

## Project Overview

This project demonstrates the design and implementation of a relational database for a fictional e-commerce store using PostgreSQL.

The database was built from scratch to simulate basic business operations of an online shop, including customer management, product catalogues and order processing.

The project focuses on practical SQL skills, relational database design, data generation, transaction management and query performance optimization.

## Technologies

- PostgreSQL 17
- SQL
- Python (Faker, psycopg)
- DBeaver
- Git & GitHub

## Database Structure

The database consists of the following main tables:

- `customers` – customer information
- `categories` – product categories
- `product` – product catalogue
- `employees` – employee information
- `customer_orders` – customer orders
- `order_items` – individual products within orders

The tables are connected through primary and foreign key relationships.

## Project Scope

### 1. Database Design

- Designing a relational database structure
- Creating tables and defining relationships
- Implementing primary keys, foreign keys and constraints
- Maintaining data integrity

### 2. Data Generation

- Generating realistic sample data using Python and Faker
- Connecting Python scripts to PostgreSQL
- Populating relational tables with generated records

### 3. SQL Analysis

- Data filtering and sorting
- JOIN operations
- Aggregations and conditional aggregation
- Subqueries and Common Table Expressions (CTEs)
- Window functions
- Creating views and materialized views

### 4. Database Optimization

- Creating indexes
- Analyzing query execution plans using EXPLAIN ANALYZE
- Comparing query performance before and after indexing

### 5. Transaction Management

- Working with database transactions
- Using COMMIT and ROLLBACK
- Managing savepoints
- Understanding data consistency and transaction control

## Project Structure

- `sql/` – database schema, SQL queries and exercises
- `python/` – scripts for generating sample data

## Project Outcome

The project provided practical experience in relational database design and PostgreSQL development.

It allowed me to apply SQL concepts to a simulated business environment, covering both analytical queries and transactional database operations.

The project is completed and serves as a foundation for further development of my data analytics skills.

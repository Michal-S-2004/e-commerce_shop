CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary NUMERIC(10,2) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL
);

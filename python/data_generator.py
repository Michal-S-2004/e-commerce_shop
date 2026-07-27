from faker import Faker
from dotenv import load_dotenv
from unidecode import unidecode
import psycopg
import os
from datetime import datetime

load_dotenv()
fake = Faker("pl_PL")

connection = psycopg.connect(
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
)

cursor = connection.cursor()

cursor.execute("SELECT version();")
print(cursor.fetchone()[0])
# EMPLOYEES

def create_employees():

    for i in range(10):

        first_name = unidecode(fake.first_name())
        last_name = unidecode(fake.last_name())
        salary = fake.random_int(min=4000, max=12000)
        phone_number = fake.phone_number()
        email = f"{first_name.lower()}.{last_name.lower()}{fake.random_int(min=100, max=999)}@store.com"

        print(first_name, last_name, salary, phone_number, email)

        cursor.execute(
            """
            INSERT INTO employees
            (first_name, last_name, salary, phone_number, email)
            VALUES (%s, %s, %s, %s, %s)
            """,
            (first_name, last_name, salary, phone_number, email)
        )
def create_customers():
    for i in range(500):
        first_name = unidecode(fake.first_name())
        last_name = unidecode(fake.last_name())
        phone_number = fake.phone_number()
        email = f"{first_name.lower()}.{last_name.lower()}{fake.random_int(min=100, max=999)}@example.com"
        created_at = fake.date_time_between(start_date=datetime(2025, 1, 1),end_date="now")

        cursor.execute(
            """
            INSERT INTO customers
            (first_name, last_name, phone, email, created_at)
            VALUES (%s, %s, %s, %s, %s)
            """,
            (first_name, last_name, phone_number, email, created_at))
cursor.execute("""
UPDATE employees
SET phone_number = REPLACE(phone_number, '+48 ', '');
""")




if __name__ == "__main__":
    #create_customers()

    connection.commit()

    cursor.close()
    connection.close()

    print("Customers inserted successfully.")


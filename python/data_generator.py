from faker import Faker
from dotenv import load_dotenv
from unidecode import unidecode
import psycopg
import os
from datetime import datetime
import random
from decimal import Decimal

product_dict = {
    "Laptops": [
        ("Lenovo ThinkPad E16", 4299.99),
        ("Dell Inspiron 15", 3199.99),
        ("HP ProBook 450", 3899.99),
        ("ASUS VivoBook 15", 2999.99),
        ("Acer Aspire 5", 2799.99),
        ("Apple MacBook Air", 5499.99),
        ("MSI Modern 15", 3499.99),
        ("Lenovo IdeaPad Slim 5", 3599.99),
    ],

    "Desktop PCs": [
        ("Dell OptiPlex 7020", 3799.99),
        ("HP Pro Tower 400", 3499.99),
        ("Lenovo ThinkCentre M70t", 3999.99),
        ("MSI MAG Infinite S3", 5299.99),
        ("Acer Nitro N50", 4799.99),
        ("ASUS ROG Strix G16CH", 6999.99),
    ],

    "PC Components": [
        ("AMD Ryzen 5 7600", 899.99),
        ("Intel Core i5-14600K", 1399.99),
        ("NVIDIA GeForce RTX 4060", 1599.99),
        ("AMD Radeon RX 7800 XT", 2499.99),
        ("ASUS TUF Gaming B650-Plus", 799.99),
        ("Corsair Vengeance 32GB DDR5", 499.99),
        ("be quiet! Pure Power 12M 750W", 549.99),
        ("Endorfy Fortis 5", 219.99),
        ("NZXT H5 Flow", 399.99),
    ],

    "Smartphones": [
        ("Samsung Galaxy S25", 4299.99),
        ("Samsung Galaxy A56", 1999.99),
        ("Apple iPhone 16", 4499.99),
        ("Google Pixel 9", 3599.99),
        ("Xiaomi 15", 3999.99),
        ("Xiaomi Redmi Note 14", 1299.99),
        ("Motorola Edge 60", 2199.99),
        ("Nothing Phone 3", 3299.99),
        ("OnePlus 13", 4199.99),
    ],

    "Tablets": [
        ("Apple iPad Air", 3199.99),
        ("Apple iPad Pro", 5499.99),
        ("Samsung Galaxy Tab S10", 4199.99),
        ("Samsung Galaxy Tab A9", 999.99),
        ("Lenovo Tab P12", 1599.99),
        ("Xiaomi Pad 7", 1799.99),
    ],

    "Monitors": [
        ("LG UltraGear 27GP850", 1499.99),
        ("Dell P2725H", 1099.99),
        ("Samsung Odyssey G5", 1399.99),
        ("ASUS TUF Gaming VG27AQ", 1599.99),
        ("AOC 24G2SP", 749.99),
        ("Philips 243V7", 549.99),
        ("MSI G274QPF", 1299.99),
    ],

    "Keyboards": [
        ("Logitech MX Keys S", 499.99),
        ("Logitech G915 TKL", 799.99),
        ("Razer BlackWidow V4", 749.99),
        ("SteelSeries Apex 5", 499.99),
        ("HyperX Alloy Origins", 449.99),
        ("Keychron K2", 429.99),
        ("Genesis Thor 300", 219.99),
        ("Microsoft Wired Keyboard 600", 89.99),
    ],

    "Mice": [
        ("Logitech MX Master 3S", 449.99),
        ("Logitech G502 X", 349.99),
        ("Razer DeathAdder V3", 299.99),
        ("SteelSeries Rival 5", 269.99),
        ("HyperX Pulsefire Haste", 229.99),
        ("Microsoft Bluetooth Mouse", 129.99),
        ("Genesis Krypton 550", 149.99),
    ],

    "Headphones": [
        ("Sony WH-1000XM5", 1499.99),
        ("Apple AirPods Pro", 1099.99),
        ("Samsung Galaxy Buds3 Pro", 899.99),
        ("JBL Tune 770NC", 449.99),
        ("Sennheiser Momentum 4", 1299.99),
        ("HyperX Cloud III", 499.99),
        ("Logitech G Pro X", 599.99),
        ("SteelSeries Arctis Nova 7", 799.99),
    ],

    "Storage Devices": [
        ("Samsung 990 Pro 1TB", 499.99),
        ("Kingston NV2 1TB", 249.99),
        ("Crucial P3 Plus 2TB", 499.99),
        ("WD Blue SN580 1TB", 299.99),
        ("Seagate Barracuda 2TB", 279.99),
        ("SanDisk Extreme Portable 1TB", 499.99),
        ("Samsung T7 1TB", 449.99),
    ],

    "Networking": [
        ("TP-Link Archer AX55 Router", 399.99),
        ("ASUS RT-AX58U Router", 649.99),
        ("Netgear GS108 Switch", 199.99),
        ("TP-Link Deco X50 Mesh", 899.99),
        ("Ubiquiti UniFi Access Point", 649.99),
        ("TP-Link USB Wi-Fi Adapter", 99.99),
    ],

    "Gaming": [
        ("Sony PlayStation 5 Slim", 2499.99),
        ("Xbox Series X", 2399.99),
        ("Nintendo Switch OLED", 1599.99),
        ("Meta Quest 3", 2499.99),
        ("Logitech G29 Steering Wheel", 1199.99),
        ("Xbox Wireless Controller", 279.99),
        ("PlayStation DualSense Controller", 329.99),
        ("Thrustmaster T300 RS", 1799.99),
    ],

    "TV & Home Entertainment": [
        ("Samsung QLED 55 Inch TV", 3299.99),
        ("LG OLED 55 Inch TV", 4999.99),
        ("Sony Bravia 65 Inch TV", 5799.99),
        ("Samsung Soundbar HW-Q600C", 1399.99),
        ("JBL Bar 500", 1899.99),
        ("Xiaomi TV Box S", 299.99),
        ("Google Chromecast 4K", 349.99),
    ],

    "Office Equipment": [
        ("HP LaserJet M110w", 599.99),
        ("Brother HL-L2402D", 649.99),
        ("Canon PIXMA TS5350", 399.99),
        ("Epson EcoTank L3250", 999.99),
        ("HP OfficeJet Pro 9120e", 899.99),
        ("Fellowes Paper Shredder", 349.99),
        ("Canon CanoScan LiDE 400", 449.99),
        ("Brother Label Printer", 299.99),
    ],

    "Accessories": [
        ("USB-C Hub 7-in-1", 199.99),
        ("Laptop Stand", 129.99),
        ("Webcam Logitech C920", 299.99),
        ("USB-C Charger 65W", 179.99),
        ("HDMI Cable 2m", 39.99),
        ("Laptop Backpack", 199.99),
        ("Mouse Pad XL", 79.99),
        ("Power Bank 20000 mAh", 199.99),
        ("USB Flash Drive 128GB", 59.99),
        ("Screen Cleaning Kit", 29.99),
    ],
}

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
'''cursor.execute("""
UPDATE employees
SET phone_number = REPLACE(phone_number, '+48 ', '');
""")'''

cursor.execute('''
SELECT category_id, category_name FROM categories''')
rows = cursor.fetchall()
#print(rows)
category_dict = {}
for category in rows:
    category_dict[category[1]] = category[0]
#print(category_dict)

def create_product():
    for category_name in category_dict:
        category_id = category_dict[category_name]
        product_params = product_dict[category_name]
        for params in product_params:
            cursor.execute(
                """
                INSERT INTO product
                (product_name, product_price, category_id)
                VALUES (%s, %s, %s)
                """,
                (params[0], params[1], category_id))
    #print(product_params)

def create_customer_orders(number_of_orders=500):

    cursor.execute("""
        SELECT customer_id
        FROM customers
    """)
    customer_ids = [row[0] for row in cursor.fetchall()]

    cursor.execute("""
        SELECT employee_id
        FROM employees
    """)
    employee_ids = [row[0] for row in cursor.fetchall()]

    cursor.execute("""
        SELECT
            p.product_id,
            p.product_name,
            p.product_price,
            c.category_name
        FROM product p
        JOIN categories c
            ON p.category_id = c.category_id
    """)
    product_rows = cursor.fetchall()

    products_by_category = {}

    for product_id, product_name, product_price, category_name in product_rows:

        if category_name not in products_by_category:
            products_by_category[category_name] = []

        products_by_category[category_name].append(
            (product_id, product_name, product_price)
        )

    category_names = list(products_by_category.keys())

    for i in range(number_of_orders):

        customer_id = random.choice(customer_ids)
        employee_id = random.choice(employee_ids)

        shipping_address = fake.address().replace("\n", ", ")
        order_date = fake.date_between(
            start_date=datetime(2025, 1, 1),
            end_date="today"
        )

        number_of_categories = random.randint(1, 3)

        selected_categories = random.sample(
            category_names,
            k=number_of_categories
        )

        selected_items = {}

        for category_name in selected_categories:

            number_of_products = random.randint(1, 3)

            selected_products = random.choices(
                products_by_category[category_name],
                k=number_of_products
            )

            for product_id, product_name, product_price in selected_products:

                if product_id not in selected_items:
                    selected_items[product_id] = {
                        "product_name": product_name,
                        "unit_price": Decimal(str(product_price)),
                        "quantity": 1
                    }
                else:
                    selected_items[product_id]["quantity"] += 1

        order_price = Decimal("0.00")

        for item in selected_items.values():
            order_price += item["unit_price"] * item["quantity"]

        cursor.execute(
            """
            INSERT INTO customer_orders
            (
                customer_id,
                employee_id,
                shipping_address,
                order_price,
                order_date
            )
            VALUES (%s, %s, %s, %s, %s)
            RETURNING order_id
            """,
            (
                customer_id,
                employee_id,
                shipping_address,
                order_price,
                order_date
            )
        )

        order_id = cursor.fetchone()[0]

        for product_id, item in selected_items.items():

            cursor.execute(
                """
                INSERT INTO order_items
                (
                    order_id,
                    product_id,
                    quantity,
                    unit_price
                )
                VALUES (%s, %s, %s, %s)
                """,
                (
                    order_id,
                    product_id,
                    item["quantity"],
                    item["unit_price"]
                )
            )




#create_product()
if __name__ == "__main__":
    #create_customers()
    #create_customer_orders()
    connection.commit()

    cursor.close()
    connection.close()




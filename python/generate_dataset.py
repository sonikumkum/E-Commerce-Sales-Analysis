import pandas as pd
import numpy as np

# ==========================================
# E-COMMERCE SALES DATASET GENERATOR
# ==========================================

np.random.seed(42)

NUM_ORDERS = 1200

# ==========================================
# 1. CUSTOMERS
# ==========================================

customer_ids = [
    f"CUST{1001 + i}"
    for i in range(650)
]

selected_customers = np.random.choice(
    customer_ids,
    size=NUM_ORDERS,
    replace=True
)

# ==========================================
# 2. ORDER DATES
# ==========================================

# Generate random day numbers instead of modifying
# a Pandas Index later

start_date = pd.Timestamp("2023-01-01")
end_date = pd.Timestamp("2023-12-31")

days_between = (
    end_date - start_date
).days

random_days = np.random.randint(
    0,
    days_between + 1,
    size=NUM_ORDERS
)

order_dates = np.array(
    [
        start_date + pd.Timedelta(
            days=int(day)
        )
        for day in random_days
    ],
    dtype="datetime64[ns]"
)

# ==========================================
# 3. SEPTEMBER SALES BOOST
# ==========================================

# Select 180 random orders and assign them
# September dates directly

september_indices = np.random.choice(
    NUM_ORDERS,
    size=180,
    replace=False
)

september_days = np.random.randint(
    1,
    30,
    size=180
)

for index, day in zip(
    september_indices,
    september_days
):

    order_dates[index] = np.datetime64(
        f"2023-09-{day:02d}"
    )

# ==========================================
# 4. CITIES
# ==========================================

cities = [
    "Delhi",
    "Chennai",
    "Jaipur",
    "Mumbai",
    "Bengaluru",
    "Hyderabad",
    "Pune",
    "Kolkata"
]

city_probability = [
    0.18,
    0.14,
    0.13,
    0.14,
    0.12,
    0.10,
    0.10,
    0.09
]

customer_cities = np.random.choice(
    cities,
    size=NUM_ORDERS,
    p=city_probability
)

# ==========================================
# 5. PRODUCTS
# ==========================================

products = [
    "Premium Laptop",
    "Smartphone",
    "Wireless Headphones",
    "Smart Watch",
    "Air Fryer",
    "Coffee Maker",
    "Running Shoes",
    "Kurta Set",
    "Skincare Kit",
    "Yoga Mat"
]

product_probability = [
    0.06,
    0.10,
    0.12,
    0.12,
    0.10,
    0.08,
    0.12,
    0.10,
    0.10,
    0.10
]

selected_products = np.random.choice(
    products,
    size=NUM_ORDERS,
    p=product_probability
)

# ==========================================
# 6. PRODUCT CATEGORIES
# ==========================================

categories = {

    "Premium Laptop": "Electronics",

    "Smartphone": "Electronics",

    "Wireless Headphones": "Electronics",

    "Smart Watch": "Electronics",

    "Air Fryer": "Home & Kitchen",

    "Coffee Maker": "Home & Kitchen",

    "Running Shoes": "Sports",

    "Kurta Set": "Fashion",

    "Skincare Kit": "Beauty",

    "Yoga Mat": "Sports"
}

# ==========================================
# 7. PRODUCT PRICES
# ==========================================

prices = {

    "Premium Laptop": 81000,

    "Smartphone": 45000,

    "Wireless Headphones": 5500,

    "Smart Watch": 7500,

    "Air Fryer": 8500,

    "Coffee Maker": 6200,

    "Running Shoes": 4800,

    "Kurta Set": 2600,

    "Skincare Kit": 3200,

    "Yoga Mat": 1800
}

# ==========================================
# 8. UNITS
# ==========================================

units = np.random.choice(
    [1, 2, 3, 4],
    size=NUM_ORDERS,
    p=[
        0.20,
        0.50,
        0.25,
        0.05
    ]
)

# ==========================================
# 9. PAYMENT MODE
# ==========================================

payment_modes = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Net Banking",
    "Cash on Delivery"
]

payment_mode = np.random.choice(
    payment_modes,
    size=NUM_ORDERS,
    p=[
        0.35,
        0.25,
        0.18,
        0.12,
        0.10
    ]
)

# ==========================================
# 10. CUSTOMER SEGMENT
# ==========================================

customer_segment = np.random.choice(
    [
        "New",
        "Returning",
        "Loyal"
    ],
    size=NUM_ORDERS,
    p=[
        0.45,
        0.35,
        0.20
    ]
)

# ==========================================
# 11. CREATE DATAFRAME
# ==========================================

df = pd.DataFrame({

    "order_id": [
        f"ORD{10001 + i}"
        for i in range(NUM_ORDERS)
    ],

    "order_date": order_dates,

    "customer_id": selected_customers,

    "customer_city": customer_cities,

    "category": [
        categories[product]
        for product in selected_products
    ],

    "product": selected_products,

    "units": units,

    "unit_price": [
        prices[product]
        for product in selected_products
    ],

    "payment_mode": payment_mode,

    "customer_segment": customer_segment
})

# ==========================================
# 12. CALCULATE REVENUE
# ==========================================

df["revenue"] = (
    df["units"] *
    df["unit_price"]
)

# ==========================================
# 13. SEPTEMBER SEASONAL EFFECT
# ==========================================

september_mask = (
    pd.to_datetime(
        df["order_date"]
    ).dt.month == 9
)

df.loc[
    september_mask,
    "revenue"
] = (
    df.loc[
        september_mask,
        "revenue"
    ] * 1.5
)

# ==========================================
# 14. DATE FORMAT
# ==========================================

df["order_date"] = (
    pd.to_datetime(
        df["order_date"]
    ).dt.strftime("%Y-%m-%d")
)

# ==========================================
# 15. COLUMN ORDER
# ==========================================

df = df[
    [
        "order_id",
        "order_date",
        "customer_id",
        "customer_city",
        "category",
        "product",
        "units",
        "unit_price",
        "revenue",
        "payment_mode",
        "customer_segment"
    ]
]

# ==========================================
# 16. SORT DATA
# ==========================================

df = df.sort_values(
    by="order_date"
).reset_index(
    drop=True
)

# ==========================================
# 17. SAVE DATASET
# ==========================================

output_path = (
    "data/ecommerce_sales.csv"
)

df.to_csv(
    output_path,
    index=False
)

# ==========================================
# 18. SUMMARY
# ==========================================

print("=" * 60)

print(
    "E-COMMERCE SALES DATASET "
    "GENERATED SUCCESSFULLY"
)

print("=" * 60)

print(
    f"Total Orders     : {len(df)}"
)

print(
    f"Unique Customers : "
    f"{df['customer_id'].nunique()}"
)

print(
    f"Total Units Sold : "
    f"{df['units'].sum()}"
)

print(
    f"Total Revenue    : "
    f"₹{df['revenue'].sum():,.2f}"
)

# ==========================================
# 19. TOP PRODUCTS
# ==========================================

print("\nTop 5 Products by Revenue:")

top_products = (

    df.groupby("product")["revenue"]

    .sum()

    .sort_values(
        ascending=False
    )

    .head(5)
)

print(top_products)

# ==========================================
# 20. CITY ANALYSIS
# ==========================================

print("\nRevenue by City:")

city_revenue = (

    df.groupby(
        "customer_city"
    )["revenue"]

    .sum()

    .sort_values(
        ascending=False
    )
)

print(city_revenue)

# ==========================================
# 21. MONTHLY ANALYSIS
# ==========================================

print("\nRevenue by Month:")

monthly_revenue = (

    df.assign(

        month=pd.to_datetime(
            df["order_date"]
        ).dt.strftime("%Y-%m")

    )

    .groupby("month")["revenue"]

    .sum()

    .sort_values(
        ascending=False
    )
)

print(
    monthly_revenue.head(5)
)

# ==========================================
# 22. FILE LOCATION
# ==========================================

print("\nDataset saved at:")

print(output_path)

# ==========================================
# 23. PREVIEW
# ==========================================

print("\nFirst 5 Records:")

print(
    df.head()
)
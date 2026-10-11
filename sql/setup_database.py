
from pathlib import Path
import sqlite3
import pandas as pd

# Find the main CityFlow folder
PROJECT_ROOT = Path(__file__).resolve().parent.parent

# Define file paths
DATA_PATH = PROJECT_ROOT / "data" / "ncr_ride_bookings.csv"
DATABASE_PATH = PROJECT_ROOT / "sql" / "cityflow.db"

# Check whether the dataset exists
if not DATA_PATH.exists():
    raise FileNotFoundError(
        f"Dataset not found: {DATA_PATH}"
    )

# Load the dataset
df = pd.read_csv(DATA_PATH)

# Create the database and load the bookings table
with sqlite3.connect(DATABASE_PATH) as connection:
    df.to_sql(
        "bookings",
        connection,
        if_exists="replace",
        index=False
    )

print("CityFlow database created successfully!")
print(f"Rows imported: {len(df):,}")
print(f"Database location: {DATABASE_PATH}")

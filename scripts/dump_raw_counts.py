#./env python
import duckdb
import sys

#Create list of table names
raw_tables = [
    "central_park_weather",
    "fhv_bases",
    "fhv_tripdata",
    "fhvhv_tripdata",
    "green_tripdata",
    "yellow_tripdata",
    "bike_data",
]

#Function to fetch # of rows
def main(conn):
    for t in sorted(raw_tables):
        rows = conn.sql(f"SELECT COUNT(*) FROM {t}").fetchone()[0]
        print(t, rows)


if __name__ == "__main__":
    with duckdb.connect('main.db') as conn:
        main(conn)
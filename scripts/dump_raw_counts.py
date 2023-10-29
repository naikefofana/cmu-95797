import duckdb
import pandas as pd

connection = duckdb.connect('main.db')

for table in connection:
    row_count = pd.df.shape[0]

	print(table.name, ' : ', row_count, ' rows.')
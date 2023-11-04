--Load location & weather data from CSV files Read data from central_park_weather and fhv_bases files and saving as string
CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto('./data/data/central_park_weather.csv', union_by_name=True, all_varchar=1, filename=True);
CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto('./data/data/fhv_bases.csv', union_by_name=True, all_varchar=1, filename=True, header=True);

--Load bike data from /bike folder
--Use all_varchar=1 to load all columns as varchar
--Use union_by_name because data before and after 202102 has different format (13 and 15 columns).
CREATE TABLE bike_data AS SELECT * FROM read_csv_auto('./data/data/citibike-tripdata.csv.gz', union_by_name=True, all_varchar=1, union_by_name=True, filename=True);

--Load taxi data from parquet files fhvhv_tripdata files, green_tripdata files, yellow_tripdata files in /taxi folder
--Use union_by_name to merge columns by name in case there's data format inconsistency
CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('./data/data/taxi/fhv_tripdata.parquet', union_by_name=True, filename=True);
CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('./data/data/taxi/fhvhv_tripdata.parquet', union_by_name=True, filename=True);
CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('./data/data/taxi/yellow_tripdata.parquet', union_by_name=True, filename=True);
CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('./data/data/taxi/green_tripdata.parquet', union_by_name=True, filename=True);
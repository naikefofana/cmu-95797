CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto('./data/data/central_park_weather.csv');
CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto('./data/data/fhv_bases.csv');
CREATE TABLE bike_data AS SELECT * FROM read_csv_auto('./data/data/citibike-tripdata.csv.gz');
CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('./data/data/taxi/fhv_tripdata.parquet');
CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('./data/data/taxi/fhvhv_tripdata.parquet');
CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('./data/data/taxi/yellow_tripdata.parquet');
CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('./data/data/taxi/green_tripdata.parquet');
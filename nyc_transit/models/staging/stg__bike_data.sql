--Define table
with source as (
    SELECT * FROM {{source('main','bike_data')}}
),

renamed as (
    SELECT
        --Define column format, rename columns, adapt to new table format, remove duplicate columns
        tripduration::int AS tripduration,
        starttime::timestamp AS started_at,
        stoptime::timestamp AS ended_at,
        "start station id"::int AS start_station_id,
        "start station name" AS start_station_name,
        "start station latitude"::decimal AS start_lat,
        "start station longitude"::decimal AS start_lng,
        "end station id"::int AS end_station_id,
        "end station name" AS end_station_name,
        "end station latitude"::decimal AS end_lat,
        "end station longitude"::decimal AS end_lng,
        bikeid::int,
        REPLACE(REPLACE(usertype, 'Subscriber', 'member'), 'Customer', 'casual') AS member_casual,
        "birth year"::int AS birth_year,
        REPLACE(REPLACE(REPLACE(gender, '0', 'unknown'), '1', 'male'), '2', 'female') AS gender,
        ride_id,
        rideable_type,
        filename

    FROM source
)

SELECT * FROM renamed
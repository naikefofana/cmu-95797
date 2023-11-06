--Define table
with source as (
    SELECT * FROM {{source('main','fhvhv_tripdata')}}
),

renamed as (
    SELECT
        --Normalize case in strings and switch  Yes/No column to boolean and change format
        UPPER(hvfhs_license_num) AS hvfhs_license_num,
        UPPER(dispatching_base_num) AS dispatching_base_num,
        UPPER(originating_base_num) AS originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        PULocationID,
        DOLocationID,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        REPLACE(REPLACE(shared_request_flag,'Y',TRUE), 'N', FALSE) AS shared_request_flag,
        REPLACE(REPLACE(shared_match_flag,'Y',TRUE), 'N', FALSE) AS shared_match_flag,
        REPLACE(REPLACE(access_a_ride_flag,'Y',TRUE), 'N', FALSE) AS access_a_ride_flag,
        REPLACE(REPLACE(wav_request_flag,'Y',TRUE), 'N', FALSE) AS wav_request_flag,
        REPLACE(REPLACE(wav_match_flag,'Y',TRUE), 'N', FALSE) AS wav_match_flag,
        filename,

    FROM source

    -- Get rid of all the illogical pickup/dropoff and request/pickup, negative distance and negative amounts
    WHERE pickup_datetime < dropoff_datetime
        AND pickup_datetime > request_datetime
        AND base_passenger_fare > 0
        AND driver_pay > 0
)

SELECT * FROM renamed
--Define table
with source as (
    SELECT * FROM {{source('main','fhvhv_tripdata')}}
),

renamed as (
    SELECT
        --Normalize case in strings and switch  Yes/No column to boolean and change format
        hvfhs_license_num,
        TRIM(UPPER(dispatching_base_num)) AS dispatching_base_num,
        TRIM(UPPER(originating_base_num)) AS originating_base_num,
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
        {{flag_to_bool("shared_request_flag")}} as shared_request_flag,
        {{flag_to_bool("shared_match_flag")}} as shared_match_flag,
        {{flag_to_bool("access_a_ride_flag")}} as access_a_ride_flag,
        {{flag_to_bool("wav_request_flag")}} as wav_request_flag,
        {{flag_to_bool("wav_match_flag",)}} as wav_match_flag,
        filename,

    FROM source
)

SELECT * FROM renamed
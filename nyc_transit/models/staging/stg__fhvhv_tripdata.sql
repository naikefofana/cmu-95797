--Define table
with source as (
    SELECT * FROM {{source('main','fhvhv_tripdata')}}
),

renamed as (
    SELECT
        hvfhs_license_num,
        TRIM(UPPER(dispatching_base_num)) AS dispatching_base_num, --Normalize case
        TRIM(UPPER(originating_base_num)) AS originating_base_num, --Normalize case
        request_datetime,
        on_scene_datetime,
        pickup_datetime::date AS pickup_datetime, --put date as same format as base in order to use as foreign key
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
        {{flag_to_bool("shared_request_flag")}} as shared_request_flag, --Turn into boolean
        {{flag_to_bool("shared_match_flag")}} as shared_match_flag, --Turn into boolean
        {{flag_to_bool("access_a_ride_flag")}} as access_a_ride_flag, --Lots of empty strings in original file
        {{flag_to_bool("wav_request_flag")}} as wav_request_flag, --Turn into boolean
        {{flag_to_bool("wav_match_flag",)}} as wav_match_flag, --Turn into boolean
        filename,

    FROM source
)

SELECT * FROM renamed
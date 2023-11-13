--Define table
with source as (
    SELECT * FROM {{source('main','green_tripdata')}}
),

renamed as (
    SELECT
        VendorID,
        lpep_pickup_datetime::date AS lpep_pickup_datetime, --put date as same format as base in order to use as foreign key
        lpep_dropoff_datetime,
        {{flag_to_bool("store_and_fwd_flag")}} as store_and_fwd_flag, --Turn into boolean
        RatecodeID,
        PULocationID,
        DOLocationID,
        passenger_count::int AS passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        --ehail_fee, --removed due to 100% null source data
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type,
        congestion_surcharge,
        filename,

    FROM source

    -- Get rid of all the future dates, illogical pickup/dropoff, negative distance and negative amounts
    WHERE lpep_dropoff_datetime < '2022-12-31 23:59:59' 
        AND trip_distance >= 0
)

SELECT * FROM renamed
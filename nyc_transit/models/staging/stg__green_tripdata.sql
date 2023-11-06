--Define table
with source as (
    SELECT * FROM {{source('main','green_tripdata')}}
),

renamed as (
    SELECT
        --Switch Yes/No column to boolean and change format
        VendorID,
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        REPLACE(REPLACE(store_and_fwd_flag,'Y',TRUE), 'N', FALSE) AS store_and_fwd_flag,
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
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type,
        congestion_surcharge,
        filename,

    FROM source

    -- Get rid of all the future dates, illogical pickup/dropoff, negative distance and negative amounts
    WHERE lpep_dropoff_datetime < '2022-12-31 23:59:59' 
        AND lpep_pickup_datetime < lpep_dropoff_datetime
        AND trip_distance > 0
        AND total_amount > 0
        AND fare_amount > 0
        AND extra > 0
        AND mta_tax > 0
        AND tip_amount > 0
        AND tolls_amount > 0
        AND improvement_surcharge > 0
)

SELECT * FROM renamed
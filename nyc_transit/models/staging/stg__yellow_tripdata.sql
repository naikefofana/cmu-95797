--Define table
with source as (
    SELECT * FROM {{source('main','yellow_tripdata')}}
),

renamed as (
    SELECT
        --Switch Yes/No column to boolean and change format
        VendorID,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count::int AS passenger_count,
        trip_distance,
        RatecodeID,
        REPLACE(REPLACE(store_and_fwd_flag,'Y',TRUE), 'N', FALSE) AS store_and_fwd_flag,
        PULocationID,
        DOLocationID,
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee,
        filename,

    FROM source

    -- Get rid of all the future dates, illogical pickup/dropoff, negative distance and negative amounts
    WHERE tpep_dropoff_datetime < '2022-12-31 23:59:59' 
        AND tpep_pickup_datetime < tpep_dropoff_datetime
        AND trip_distance > 0
        AND total_amount > 0
        AND fare_amount > 0
        AND extra > 0
        AND mta_tax > 0
        AND tip_amount > 0
        AND tolls_amount > 0
        AND improvement_surcharge > 0
        AND airport_fee > 0
        AND congestion_surcharge > 0
)

SELECT * FROM renamed
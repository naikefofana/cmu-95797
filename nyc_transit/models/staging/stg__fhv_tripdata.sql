--Define table
with source as (
    SELECT * FROM {{source('main','fhv_tripdata')}}
),

renamed as (
    SELECT
        --Normalize case in strings
        UPPER(dispatching_base_num) AS dispatching_base_num,
        pickup_datetime,
        dropOff_datetime,
        PUlocationID,
        DOlocationID,
        UPPER(Affiliated_base_number) AS Affiliated_base_number,
        filename

    FROM source

    -- Get rid of all the future dates, illogical pickup/dropoff, negative distance and negative amounts
    WHERE dropoff_datetime < '2022-12-31 23:59:59' 
        AND pickup_datetime < dropoff_datetime
)

SELECT * FROM renamed
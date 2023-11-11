--Define table
with source as (
    SELECT * FROM {{source('main','fhv_tripdata')}}
),

renamed as (
    SELECT
        --Normalize case in strings
        TRIM(UPPER(dispatching_base_num)) AS dispatching_base_num,
        pickup_datetime,
        dropOff_datetime,
        PUlocationID,
        DOlocationID,
        --sr_flag, always null so chuck it
        TRIM(UPPER(Affiliated_base_number)) AS Affiliated_base_number,
        filename

    FROM source
)

SELECT * FROM renamed
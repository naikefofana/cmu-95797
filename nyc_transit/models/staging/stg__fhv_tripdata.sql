--Define table
with source as (
    SELECT * FROM {{source('main','fhv_tripdata')}}
),

renamed as (
    SELECT
        TRIM(UPPER(dispatching_base_num)) AS dispatching_base_num, --Normalize cas and delete space
        pickup_datetime::date AS pickup_datetime, --put date as same format as base in order to use as foreign key
        dropOff_datetime,
        PUlocationID,
        DOlocationID,
        --sr_flag, always null
        TRIM(UPPER(Affiliated_base_number)) AS Affiliated_base_number, --Normalize cas and delete space
        filename

    FROM source
)

SELECT * FROM renamed
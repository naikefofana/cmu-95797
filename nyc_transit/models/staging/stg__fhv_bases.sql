with source as (
    SELECT * FROM {{source('main','fhv_bases')}}
),

renamed as (
    SELECT
        --Normalize case and delete coma and double space from dba
        TRIM(UPPER(base_number)) AS base_number,
        base_name,
        dba,
        dba_category,
        filename,
    FROM source
)

SELECT * FROM renamed
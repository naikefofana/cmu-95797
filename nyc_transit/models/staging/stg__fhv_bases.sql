with source as (
    SELECT * FROM {{source('main','fhv_bases')}}
),

renamed as (
    SELECT
        --Normalize case and delete coma and double space from dba
        UPPER(base_number) AS base_number,
        UPPER(base_name) AS base_name,
        UPPER(REPLACE(REPLACE(dba,',',''), '  ', ' ')) AS dba,
        LOWER(dba_category) AS dba_category,
        filename,
    FROM source
)

SELECT * FROM renamed
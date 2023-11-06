-- Copied the code from the class lecture and added some functions

with source as (
    SELECT * FROM {{source('main','central_park_weather')}}
),

renamed as (
    SELECT
        --Normalize case and define column formats
        UPPER(station) AS station,
        UPPER(name) AS name,
        date::date AS date,
        awnd::double AS awnd,
        prcp::double AS prcp,
        snow::double AS snow,
        snwd::double AS snwd,
        tmax::int AS tmax,
        tmin::int AS tmin,
        filename

    FROM source
)

SELECT * FROM renamed
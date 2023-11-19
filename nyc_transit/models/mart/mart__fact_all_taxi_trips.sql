WITH trips_renamed AS
(

    SELECT -- Column headers
        'fhv' AS type,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid
    FROM {{ ref('stg__fhv_tripdata') }}

    UNION ALL

    SELECT 
        'fhvhv' AS type,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid
    FROM {{ ref('stg__fhvhv_tripdata') }}

    UNION ALL

    SELECT 
        'green' AS type,
        lpep_pickup_datetime AS pickup_datetime,
        lpep_dropoff_datetime AS dropoff_datetime,
        pulocationid,
        dolocationid
    FROM {{ ref('stg__green_tripdata') }}

    UNION ALL

    SELECT 
        'yellow' AS type,
        tpep_pickup_datetime AS pickup_datetime,
        tpep_dropoff_datetime AS dropoff_datetime,
        pulocationid,
        dolocationid
    FROM {{ ref('stg__yellow_tripdata') }}

)

SELECT
    type,
    pickup_datetime,
    dropoff_datetime,
    datediff('minute', pickup_datetime, dropoff_datetime) AS duration_min, --Calculate the duration in minutes
    datediff('second', pickup_datetime, dropoff_datetime) AS duration_sec, --Calculate the duration in seconds
    pulocationid,
    dolocationid
FROM trips_renamed
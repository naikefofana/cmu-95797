WITH trips_renamed AS
(

    SELECT -- Column headers
        'bike' AS type,
        started_at_ts,
        ended_at_ts
    FROM {{ ref('stg__bike_data') }}
    
    UNION ALL
    
    SELECT -- Column headers
        'fhv' AS type,
        pickup_datetime AS started_at_ts,
        dropoff_datetime AS ended_at_ts
    FROM {{ ref('stg__fhv_tripdata') }}
    
    UNION ALL

    SELECT 
        'fhvhv' AS type,
        pickup_datetime AS started_at_ts,
        dropoff_datetime AS ended_at_ts
    FROM {{ ref('stg__fhvhv_tripdata') }}
    
    UNION ALL

    SELECT 
        'green' AS type,
        lpep_pickup_datetime AS started_at_ts,
        lpep_dropoff_datetime AS ended_at_ts,
    FROM {{ ref('stg__green_tripdata') }}
    
    UNION ALL

    SELECT 
        'yellow' AS type,
        tpep_pickup_datetime AS started_at_ts,
        tpep_dropoff_datetime AS ended_at_ts,
    FROM {{ ref('stg__yellow_tripdata') }}
    
)

SELECT
    type,
    started_at_ts,
    ended_at_ts,
    datediff('minute', started_at_ts, ended_at_ts) AS duration_min, --Calculate the duration in minutes
    datediff('second', started_at_ts, ended_at_ts) AS duration_sec, --Calculate the duration in seconds
FROM trips_renamed
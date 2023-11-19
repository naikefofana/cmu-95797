SELECT 
    DISTINCT
    start_station_id AS station_id,
    start_station_id_station_name AS station_name,
    start_lat AS station_lat,
    start_lng AS station_lng,
FROM {{ ref('stg__bike_data') }}

UNION

SELECT
    DISTINCT
    end_station_id AS station_id,
    end_station_id_station_name AS station_name,
    end_lat AS station_lat,
    end_lng AS station_lng,
FROM {{ ref('stg__bike_data') }}
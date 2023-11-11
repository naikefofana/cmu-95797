--Define table
with source as (
    SELECT * FROM {{source('main','bike_data')}}
),

renamed as (
    SELECT
        tripduration,
        starttime,
        stoptime,
        "start station id",
        "start station name",
        "start station latitude",
        "start station longitude",
        "end station id",
        "end station name",
        "end station latitude",
        "end station longitude",
        bikeid,
        usertype,
        "birth year",
        gender,
        ride_id,
        rideable_type,
        started_at,
        ended_at,
        start_station_name,
        start_station_id,
        end_station_name,
        end_station_id,
        start_lat,
        start_lng,
        end_lat,
        end_lng,
        member_casual,
        filename

    FROM source
)

SELECT 
    COALESCE(starttime, started_at)::timestamp AS started_at_ts,
	COALESCE(stoptime, ended_at)::timestamp AS ended_at_ts,
	COALESCE(tripduration::int,datediff('second', started_at_ts, ended_at_ts)) tripduration,
	COALESCE("start station id", start_station_id) AS start_station_id,  
	COALESCE("start station name", start_station_name) AS start_station_name,
	COALESCE("start station latitude", start_lat)::double AS start_lat,
	COALESCE("start station longitude", start_lng)::double AS start_lng, 
	COALESCE("end station id", end_station_id) AS end_station_id,  
	COALESCE("end station name", end_station_name) AS end_station_name,
	COALESCE("end station latitude", end_lat)::double AS end_lat,
	COALESCE("end station longitude", end_lng)::double AS end_lng,
	filename
FROM renamed
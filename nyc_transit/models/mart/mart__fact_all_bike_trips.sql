SELECT
    started_at_ts,
    ended_at_ts,
    datediff('minute', started_at_ts, ended_at_ts) as duration_min,
    datediff('second', started_at_ts, ended_at_ts) as duration_sec,
    start_station_id,
    end_station_id
FROM {{ ref('nyc_transit','stg__bike_data')}}
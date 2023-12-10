-- Use Window functions with QUALIFY and ROW_NUMBER to remove duplicate rows. Prefer rows with a later time stamp

SELECT * 
FROM events
QUALIFY row_number() 
    OVER (PARTITION BY event_id
    ORDER BY insert_timestamp desc)
    = 1
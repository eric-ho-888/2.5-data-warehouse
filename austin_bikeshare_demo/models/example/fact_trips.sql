SELECT
    trip_id,
    subscriber_type,
    bike_id,
    start_time,
    start_station_id,
    end_station_id,
    duration_minutes
FROM
    {{ source('austin_bikeshare', 'bikeshare_trips') }}
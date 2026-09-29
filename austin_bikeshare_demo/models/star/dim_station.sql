WITH station_base AS (

    SELECT
        station_id,
        name AS station_name,
        status,
        address
    FROM {{ source('austin_bikeshare', 'bikeshare_stations') }}

),

trip_stats AS (

    SELECT
        SAFE_CAST(start_station_id AS INT64) AS station_id,

        SUM(duration_minutes * 60) AS total_duration,

        COUNT(start_station_name) AS total_starts

    FROM {{ source('austin_bikeshare', 'bikeshare_trips') }}

    WHERE SAFE_CAST(start_station_id AS INT64) IS NOT NULL

    GROUP BY SAFE_CAST(start_station_id AS INT64)

),

trip_ends AS (

    SELECT
        SAFE_CAST(end_station_id AS INT64) AS station_id,

        COUNT(end_station_name) AS total_ends

    FROM {{ source('austin_bikeshare', 'bikeshare_trips') }}

    WHERE SAFE_CAST(end_station_id AS INT64) IS NOT NULL

    GROUP BY SAFE_CAST(end_station_id AS INT64)

)

SELECT
    sb.station_id,
    sb.station_name,
    sb.status,
    sb.address,
    ts.total_duration,
    ts.total_starts,
    te.total_ends

FROM station_base sb

LEFT JOIN trip_stats ts
    ON sb.station_id = ts.station_id

LEFT JOIN trip_ends te
    ON sb.station_id = te.station_id

ORDER BY total_duration DESC
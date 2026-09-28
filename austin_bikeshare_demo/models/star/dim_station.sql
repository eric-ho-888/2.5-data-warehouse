SELECT
    station_id,
    name,
    location,
    address,
    property_type,
    number_of_docks,
    dbt_valid_from,
    dbt_valid_to
FROM
    {{ ref('station_snapshot') }}
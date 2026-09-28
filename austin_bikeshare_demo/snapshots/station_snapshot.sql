{% snapshot station_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='station_id',
      strategy='check',
      check_cols='all'
    )
  }}

  SELECT *
  FROM {{ source('austin_bikeshare', 'bikeshare_stations') }}

{% endsnapshot %}
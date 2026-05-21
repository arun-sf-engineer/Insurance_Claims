{{
    config(
            materialized = 'table',
            database = var('tasty_bytes_db'),
            schema = var('bronze_sch'),
            alias = 'truck',
            tags = ['bronze']
    )
}}

SELECT
    $1 AS truck_id,
    $2 AS menu_type_id,
    $3 AS primary_city,
    $4 AS region,
    $5 AS iso_region,
    $6 AS country,
    $7 AS iso_country_code,
    $8 AS franchise_flag,
    $9 AS year,
    $10 AS make,
    $10 AS model,
    $11 AS ev_flag,
    $12 AS franchise_id,
    $13 AS truck_opening_date
FROM @tb_101.public.s3load/raw_pos/truck/
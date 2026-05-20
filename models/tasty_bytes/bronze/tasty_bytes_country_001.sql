{{
    config(
            materialized = 'table',
            database = var('tasty_bytes_db'),
            schema = var('bronze_sch'),
            alias = 'Country',
            tags = ['bronze']

    )
}}


SELECT
    $1 AS country_id, 
    $2 AS country,
    $3 AS iso_currency, 
    $4 AS iso_country, 
    $5 AS city_id, 
    $6 AS city, 
    $7 AS city_population
FROM @tb_101.public.s3load/raw_pos/country/
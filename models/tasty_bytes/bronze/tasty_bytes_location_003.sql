{{
    config(
            materialized = 'table',
            database = var('tasty_bytes_db'),
            schema = var('bronze_sch'),
            alias = 'location',
            tags = ['bronze']
    )
}}

with location as (
SELECT 
$1 AS location_id,
$2 AS placekey,
$3 AS location,
$4 AS city,
$5 AS region,
$6 AS iso_country_code,
$7 AS country,
current_timestamp() as load_ts
FROm @tb_101.public.s3load/raw_pos/location/)
select * from location
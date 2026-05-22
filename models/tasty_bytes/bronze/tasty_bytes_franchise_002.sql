{{
    config(
            materialized = 'table',
            database = var('tasty_bytes_db'),
            schema = var('bronze_sch'),
            alias = 'franchise',
            tags = ['bronze']
    )
}}
WITH franchise as (
SELECT DISTINCT
    $1 AS franchise_id,
    $2 AS first_name,
    $3 AS last_name,
    $4 AS city,
    $5 AS country,
    $6 AS e_mail,
    $7 AS phone_number,
    current_timestamp() as Load_TS
FROM @tb_101.public.s3load/raw_pos/franchise/)
SELECT * from franchise
{{
    config(
            materialized = 'table',
            database = var('tasty_bytes_db'),
            schema = var('bronze_sch'),
            alias = 'customer',
            tags = ['bronze']
    )
}}

with customer as (
SELECT
    $1 AS customer_id,
    $2 AS first_name,
    $3 AS last_name,
    $4 AS city,
    $5 AS country,
    $6 AS postal_code,
    $7 AS preferred_language,
    $8 AS gender,
    $9 AS favourite_brand,
    $10 AS marital_status,
    $11 AS children_count,
    $12 AS sign_up_date,
    $13 AS birthday_date,
    $14 AS e_mail,
    $15 AS phone_number,
    current_timestamp() as load_ts
FROM @tb_101.public.s3load/raw_customer/customer_loyalty/)
select * from customer


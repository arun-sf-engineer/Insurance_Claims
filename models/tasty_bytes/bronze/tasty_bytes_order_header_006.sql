{{
    config(
            materialized = 'table',
            database = var('tasty_bytes_db'),
            schema = var('bronze_sch'),
            alias = 'order_header',
            tags = ['bronze']
    )
}}

with order_header as (
SELECT 
    $1 AS order_id,
    $2 AS truck_id,
    $3 AS location_id,
    $4 AS customer_id,
    $5 AS discount_id,
    $6 AS shift_id,
    $7 AS shift_start_time,
    $8 AS shift_end_time,
    $9 AS order_channel,
    $10 AS order_ts,
    $11 AS served_ts,
    $12 AS order_currency,
    $13 AS order_amount,
    $14 AS order_tax_amount,
    $15 AS order_discount_amount,
    $16 AS order_total,
    current_timestamp() as load_ts
FROM 
@tb_101.public.s3load/raw_pos/order_header/)
select * from order_header
{{
    config(
            materialized = 'table',
            database = var('tasty_bytes_db'),
            schema = var('bronze_sch'),
            alias = 'order_detail',
            tags = ['bronze']
    )
}}

with order_detail as (
SELECT
$1 order_detail_id,
$2 AS order_id,
$3 AS menu_item_id,
$4 AS discount_id,
$5 AS line_number,
$6 AS quantity,
$7 AS unit_price,
$8 AS price,
$9 AS order_item_discount_amount,
current_timestamp() as load_ts
FROM @tb_101.public.s3load/raw_pos/order_detail/)
select * from order_detail

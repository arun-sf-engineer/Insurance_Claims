{{
    config(
            materialized = 'table',
            database = var('tasty_bytes_db'),
            schema = var('bronze_sch'),
            alias = 'menu',
            tags = ['bronze']
    )
}}
WITH menu as (
SELECT $1 AS menu_id,
    $2 AS menu_type_id,
    $3 AS menu_type,
    $4 AS truck_brand_name,
    $5 AS menu_item_id,
    $6 AS menu_item_name,
    $7 AS item_category,
    $8 AS item_subcategory,
    $9 AS cost_of_goods_usd,
    $10 AS sale_price_usd,
    $10 AS menu_item_health_metrics_obj
FROM @tb_101.public.s3load/raw_pos/menu/)
select * from menu

{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'MENU_ITEM_ID',
            alias = 'menu_item'
        )
}}

WITH menu_item as (
SELECT 
    MENU_ITEM_ID, 
    MENU_ITEM_NAME, 
    ITEM_CATEGORY, 
    ITEM_SUBCATEGORY, 
    COST_OF_GOODS_USD, 
    SALE_PRICE_USD, 
    MENU_ITEM_HEALTH_METRICS_OBJ, 
    LOAD_TS,
    current_timestamp() as update_ts
FROM {{ref('tasty_bytes_menu_004')}}
ORDER BY MENU_ITEM_ID)
select * from menu_item
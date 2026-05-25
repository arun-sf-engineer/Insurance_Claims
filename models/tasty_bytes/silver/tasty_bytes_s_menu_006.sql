{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'MENU_ID',
            alias = 'menu'
    )
}}

WITH MENU AS
(
SELECT 
    MENU_ID,
    MENU_TYPE_ID,
    TRUCK_BRAND_NAME,
    MENU_ITEM_ID,
    load_ts,
    current_timestamp() as update_ts 
FROM {{ref('tasty_bytes_menu_004')}}
)
SELECT * FROM MENU
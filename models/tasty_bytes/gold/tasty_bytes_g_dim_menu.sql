{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'MENU_ITEM_ID',
            alias = 'dim_menu_item'
    )
}}

with menu as
(
select
    MENU_ID,
    MENU_TYPE_ID,
    MENU_ITEM_ID,
    TRUCK_BRAND_NAME
from {{ref('tasty_bytes_s_menu_006')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY menu_id order by LOAD_TS DESC) = 1
),
menu_type AS
(
select
    MENU_TYPE_ID,
    MENU_TYPE
from {{ref('tasty_bytes_s_menu_type_004')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY menu_type_id order by load_ts desc) = 1
),
menu_item as
(
select
    MENU_ITEM_ID,
    MENU_ITEM_NAME,
    ITEM_CATEGORY,
    ITEM_SUBCATEGORY,
    COST_OF_GOODS_USD,
    SALE_PRICE_USD,
    MENU_ITEM_HEALTH_METRICS_OBJ
from {{ref('tasty_bytes_s_menu_item_005')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY MENU_ITEM_ID ORDER BY LOAD_TS DESC) = 1
)
SELECT
    M.MENU_ITEM_ID,
    M.TRUCK_BRAND_NAME,
    MT.MENU_TYPE,
    MI.MENU_ITEM_NAME,
    MI.ITEM_CATEGORY,
    MI.ITEM_SUBCATEGORY,
    MI.COST_OF_GOODS_USD,
    MI.SALE_PRICE_USD,
    MI.MENU_ITEM_HEALTH_METRICS_OBJ
FROM MENU AS M
JOIN menu_type AS MT ON MT.MENU_TYPE_ID = m.MENU_TYPE_ID
JOIN menu_item AS MI ON MI.MENU_ITEM_ID = M.MENU_ITEM_ID
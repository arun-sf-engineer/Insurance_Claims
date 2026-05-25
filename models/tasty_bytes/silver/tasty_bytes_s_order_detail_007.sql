{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'ORDER_DETAIL_ID',
            alias = 'order_detail'
    )
}}

select 
    ORDER_DETAIL_ID, 
    ORDER_ID, 
    MENU_ITEM_ID, 
    DISCOUNT_ID, 
    LINE_NUMBER, 
    QUANTITY, 
    UNIT_PRICE, 
    PRICE, 
    ORDER_ITEM_DISCOUNT_AMOUNT,
    load_ts,
    current_timestamp() AS update_ts
from {{ref('tasty_bytes_order_detail_007')}}
{{ 
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'ORDER_ID',
            alias = 'order_header'
    )
}}
select
    ORDER_ID, 
    TRUCK_ID, 
    LOCATION_ID, 
    CUSTOMER_ID, 
    DISCOUNT_ID, 
    SHIFT_ID, 
    SHIFT_START_TIME, 
    SHIFT_END_TIME, 
    ORDER_CHANNEL, 
    ORDER_TS, 
    SERVED_TS, 
    ORDER_CURRENCY, 
    ORDER_AMOUNT, 
    ORDER_TAX_AMOUNT, 
    ORDER_DISCOUNT_AMOUNT, 
    ORDER_TOTAL, 
    LOAD_TS,
    current_timestamp() as update_ts
from {{ref('tasty_bytes_order_header_006')}}

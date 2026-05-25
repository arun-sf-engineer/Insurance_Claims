{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'ORDER_DETAIL_ID',
            alias = 'fact_order_details'
    )
}}
WITH order_details as
(
SELECT
*
FROM {{ref('tasty_bytes_s_order_detail_007')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY ORDER_DETAIL_ID ORDER BY LOAD_TS DESC) = 1
),
order_header as
(
SELECT
*
FROM {{ref('tasty_bytes_s_order_header_008')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY ORDER_ID ORDER BY LOAD_TS DESC) = 1
)
SELECT
    O_D.ORDER_DETAIL_ID,
    O_D.ORDER_ID,
    O_D.MENU_ITEM_ID,
    O_H.TRUCK_ID,
    O_H.LOCATION_ID,
    O_H.CUSTOMER_ID,
    O_H.SHIFT_ID,
    O_H.SHIFT_START_TIME,
    O_H.SHIFT_END_TIME,
    O_H.ORDER_TS,
    O_H.SERVED_TS,
    O_H.ORDER_CURRENCY,
    O_H.ORDER_AMOUNT, 
    O_H.ORDER_TAX_AMOUNT, 
    O_H.ORDER_DISCOUNT_AMOUNT, 
    O_H.ORDER_TOTAL,
    O_D.LINE_NUMBER,
    O_D.QUANTITY,
    O_D.UNIT_PRICE,
    O_D.PRICE,
    O_D.ORDER_ITEM_DISCOUNT_AMOUNT
FROM order_details AS O_D
JOIN order_header AS O_H ON O_H.ORDER_ID = O_D.ORDER_ID
WHERE O_H.CUSTOMER_ID IS NOT NULL
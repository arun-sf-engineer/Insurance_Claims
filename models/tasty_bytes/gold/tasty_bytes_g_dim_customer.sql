{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'Customer_ID',
            alias = 'dim_customer'       
    )
}}

WITH customer as 
(
SELECT 
* from {{ref('tasty_bytes_s_customer_009')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY Customer_ID ORDER BY UPDATE_TS DESC) = 1
)
SELECT * FROM customer

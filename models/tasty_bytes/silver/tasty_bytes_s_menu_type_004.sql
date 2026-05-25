{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'MENU_TYPE_ID',
            alias = 'menu_type'
    )
}}

WITH Menu_type as (
SELECT
    DISTINCT 
    m.MENU_TYPE_ID,
    m.Menu_Type,
    LOAD_TS,
    current_timestamp() as update_ts
FROM {{ref('tasty_bytes_menu_004')}} AS m)
SELECT * FROM Menu_type
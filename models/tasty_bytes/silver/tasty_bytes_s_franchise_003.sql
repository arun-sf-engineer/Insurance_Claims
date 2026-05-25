{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'FRANCHISE_ID',
            alias = 'franchise'
    )
}}

WITH Franchise as
(
SELECT
    FRANCHISE_ID,
    FIRST_NAME,
    LAST_NAME,
    CITY AS City_Name,
    COUNTRY AS Country_Name,
    E_MAIL,
    PHONE_NUMBER,
    LOAD_TS,
    current_timestamp() as update_ts
FROM {{ref('tasty_bytes_franchise_002')}}
)
SELECT * from Franchise
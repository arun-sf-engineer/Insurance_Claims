{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'country_id',
            alias = 'country'
    )
}}

SELECT
    DISTINCT country_id,
    Country as country_name,
    iso_currency as currency_code,
    iso_country as country_code,
    load_ts,
    current_timestamp() as update_ts
FROM {{ref('tasty_bytes_country_001')}}
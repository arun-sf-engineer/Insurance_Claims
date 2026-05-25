{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'CITY_ID',
            alias = 'dim_location'
    )
}}

WITH city as
(
SELECT
    CITY_ID,
    COUNTRY_ID,
    CITY_NAME,
    CITY_POPULATION
FROM {{ref('tasty_bytes_s_city_001')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY CITY_ID ORDER BY LOAD_TS DESC) = 1
),
Country as
(
SELECT
    COUNTRY_ID,
    COUNTRY_NAME,
    CURRENCY_CODE,
    COUNTRY_CODE
FROM {{ref('tasty_bytes_s_country_002')}}
)
SELECT
    CITY_ID,
    CITY_NAME,
    CITY_POPULATION,
    COUNTRY_NAME,
    CURRENCY_CODE,
    COUNTRY_CODE
FROM city AS C
JOIN Country AS CO ON C.COUNTRY_ID = CO.COUNTRY_ID
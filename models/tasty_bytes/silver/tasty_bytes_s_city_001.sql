{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'City_Id',
            alias = 'city'
    )
}}

With City AS
(
select
    City_Id,
    Country_Id,
    City as City_Name,
    City_Population,
    Load_Ts,
    current_timestamp() as update_ts
from {{ref('tasty_bytes_country_001')}}
)
SELECT * from City
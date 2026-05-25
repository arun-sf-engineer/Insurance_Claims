{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'customer_id',
            alias = 'customer'
    )
}}

select 
    CUSTOMER_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    CITY, 
    COUNTRY, 
    POSTAL_CODE, 
    PREFERRED_LANGUAGE, 
    GENDER, 
    FAVOURITE_BRAND, 
    MARITAL_STATUS, 
    CHILDREN_COUNT, 
    SIGN_UP_DATE, 
    BIRTHDAY_DATE, 
    E_MAIL, 
    PHONE_NUMBER, 
    LOAD_TS,
    current_timestamp() as update_ts
from {{ref('tasty_bytes_customer_008')}}
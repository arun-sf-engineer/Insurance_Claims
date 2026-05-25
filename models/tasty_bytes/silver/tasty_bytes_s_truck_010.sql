{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'Truck_Id',
            alias = 'Truck'
    )
}}
WITH Truck as(
select 
    TRUCK_ID, 
    MENU_TYPE_ID, 
    PRIMARY_CITY, 
    REGION, 
    ISO_REGION, 
    COUNTRY, 
    ISO_COUNTRY_CODE, 
    FRANCHISE_FLAG, 
    YEAR, 
    MAKE, 
    MODEL, 
    EV_FLAG, 
    FRANCHISE_ID, 
    TRUCK_OPENING_DATE, 
    LOAD_TS,
    current_timestamp() as update_ts
    from {{ref('tasty_bytes_truck_005')}}
)
SELECT * from truck
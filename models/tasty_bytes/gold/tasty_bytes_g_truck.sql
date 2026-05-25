{{
    config(
            materialized = 'incremental',
            incremental_strategy = 'merge',
            unique_key = 'Truck_Id',
            alias = 'dim_truck'
    )
}}
With Truck as 
(
SELECT 
*
FROM {{ref('tasty_bytes_s_truck_010')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY TRUCK_ID ORDER BY LOAD_TS DESC) = 1
),
franchise AS
(
SELECT
*
FROM {{ref('tasty_bytes_s_franchise_003')}}
QUALIFY ROW_NUMBER() OVER(PARTITION BY FRANCHISE_ID ORDER BY LOAD_TS DESC) = 1
)
SELECT
    T.TRUCK_ID,
    T.PRIMARY_CITY, 
    T.REGION, 
    T.ISO_REGION, 
    T.COUNTRY, 
    T.ISO_COUNTRY_CODE, 
    T.FRANCHISE_FLAG, 
    T.YEAR, 
    T.MAKE, 
    T.MODEL, 
    T.EV_FLAG, 
    T.TRUCK_OPENING_DATE,
    F.FIRST_NAME AS Franchise_First_Name,
    F.LAST_NAME AS Franchise_Last_Name,
    F.CITY_NAME AS Franchise_City_Name,
    F.COUNTRY_NAME AS Franchise_Country_Name,
    F.E_MAIL AS Franchise_Email,
    F.PHONE_NUMBER AS Franchise_Phone_Number
FROM Truck AS T
JOIN franchise AS F ON T.FRANCHISE_ID = F.FRANCHISE_ID
{{
    config(
            materialized = 'table',
            database = var('claims_db'),
            schema = var('hist_sch'),
            alias = 'Claims_Status_Master',
            tags = 'History'
    )
}}

WITH Claims_Status as
(
select
    STATUS_ID,
    DESCRPTION,
    CODE,
    Current_timestamp() as Load_TS
from {{source('claims','CLAIM_STATUS_MASTER')}} AS CT)
SELECT * FROM Claims_Status
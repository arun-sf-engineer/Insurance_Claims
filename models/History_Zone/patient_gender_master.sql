{{
    config(
            materialized = 'table',
            database = var('claims_db'),
            schema = var('hist_sch'),
            alias = 'patient_gender_master',
            tags = 'History'
    )
}}

with patient_gender as
(
SELECT
    Gender_Id,
    Description,
    Code,
    current_timestamp() as Load_TS
FROM {{source('claims','PATIENT_GENDER_MASTER')}}
)
SELECT * FROM patient_gender

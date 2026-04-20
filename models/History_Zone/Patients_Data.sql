{{
    config(
            materialized = 'table',
            database = var('claims_db'),
            schema = var('hist_sch'),
            alias = 'Patients_data_tbl'
    )   
}}

WITH Patients_records as
(
select
    PATIENTID AS PATIENT_ID,
    PATIENTAGE AS AGE,
    PATIENTGENDER AS GENDER,
    PATIENTINCOME AS INCOME,
    PATIENTMARITALSTATUS AS MARITAL_STATUS,
    PATIENTEMPLOYMENTSTATUS AS EMPLOYMENT_STATUS
FROM {{source('claims','insuranceclaimsdata')}}
)
SELECT * FROM Patients_records
{{ config(
    materialized='table'
) }}

WITH source AS (

    SELECT
        emp_id,
        emp_name,
        department,
        salary,
        hire_date
    FROM {{ ref('all_dept_data') }}

)

SELECT *
FROM source
{{
    config (
        materialized = 'table'
    )
}}


WITH source AS (
    SELECT
        emp_id,
        emp_name,
        department,
        designation,
        salary,
        ph_no,
        hire_date
    FROM {{ source('company_src', 'EMPLOYEES') }}
),

cleaned AS (
    SELECT
        emp_id,
        emp_name,
        department,
        designation,
        salary,
        ph_no,
        EXTRACT(YEAR FROM hire_date) AS hire_year
        
    FROM source
),

masked AS (
    SELECT
        emp_id,
        CONCAT(SUBSTR(emp_name, 1, 1), '****') AS emp_name,
        department,
        '*****' as salary,
        hire_year,
        {{ validate_phone('ph_no') }} AS Phone_Number,
        {{salary_range('salary')}} as salary_range
       
    FROM cleaned
)

SELECT * FROM masked
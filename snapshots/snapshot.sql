{% snapshot emp_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='emp_id',
        strategy='check',
        check_cols=['department']
    )
}}

SELECT
    emp_id,
    emp_name,
    department,
    designation,
    salary,
    ph_no,
    hire_date
FROM {{ source('company_src', 'EMPLOYEES') }}

{% endsnapshot %}


SELECT * FROM SNAPSHOTS.EMP_SNAPSHOT






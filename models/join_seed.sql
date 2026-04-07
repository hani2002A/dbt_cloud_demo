SELECT 
    e.emp_id,
    e.emp_name,
    e.department,
    d.dept_code,
    d.dept_category
FROM {{ source('company_src', 'EMPLOYEES') }} e
LEFT JOIN {{ ref('seed_emp') }} d
    ON e.department = d.department